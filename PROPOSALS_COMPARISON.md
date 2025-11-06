# Asset Organization Proposals Comparison

This document provides a detailed comparison of the 4 categorization schemes for organizing tech stack sticker assets.

## Overview

All 4 proposals include the same **123 tech stack icons** with full brand colors, but organize them into different category folders to support different organizational philosophies and use cases.

## Verification Status

All proposals have been verified clean using the automated verification script:

```bash
pwsh scripts/verify-all-branches.ps1
```

**Results**: ✅ All 4 branches PASS validation
- Correct number of categories per proposal
- Exactly 123 icons across all categories
- No duplicate files
- PNG folders match SVG organization

---

## Proposal 1: Role-Based Organization
**Branch**: `proposal-1-role-based`  
**Categories**: 9  
**Philosophy**: Organize by technical role or job function

### Categories & Icon Counts

| Category | Icons | Description |
|----------|-------|-------------|
| **frontend** | 18 | UI frameworks, styling, visualization (React, Vue, Tailwind, D3) |
| **backend** | 9 | Server-side frameworks (Django, Flask, Spring, Rails) |
| **languages** | 21 | Programming languages (JS, Python, Rust, Go, Java, C++) |
| **devops** | 9 | CI/CD, containers, version control (Docker, Kubernetes, GitHub) |
| **databases** | 9 | Data storage systems (PostgreSQL, MongoDB, Redis, Kafka) |
| **cloud** | 8 | Cloud platforms and services (GCP, Firebase, Vercel, Heroku) |
| **data-ml** | 13 | Data science and ML tools (Pandas, TensorFlow, PyTorch, Jupyter) |
| **mobile** | 6 | Mobile development (Android, iOS, Flutter, Xcode) |
| **tooling** | 30 | Dev tools, build systems, observability (Webpack, Grafana, Jest) |

### Best For
- **Teams organized by role** (frontend devs, backend devs, data engineers)
- **Job postings** requiring specific role expertise
- **Skill categorization** on resumes or portfolios
- **Learning paths** focused on career specialization

### Sample Icons by Category
```
frontend/    → react.svg, vuedotjs.svg, angular.svg, tailwindcss.svg
backend/     → django.svg, flask.svg, spring.svg, laravel.svg
languages/   → javascript.svg, python.svg, rust.svg, go.svg
```

---

## Proposal 2: Layer-Based Organization
**Branch**: `proposal-2-layer-based`  
**Categories**: 7  
**Philosophy**: Organize by application architecture layers

### Categories & Icon Counts

| Category | Icons | Description |
|----------|-------|-------------|
| **languages** | 22 | Core programming languages |
| **ui-layer** | 15 | Frontend presentation layer (frameworks, styling) |
| **application-layer** | 12 | Application logic and server frameworks |
| **data-layer** | 9 | Databases and message queues |
| **platform-layer** | 5 | Infrastructure and orchestration (Docker, Kubernetes) |
| **cloud-services** | 8 | Cloud platforms and deployment services |
| **developer-tools** | 52 | Build tools, CI/CD, monitoring, libraries, IDE tools |

### Best For
- **Software architects** designing system layers
- **Microservices teams** working on specific layers
- **Documentation** organized by architectural concerns
- **Tech stack diagrams** showing layer separation
- **Teams using layered architecture** (MVC, N-tier, hexagonal)

### Sample Icons by Category
```
ui-layer/          → react.svg, vuedotjs.svg, html5.svg, css.svg
application-layer/ → django.svg, nextdotjs.svg, spring.svg
data-layer/        → postgresql.svg, mongodb.svg, redis.svg
platform-layer/    → docker.svg, kubernetes.svg, linux.svg
```

---

## Proposal 3: Ecosystem-Based Organization
**Branch**: `proposal-3-ecosystem-based`  
**Categories**: 11  
**Philosophy**: Organize by technology ecosystems and vendor stacks

### Categories & Icon Counts

