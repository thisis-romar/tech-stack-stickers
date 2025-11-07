# GitHub Copilot Instructions# GitHub Copilot Instructions



This project generates tech stack stickers for networking events and conferences.This project generates tech stack stickers for networking events and conferences.



## Project Context## Project Context

- **Purpose**: Generate high-resolution, full-color tech stack logo stickers- **Purpose**: Generate high-resolution, full-color tech stack logo stickers

- **Tech Stack**: Node.js (ESM), Sharp (image processing), Simple Icons (icon source)- **Tech Stack**: Node.js (ESM), Sharp (image processing), Simple Icons (icon source)

- **Output**: SVG + PNG assets in 3 sizes optimized for Cricut sticker printing- **Output**: SVG + PNG assets in 3 sizes optimized for Cricut sticker printing

- **Sizing Goal**: 5× large stickers fit on a 15" laptop lid- **Sizing Goal**: 5× large stickers fit on a 15" laptop lid



## Code Style & Conventions## Code Style & Conventions

- Use ES modules (`import`/`export`)- Use ES modules (`import`/`export`)

- Prefer async/await over callbacks- Prefer async/await over callbacks

- Use descriptive variable names (e.g., `iconsBySlug` not `icons`)- Use descriptive variable names (e.g., `iconsBySlug` not `icons`)

- 2-space indentation- 2-space indentation

- Single quotes for strings- Single quotes for strings

- Semicolons required- Semicolons required



## Icon Management## Icon Management

- All icons sourced from Simple Icons (https://simpleicons.org)- All icons sourced from Simple Icons (https://simpleicons.org)

- Slugs must match Simple Icons slug format (lowercase, no hyphens become one word)- Slugs must match Simple Icons slug format (lowercase, no hyphens become one word)

- Colors injected via `fill="#HEX"` in SVG `<path>` elements- Colors injected via `fill="#HEX"` in SVG `<path>` elements

- PNG sizes: Small 375px, Medium 525px, Large 750px- PNG sizes: Small 375px, Medium 525px, Large 750px



## File Organization## File Organization

``````

data/data/

  tech-list.json      # Curated icon slugs  tech-list.json      # Curated icon slugs

  catalog.json        # Generated metadata  catalog.json        # Generated metadata

scripts/scripts/

  fetch-icons.mjs     # Main generator  fetch-icons.mjs     # Main generator

assets/assets/

  svg/                # Colorized SVG output  svg/                # Colorized SVG output

  png/{small,medium,large}/  # PNG renders  png/{small,medium,large}/  # PNG renders

``````



## Common Tasks## Common Tasks

- Add new icon: Update `data/tech-list.json` with valid Simple Icons slug- Add new icon: Update `data/tech-list.json` with valid Simple Icons slug

- Regenerate assets: `npm run generate`- Regenerate assets: `npm run generate`

- Verify color: Check SVG contains `fill="#[HEX]"` attribute- Verify color: Check SVG contains `fill="#[HEX]"` attribute



## AI Attribution## AI Attribution

This project uses Emblem Projects' GIT-ATT-001 v1.1.0 standard.This project uses Emblem Projects’ GIT-ATT-001 v1.1.0 standard.



### Model Detection (Required)Required commit footer for AI-assisted changes:



**Always use the AI Model Detector MCP** to ensure accurate attribution:```

AI-Attribution:

1. Activate the tool before committing:- Model: <platform/model-id> (Vendor)

   ```- Session: <chat-session-uuid or manual-commit-YYYY-MM-DD-HHMM>

   activate_ai_model_detection_tools- Context: <brief context>

   ```

Co-authored-by: <Platform-Name> (<platform/model-id>) <admin+llm-[normalized-model-id]@emblemprojects.com>

2. Detect the current model:```

   ```

   mcp_ai-model-dete_detect_current_modelExamples:

   ```- Claude Sonnet 4.5 via Copilot →

  - Model: `copilot/claude-sonnet-4.5 (Anthropic)`

3. Use the returned `name` and `vendor` in your commit attribution  - Trailer: `Co-authored-by: anthropic_Claude (copilot/claude-sonnet-4.5) <admin+llm-claude-sonnet-4-5@emblemprojects.com>`

- GitHub Copilot (GPT-4o) →

The MCP reads the active model from VS Code's internal SQLite database, ensuring commits reflect the **actual** agent assisting you. This eliminates guesswork and prevents attribution errors.  - Model: `copilot/gpt-4o (OpenAI)`

  - Trailer: `Co-authored-by: github_Copilot (copilot/gpt-4o) <admin+llm-gpt-4o@emblemprojects.com>`

### Commit Attribution Format

Tips:

Required commit footer for AI-assisted changes:- Prefer including a real Session UUID; fallback to `manual-commit-YYYY-MM-DD-HHMM` when needed.

- Keep only one Co-authored-by trailer.

``` 

AI-Attribution:## Commit message spec (required)

- Model: <platform/model-id> (Vendor)

- Session: <chat-session-uuid or manual-commit-YYYY-MM-DD-HHMM>Follow Conventional Commits for the header/body, then append the AI-Attribution block and a single Co-authored-by trailer per GIT-ATT-001 v1.1.0.

- Context: <brief context>

1) Conventional header

Co-authored-by: <Platform-Name> (<platform/model-id>) <admin+llm-[normalized-model-id]@emblemprojects.com>- Format: `<type>(<scope>): <subject>`

```- Subject: imperative mood, concise, no trailing period

- Common types: `feat`, `fix`, `docs`, `refactor`, `chore`, `test`, `build`, `ci`, `perf`, `style`

### Attribution Workflow

2) Allowed scopes for this project

