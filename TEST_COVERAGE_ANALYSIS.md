# Test Coverage Analysis

## Current State

The project has **zero test coverage**. There are no test files, no test framework configured, and no test scripts defined in `package.json`. The sole source file (`scripts/fetch-icons.mjs`) contains multiple distinct functions but none are tested.

---

## Testable Units in `scripts/fetch-icons.mjs`

| Function | Lines | Purpose | Complexity |
|---|---|---|---|
| `getCurrentBranch()` | 26-32 | Detects git branch via `execSync` | Low |
| `loadCategoryMappings()` | 35-58 | Loads JSON, inverts slug-to-category map | Medium |
| `getIconBySlug(slug)` | 89-91 | Looks up icon from prebuilt Map | Low |
| `colorizeIcon(svg, hex)` | 93-97 | Injects `fill="#hex"` into SVG `<path>` tags | Low |
| `ensureDirs()` | 72-87 | Creates output directory structure | Medium |
| `writeSVG(slug, coloredSvg)` | 99-105 | Writes SVG file to categorized path | Low |
| `writePNGs(slug, coloredSvg, sizes)` | 107-122 | Renders SVG to PNG at 3 sizes via Sharp | Medium |
| `main()` | 124-169 | Orchestrates full pipeline | High |

---

## Proposed Test Areas

### 1. `colorizeIcon()` — Pure Function (Priority: High)

This is the most immediately testable function. It's a pure string transformation with no side effects.

**What to test:**
- Single `<path` element gets `fill="#hex"` injected
- Multiple `<path` elements all receive the fill attribute
- SVG content without `<path` elements is returned unchanged
- Various hex color values are inserted correctly
- Existing `fill` attributes are not clobbered (current implementation prepends a new `fill` before any existing one — this is a latent bug worth covering)

**Example test cases:**
```js
colorizeIcon('<path d="M0 0"/>', 'FF0000')
// → '<path fill="#FF0000" d="M0 0"/>'

colorizeIcon('<path d="M0 0"/><path d="M1 1"/>', '00FF00')
// → '<path fill="#00FF00" d="M0 0"/><path fill="#00FF00" d="M1 1"/>'

colorizeIcon('<rect width="10"/>', 'AABBCC')
// → '<rect width="10"/>'  (no paths, no change)
```

---

### 2. `getIconBySlug()` — Lookup Function (Priority: High)

Simple Map lookup, but critical to validate behavior for missing slugs.

**What to test:**
- Returns an icon object for a known slug (e.g., `"javascript"`)
- Returns `null` for an unknown slug
- Returns `null` for empty string / undefined input

---

### 3. `loadCategoryMappings()` — Category Map Inversion (Priority: Medium)

The slug-to-category inversion logic is a good candidate for unit testing with a mocked JSON file.

**What to test:**
- Correct inversion: given `{ "frontend": ["react", "vuedotjs"] }`, the returned Map has `"react" → "frontend"` and `"vuedotjs" → "frontend"`
- Returns `null` when the branch has no mapping (e.g., `"main"` branch yields `{}`)
- Handles empty category arrays gracefully
- Handles a slug appearing in multiple categories (last-write-wins behavior of the current loop — worth documenting)

**Latent bug to cover:** If the same slug appears in two categories in `category-mappings.json`, the last category wins silently. A test should document this behavior and potentially flag it.

---

### 4. Data Integrity — `tech-list.json` and `category-mappings.json` (Priority: Medium)

These JSON files are the project's core configuration. Validation tests catch drift and typos.

**What to test:**
- `tech-list.json` contains no duplicate slugs
- Every slug in `tech-list.json` exists in the `simple-icons` library (catches renames/removals on dependency upgrades)
- Every slug in `category-mappings.json` also exists in `tech-list.json` (no orphaned mappings)
- Every slug in `tech-list.json` has a mapping in at least proposal-1 (no uncategorized icons)
- Category names in the mappings are non-empty strings
- `catalog.json` entries each have required fields (`slug`, `title`, `hex`)

---