| Category | Icons | Description |
|----------|-------|-------------|
| **web-core** | 5 | Fundamental web technologies (HTML, CSS, JS, TS, WebAssembly) |
| **react-ecosystem** | 3 | React and related tools (React, Next.js, Vite) |
| **vue-ecosystem** | 2 | Vue.js family (Vue, Nuxt) |
| **python-ecosystem** | 15 | Python language and major frameworks/tools |
| **jvm-ecosystem** | 7 | Java/JVM languages and tools (OpenJDK, Kotlin, Scala, Spring) |
| **microsoft-stack** | 3 | Microsoft technologies (.NET, C#, F#) |
| **google-stack** | 5 | Google technologies (GCP, Firebase, Angular, Dart, Flutter) |
| **devops-cncf** | 5 | CNCF DevOps tools (Docker, Kubernetes, Helm, Prometheus, Grafana) |
| **databases** | 9 | All database systems |
| **cloud-platforms** | 6 | Cloud infrastructure providers |
| **independent-tools** | 64 | Framework-agnostic tools and libraries |

### Best For
- **Companies standardized on specific ecosystems** (Python shop, Java house)
- **Technology evaluation** comparing competing ecosystems
- **Learning resources** focused on mastering one ecosystem
- **Vendor preference** organizations (Google shop, Microsoft-focused)
- **Polyglot teams** with clear ecosystem boundaries

### Sample Icons by Category
```
python-ecosystem/  → python.svg, django.svg, flask.svg, pandas.svg, jupyter.svg
react-ecosystem/   → react.svg, nextdotjs.svg, vite.svg
jvm-ecosystem/     → openjdk.svg, kotlin.svg, spring.svg, gradle.svg
google-stack/      → googlecloud.svg, firebase.svg, angular.svg, flutter.svg
```

---

## Proposal 4: Use-Case-Based Organization
**Branch**: `proposal-4-usecase-based`  
**Categories**: 8  
**Philosophy**: Organize by developer tasks and project types

### Categories & Icon Counts

| Category | Icons | Description |
|----------|-------|-------------|
| **web-development** | 23 | Full-stack web development tools and frameworks |
| **backend-api** | 19 | API servers, backend frameworks, databases |
| **mobile-apps** | 8 | Mobile application development |
| **data-science** | 5 | Data analysis and exploration (Jupyter, Pandas, NumPy) |
| **machine-learning** | 7 | ML/AI training and deployment |
| **cloud-deployment** | 14 | Cloud infrastructure and DevOps |
| **collaboration** | 14 | Team tools, monitoring, project management |
| **systems-programming** | 33 | Low-level languages, compilers, system utilities |

### Best For
- **Project-based work** where team focus shifts between use cases
- **Bootcamps and education** teaching specific project types
- **Freelancers** showcasing services (web dev, mobile apps, ML)
- **Product teams** working on specific features
- **Portfolio organization** by project type

### Sample Icons by Category
```
web-development/ → react.svg, nextdotjs.svg, tailwindcss.svg, webpack.svg
backend-api/     → django.svg, flask.svg, postgresql.svg, redis.svg
mobile-apps/     → flutter.svg, android.svg, ios.svg, swift.svg
data-science/    → jupyter.svg, pandas.svg, numpy.svg, scikitlearn.svg
machine-learning/ → tensorflow.svg, pytorch.svg, openai.svg
```

---

## Comparison Matrix

| Feature | Proposal 1<br/>Role-Based | Proposal 2<br/>Layer-Based | Proposal 3<br/>Ecosystem | Proposal 4<br/>Use-Case |
|---------|---------------------------|----------------------------|--------------------------|------------------------|
| **Categories** | 9 | 7 | 11 | 8 |
| **Granularity** | Medium | Coarse | Fine | Medium |
| **Team Alignment** | By role | By architecture | By tech stack | By project type |
| **Best for beginners** | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Best for architects** | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |
| **Best for polyglot teams** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| **Vendor-neutral** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Maintenance** | Easy | Easy | Medium | Easy |

---

## Choosing a Proposal

### Choose **Proposal 1 (Role-Based)** if:
- ✅ Your team is organized by engineering roles
- ✅ You're creating a skills matrix or learning roadmap
- ✅ You need clear separation between frontend/backend/data roles
- ✅ You're hiring and need to categorize job requirements

### Choose **Proposal 2 (Layer-Based)** if:
- ✅ You're documenting system architecture
- ✅ Your team uses layered architecture patterns
- ✅ You need to show separation of concerns in diagrams
- ✅ You're teaching software architecture concepts

### Choose **Proposal 3 (Ecosystem-Based)** if:
- ✅ Your organization is committed to specific technology ecosystems
- ✅ You're comparing ecosystem alternatives (React vs Vue, Python vs Java)
- ✅ You have vendor preferences (Google shop, Microsoft-focused)
- ✅ You want tight coupling of related tools in one ecosystem

### Choose **Proposal 4 (Use-Case-Based)** if:
- ✅ Your work is organized by project types
- ✅ You're a freelancer showcasing different service offerings
- ✅ You're teaching practical project-based courses
- ✅ You want the most intuitive categories for beginners
- ✅ Team members switch between different types of work

---

## Technical Implementation

All proposals use the same underlying generator (`scripts/fetch-icons.mjs`) with automatic branch detection:

```javascript
// Generator automatically detects branch and loads appropriate categories
const branch = getCurrentBranch();  // e.g., "proposal-3-ecosystem-based"
const categoryMapping = loadCategoryMappings(branch);
```

### Category Mappings

All category definitions are centralized in `data/category-mappings.json`:

```json
{
  "proposal-1-role-based": {
    "frontend": ["react", "vuedotjs", "angular", ...],
    "backend": ["django", "flask", "spring", ...],
    ...
  },
  "proposal-2-layer-based": { ... },
  ...
}
```

### Verification

Automated validation ensures data quality:

```bash
# Verify all proposals
pwsh scripts/verify-all-branches.ps1

# Clean contaminated PNG folders
pwsh scripts/cleanup-png-folders.ps1
```

---

## Contributing

To propose a new categorization scheme:

1. Create a new branch: `git checkout -b proposal-5-your-scheme`
2. Add your category mapping to `data/category-mappings.json`
3. Run the generator: `npm run generate`
4. Verify: `pwsh scripts/verify-all-branches.ps1`
5. Submit a PR with your proposal and rationale

---

## Metadata

- **Last Updated**: November 6, 2025
- **Total Icons**: 123
- **Proposals**: 4
- **Verification**: Automated via `verify-all-branches.ps1`
- **All proposals include full AI attribution** following [GIT-ATT-001 v1.1.0](https://github.com/emblem-os/git-attribution-standards)