1. **Detect the model** (before every commit):- `stickers`, `generator`, `scripts`, `data`, `assets`, `docs`, `ci`, `build`, `release`, `config`

   ```

   mcp_ai-model-dete_detect_current_model3) Body guidelines

   ```- Wrap lines at ~72 chars

- Explain the what/why, notable trade-offs, and side effects

2. **Extract the metadata**:- Use bullet points for lists

   - Model ID: use the `name` field (e.g., `copilot/claude-sonnet-4.5`)- Breaking changes: add a separate footer line `BREAKING CHANGE: <details>`

   - Vendor: use the `vendor` field (e.g., `Anthropic`)

4) AI-Attribution block (must include)

3. **Generate normalized email**:```

   - Take the model IDAI-Attribution:

   - Convert to lowercase- Model: <platform/model-id> (Vendor)

   - Replace spaces and punctuation with dashes- Session: <chat-session-uuid or manual-commit-YYYY-MM-DD-HHMM>

   - Format: `admin+llm-[normalized-id]@emblemprojects.com`- Context: <brief context of AI assistance>

```

4. **Build the attribution block**:

   - Include Model, Session (UUID or manual timestamp), and Context5) Co-authored-by trailer (single, required)

   - Add single Co-authored-by trailer with normalized email```

Co-authored-by: <Platform-Name> (<platform/model-id>) <admin+llm-[normalized-model-id]@emblemprojects.com>

5. **Commit with the block** appended to your conventional commit message```



### Examples (Verified via MCP)Email mapping standard:

- Deterministic: `admin+llm-[normalized-model-id]@emblemprojects.com`

Claude Sonnet 4.5 via Copilot:- Normalize model id (lowercase; spaces/punct → dashes)

```

AI-Attribution:Examples:

- Model: copilot/claude-sonnet-4.5 (Anthropic)- Claude Sonnet 4.5 via Copilot →

- Session: manual-commit-2025-11-05-1920  - Model: `copilot/claude-sonnet-4.5 (Anthropic)`

- Context: Feature implementation and testing  - Trailer: `Co-authored-by: anthropic_Claude (copilot/claude-sonnet-4.5) <admin+llm-claude-sonnet-4-5@emblemprojects.com>`

- GitHub Copilot (GPT-4o) →

Co-authored-by: anthropic_Claude (copilot/claude-sonnet-4.5) <admin+llm-claude-sonnet-4-5@emblemprojects.com>  - Model: `copilot/gpt-4o (OpenAI)`

```  - Trailer: `Co-authored-by: github_Copilot (copilot/gpt-4o) <admin+llm-gpt-4o@emblemprojects.com>`



GitHub Copilot (GPT-4o):When to attribute AI (include the block + trailer):