### 5. `writeSVG()` / `writePNGs()` — File Output (Priority: Medium)

Integration-style tests that verify files are written to the correct paths.

**What to test:**
- With a category mapping, SVG is written to `assets/svg/{category}/{slug}.svg`
- Without a category mapping, SVG is written to `assets/svg/{slug}.svg`
- PNG files are generated at all three sizes (`small`, `medium`, `large`)
- PNG output dimensions match the expected pixel widths (375, 525, 750)
- Output files are valid SVG/PNG (basic header/magic-byte checks)

**Approach:** Use a temp directory and mock `categoryMapping` to avoid touching real assets.

---

### 6. `ensureDirs()` — Directory Creation (Priority: Low)

**What to test:**
- With no category mapping, flat directories are created (`assets/svg/`, `assets/png/small/`, etc.)
- With a category mapping, subdirectories are created for each category
- Idempotent — running twice doesn't throw

---

### 7. `getCurrentBranch()` — Git Integration (Priority: Low)

**What to test:**
- Returns a branch name string when inside a git repo
- Returns `"main"` when `execSync` throws (e.g., not in a git repo)

---

### 8. `main()` — End-to-End Pipeline (Priority: Low, High Value)

A single integration test that runs the full pipeline against a small fixture (2-3 known slugs) and validates:
- SVGs are written with correct fill colors
- PNGs are generated at all three sizes
- `catalog.json` is produced with correct entries
- Missing slugs are reported and written to `missing-slugs.txt`

**Approach:** Set up a temp directory, provide a minimal `tech-list.json` fixture, and run `main()` against it.

---

## Recommended Test Framework Setup

Given this is a Node.js ESM project, **Vitest** is the best fit:
- Native ESM support (no transform hacks)
- Compatible with the existing `"type": "module"` configuration
- Built-in mocking for `fs`, `child_process`, and `sharp`
- Fast startup and watch mode

### Suggested `package.json` additions:
```json
{
  "devDependencies": {
    "vitest": "^3.0.0"
  },
  "scripts": {
    "test": "vitest run",
    "test:watch": "vitest"
  }
}
```

### Suggested file structure:
```
tests/
  colorize-icon.test.mjs       — Pure function tests
  get-icon-by-slug.test.mjs    — Lookup tests
  category-mappings.test.mjs   — Map inversion + data integrity
  data-integrity.test.mjs      — JSON validation tests
  write-outputs.test.mjs       — File I/O integration tests
  e2e.test.mjs                 — Full pipeline integration test
```

---

## Priority Summary

| Priority | Area | Effort | Impact |
|---|---|---|---|
| **High** | `colorizeIcon()` unit tests | Low | Catches SVG colorization regressions |
| **High** | `getIconBySlug()` unit tests | Low | Validates icon resolution |
| **Medium** | Data integrity tests | Low | Catches config drift on dependency upgrades |
| **Medium** | Category mapping inversion | Low | Documents inversion logic and edge cases |
| **Medium** | File output integration tests | Medium | Validates path construction and file generation |
| **Low** | `ensureDirs()` tests | Low | Directory creation is straightforward |
| **Low** | `getCurrentBranch()` tests | Low | Simple fallback behavior |
| **Low** | Full pipeline e2e test | Medium | Highest confidence but requires fixture setup |

---

## Identified Latent Bugs Worth Covering

1. **Double `fill` attribute:** `colorizeIcon()` uses `svg.replace(/<path /g, ...)` which injects `fill="#hex"` even if a `<path>` already has a `fill` attribute. This produces invalid SVG with duplicate `fill` attributes. A test should document this and a fix should check for existing `fill` before injecting.

2. **Duplicate slug in categories:** If the same slug appears in multiple categories within a proposal, the `for...of` loop in `loadCategoryMappings()` silently overwrites with the last category. Tests should document and guard against this.

3. **No input validation:** `colorizeIcon()` doesn't validate that `hex` is a valid 6-character hex string. Passing `undefined` or a malformed value produces `fill="#undefined"` in the SVG output.
