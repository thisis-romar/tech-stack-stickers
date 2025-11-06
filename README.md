# Tech Stack Stickers

## 📂 Organization Strategy

**This branch uses: Flat Structure**

All icons in a single directory without categorization

### Directory Structure
```
assets/svg/*.svg
```

### Categories
- All icons in root directory

### Benefits
- Simple browsing - all icons in one place
- No categorization overhead
- Best for small collections or alphabetical browsing

### Ideal Use Case
Quick access when you know exactly which icon you need

---

Pipeline to compile a curated list of tech stack logos and export high-resolution **FULL-COLOR** SVG and PNG sticker assets in three sizes (Small, Medium, Large).

## ✅ Project Status
- **123 tech stack icons** successfully generated
- All icons exported in **FULL BRAND COLORS**
- 3 PNG sizes per icon (Small/Medium/Large)
- Total assets: 123 SVGs + 369 PNGs

## 🗂️ Asset Organization Proposals

This repository includes **4 different categorization schemes** for organizing the tech stack icons, each on a separate branch. All proposals include the same 123 icons but organize them into different category folders to suit different use cases.

### Available Proposals

| Branch | Categories | Philosophy |
|--------|-----------|------------|
| **[proposal-1-role-based](../../tree/proposal-1-role-based)** | 9 categories | Organize by technical role (Frontend, Backend, DevOps, etc.) |
| **[proposal-2-layer-based](../../tree/proposal-2-layer-based)** | 7 categories | Organize by application architecture layers (UI, Data, Platform, etc.) |
| **[proposal-3-ecosystem-based](../../tree/proposal-3-ecosystem-based)** | 11 categories | Organize by technology ecosystems (React, Python, JVM, etc.) |
| **[proposal-4-usecase-based](../../tree/proposal-4-usecase-based)** | 8 categories | Organize by developer use cases (Web Dev, Data Science, Cloud, etc.) |

### Switching Between Proposals

```bash
# Switch to a proposal branch
git checkout proposal-1-role-based

# View categories in that proposal
ls assets/svg

# Generate assets for the current proposal
npm run generate

# Verify the organization
pwsh scripts/verify-all-branches.ps1
```

### Category Mappings

Each proposal's category definitions are stored in `data/category-mappings.json`. The generator automatically detects the current branch and organizes assets accordingly.

📊 **See [PROPOSALS_COMPARISON.md](PROPOSALS_COMPARISON.md) for detailed comparison** of all 4 schemes with category breakdowns and recommendations.

## Goals
- Source icons from the Simple Icons catalog (permissive, vector SVGs with official brand colors).
- Export: SVG originals with injected brand colors and PNGs at three sizes suitable for sticker printing.
- Sizing: ensure 5x Large stickers fit on a 15" laptop lid without overlapping when arranged reasonably.

## Sizing assumptions
- Typical 15" laptop lid printable area: about 330mm x 220mm minus margins.
- Large sticker target max width: 65mm (2.56") so 5 across ~= 325mm total allowing small gaps.
- Medium: 45mm; Small: 32mm. Export at 300 DPI equivalent in pixels.

| Size  | mm   | px (rounded) |
|------ |----- |--------------|
| Small | 32mm | 375 px       |
| Medium| 45mm | 525 px       |
| Large | 65mm | 750 px       |

Note: PNG export sizes are the longest dimension, preserving aspect ratio.

## Color Implementation
All icons include their official brand colors:
- **SVG**: `fill="#HEX"` injected into all `<path>` elements
- **PNG**: Rendered from colorized SVG using Sharp library
- Colors sourced from Simple Icons official metadata

Sample colors:
- JavaScript: #F7DF1E (bright yellow)
- TypeScript: #3178C6 (blue)
- React: #61DAFB (cyan)
- Python: #3776AB (blue/yellow gradient in original)
- Docker: #2496ED (blue)

## Usage
1. Install Node 18+.
2. Install deps: `npm i`
3. Generate assets: `npm run generate`
4. Output folders:
   - SVG: `assets/svg` (one per slug, colorized)
   - PNG: `assets/png/{small,medium,large}` (3 sizes per icon)
   - Catalog: `data/catalog.json` (metadata with hex colors, sources, licenses)

## Tech Stack Coverage
123 icons across:
- **Languages**: JavaScript, TypeScript, Python, Go, Rust, Java (OpenJDK), C, C++, Scala, Kotlin, Swift, Dart, PHP, Ruby, Elixir, Erlang, Crystal
- **Frameworks**: React, Next.js, Vue, Nuxt, Svelte, Angular, Solid, Qwik, Astro, Django, Flask, FastAPI, Laravel, Symfony, Rails, Phoenix, Spring, Flutter
- **Tools**: Docker, Kubernetes, Terraform, Ansible, Webpack, Vite, Babel, ESLint, Prettier, Jest, Cypress, Storybook
- **Databases**: PostgreSQL, MySQL, MongoDB, Redis, SQLite, Neo4j, Elasticsearch
- **Cloud**: Google Cloud, Firebase, Vercel, Netlify, Cloudflare, Heroku, Supabase, DigitalOcean
- **DevOps**: GitHub, GitLab, Bitbucket, Grafana, Prometheus, Sentry, Datadog, Airflow, Airbyte
- **UI**: Tailwind CSS, Bootstrap, Material Design, Sass, HTML5, CSS

## Legal
- Brand marks are trademarks of their respective owners. Review brand guidelines before commercial printing.
- Simple Icons provides brand marks as SVG; check `data/catalog.json` for each icon's license metadata and source URL.
- This project uses Simple Icons under their respective licenses (most are CC0 or permissive).

## Files Generated
```
assets/
├── svg/              # 123 colorized SVG files
└── png/
    ├── small/        # 123 × 375px PNGs
    ├── medium/       # 123 × 525px PNGs
    └── large/        # 123 × 750px PNGs
data/
└── catalog.json      # Icon metadata (title, hex, source, license)
```