```- Substantial code or config generation

AI-Attribution:- Architectural design or significant refactors

- Model: copilot/gpt-4o (OpenAI)- Complex debugging or test generation

- Session: manual-commit-2025-11-05-1920- Authoring meaningful documentation

- Context: Code generation and refactoring

When not required:

Co-authored-by: github_Copilot (copilot/gpt-4o) <admin+llm-gpt-4o@emblemprojects.com>- Trivial autocomplete, formatting, or minor edits

```

## Quick examples

### Tips

- **Never guess** the model ID—always verify with the MCP toolFeature example:

- Prefer real Session UUIDs from Copilot chat extractor; fallback to `manual-commit-YYYY-MM-DD-HHMM````

- Keep only one Co-authored-by trailer per commitfeat(generator): colorize SVGs and export 3 PNG sizes

- Run detection immediately before committing to catch model switches

 - Add SVG path fill attribute with the brand color before rasterization

## Commit message spec (required)- Build slug→icon map from simple-icons named exports

- Export 375/525/750px PNGs; add data/catalog.json

Follow Conventional Commits for the header/body, then append the AI-Attribution block and a single Co-authored-by trailer per GIT-ATT-001 v1.1.0.

AI-Attribution:

1) Conventional header- Model: copilot/claude-sonnet-4.5 (Anthropic)

- Format: `<type>(<scope>): <subject>`- Session: manual-commit-2025-11-05-1200

- Subject: imperative mood, concise, no trailing period- Context: Generator refactor and slug normalization

- Common types: `feat`, `fix`, `docs`, `refactor`, `chore`, `test`, `build`, `ci`, `perf`, `style`

Co-authored-by: anthropic_Claude (copilot/claude-sonnet-4.5) <admin+llm-claude-sonnet-4-5@emblemprojects.com>

2) Allowed scopes for this project```

- `stickers`, `generator`, `scripts`, `data`, `assets`, `docs`, `ci`, `build`, `release`, `config`

Fix example:

3) Body guidelines```

- Wrap lines at ~72 charsfix(data): correct simple-icons slugs for nextdotjs and openjdk

- Explain the what/why, notable trade-offs, and side effects

- Use bullet points for lists- Replace invalid slugs and regenerate catalog

- Breaking changes: add a separate footer line `BREAKING CHANGE: <details>`- Verifies colorized SVGs include fill attributes



4) AI-Attribution block (must include)AI-Attribution:

```- Model: copilot/gpt-4o (OpenAI)

AI-Attribution:- Session: manual-commit-2025-11-05-1215

- Model: <platform/model-id> (Vendor)- Context: Slug validation and rerun of generator

- Session: <chat-session-uuid or manual-commit-YYYY-MM-DD-HHMM>

- Context: <brief context of AI assistance>Co-authored-by: github_Copilot (copilot/gpt-4o) <admin+llm-gpt-4o@emblemprojects.com>

``````



5) Co-authored-by trailer (single, required)Docs example:

``````

Co-authored-by: <Platform-Name> (<platform/model-id>) <admin+llm-[normalized-model-id]@emblemprojects.com>docs(attribution): adopt GIT-ATT-001 v1.1.0 commit spec

```

- Add commit template and git config template

Email mapping standard:- Update AI-Attribution guidance and examples

- Deterministic: `admin+llm-[normalized-model-id]@emblemprojects.com`

- Normalize model id (lowercase; spaces/punct → dashes)AI-Attribution:

- Model: copilot/claude-sonnet-4.5 (Anthropic)

When to attribute AI (include the block + trailer):- Session: manual-commit-2025-11-05-1230

- Substantial code or config generation- Context: Repo documentation alignment to verified standard

- Architectural design or significant refactors

- Complex debugging or test generationCo-authored-by: anthropic_Claude (copilot/claude-sonnet-4.5) <admin+llm-claude-sonnet-4-5@emblemprojects.com>

- Authoring meaningful documentation```



When not required:## Validation & tooling

- Trivial autocomplete, formatting, or minor edits

- Commit template: `.github/COMMIT_TEMPLATE.md` (set per-repo if desired)

## Quick examples- Git author/email quick refs: `.github/GIT_CONFIG_TEMPLATE.md`

- Prefer real Session UUIDs via your Copilot chat extractor; fall back to `manual-commit-YYYY-MM-DD-HHMM` when unavailable

Feature example:- Keep a single Co-authored-by trailer

```## Dependencies

feat(generator): colorize SVGs and export 3 PNG sizes- `simple-icons`: Official brand icon collection

- `sharp`: High-performance image processing

- Add SVG path fill attribute with the brand color before rasterization
- Build slug→icon map from simple-icons named exports
- Export 375/525/750px PNGs; add data/catalog.json

AI-Attribution:
- Model: copilot/claude-sonnet-4.5 (Anthropic)
- Session: manual-commit-2025-11-05-1200
- Context: Generator refactor and slug normalization

Co-authored-by: anthropic_Claude (copilot/claude-sonnet-4.5) <admin+llm-claude-sonnet-4-5@emblemprojects.com>
```

Fix example:
```
fix(data): correct simple-icons slugs for nextdotjs and openjdk

- Replace invalid slugs and regenerate catalog
- Verifies colorized SVGs include fill attributes

AI-Attribution:
- Model: copilot/gpt-4o (OpenAI)
- Session: manual-commit-2025-11-05-1215
- Context: Slug validation and rerun of generator

Co-authored-by: github_Copilot (copilot/gpt-4o) <admin+llm-gpt-4o@emblemprojects.com>
```

Docs example:
```
docs(attribution): adopt GIT-ATT-001 v1.1.0 commit spec

- Add commit template and git config template
- Update AI-Attribution guidance and examples

AI-Attribution:
- Model: copilot/claude-sonnet-4.5 (Anthropic)
- Session: manual-commit-2025-11-05-1230
- Context: Repo documentation alignment to verified standard

Co-authored-by: anthropic_Claude (copilot/claude-sonnet-4.5) <admin+llm-claude-sonnet-4-5@emblemprojects.com>
```

## Validation & tooling

- **MCP Tool**: AI Model Detector for accurate model identification
- Commit template: `.github/COMMIT_TEMPLATE.md` (set per-repo if desired)
- Git author/email quick refs: `.github/GIT_CONFIG_TEMPLATE.md`
- Prefer real Session UUIDs via your Copilot chat extractor; fall back to `manual-commit-YYYY-MM-DD-HHMM` when unavailable
- Keep a single Co-authored-by trailer

## AI Model Identity Protocol - STRICT RULES ⚠️

**CRITICAL**: When asked about AI model identity or before making attributed commits:

### ✅ REQUIRED: Tool-Based Detection Only
1. **Activate detection tools**:
   ```
   activate_ai_model_detection_tools
   ```

2. **Run detection in current session**:
   ```
   mcp_ai-model-dete_detect_current_model
   ```

3. **Use ONLY current tool results**:
   - Model ID from `name` field
   - Vendor from `vendor` field
   - No caching, no assumptions

### ❌ FORBIDDEN: Educated Guessing
**NEVER** claim model identity based on:
- ❌ Previous detection results from earlier in conversation
- ❌ Response patterns or writing style
- ❌ Conversation context or memory
- ❌ "I think I am..." or "Based on patterns, I appear to be..."

### 🚨 When Detection Tool Unavailable

**Required Response**:
```
I cannot determine my current model identity. The detection tool is 
unavailable or disabled. Previous detection results may be stale and 
should not be trusted for commit attribution.
```

**For Commits**:
- ❌ DO NOT create AI-attributed commits without current detection
- ✅ USE fallback attribution:
  ```
  AI-Attribution:
  - Model: UNKNOWN (detection-tool-unavailable)
  - Session: manual-verification-needed-YYYY-MM-DD-HHMM
  - Context: [context] ⚠️ Model identity not verified
  
  Co-authored-by: Unknown_AI_Model (unknown) <admin+llm-unknown@emblemprojects.com>
  ```

### 📋 Pre-Commit Validation Checklist

Before every AI-attributed commit, verify:
- [ ] Detection tool activated in current session
- [ ] Tool returned SUCCESS (not error/disabled)
- [ ] Model ID and Vendor extracted from tool output
- [ ] No guessing or assumptions made
- [ ] Timestamp or Session UUID is current

**Reject commits that**:
- Cite "based on previous detection"
- Cite "my response patterns suggest"
- Lack current tool verification

**If tool fails**: Use UNKNOWN fallback or skip AI attribution entirely

## Dependencies
- `simple-icons`: Official brand icon collection
- `sharp`: High-performance image processing
