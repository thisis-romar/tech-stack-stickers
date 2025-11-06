# AI Attribution Standard (GIT-ATT-001 v1.1.0)

This repository follows Emblem Projects’ AI-attributed commit standard to transparently credit AI assistance while keeping humans accountable.

## Why this matters
- Preserves authorship and accountability
- Documents when/which AI models assisted
- Enables reproducible workflows and audits

## Commit message format (required)

Use Conventional Commits for the subject and body, then include an AI-Attribution block and one Co-authored-by trailer using the standardized email mapping.

```
<type>(<scope>): <subject>

<body paragraphs>

AI-Attribution:
- Model: <platform/model-id> (Vendor)
- Session: <chat-session-uuid or manual-commit-YYYY-MM-DD-HHMM>
- Context: <brief context of AI assistance>

Co-authored-by: <Platform-Name> (<platform/model-id>) <admin+llm-[normalized-model-id]@emblemprojects.com>
```

Example for this project:

```
feat(stickers): colorize SVGs with brand hex and export PNGs

- Inject fill="#HEX" into <path> elements prior to rasterization
- Build slug→icon map from simple-icons named exports
- Export 3 sizes (375/525/750px) and generate catalog.json

AI-Attribution:
- Model: copilot/claude-sonnet-4.5 (Anthropic)
- Session: manual-commit-2025-11-05-1200
- Context: Generator refactor and slug normalization

Co-authored-by: anthropic_Claude (copilot/claude-sonnet-4.5) <admin+llm-claude-sonnet-4-5@emblemprojects.com>
```

## Email mapping standard

Use the following deterministic mapping for the email in the Co-authored-by trailer:

```
admin+llm-[normalized-model-id]@emblemprojects.com
```

Normalization rules:
- Lowercase; replace spaces and punctuation with single hyphens
- Use vendor-stable model identifiers when available (e.g., claude-sonnet-4-5)

Examples:
- Claude Sonnet 4.5 via Copilot → normalized: `claude-sonnet-4-5` → email: `admin+llm-claude-sonnet-4-5@emblemprojects.com`
- GPT-4o via Copilot → normalized: `gpt-4o` → email: `admin+llm-gpt-4o@emblemprojects.com`

## Session tracking (recommended)

When possible, include the VS Code Copilot chat Session UUID:
- Preferred: Use the extractor tool to obtain `{UUID}` and set `Session: {UUID}`
- Fallback: If unavailable, use a descriptive timestamp slug `manual-commit-YYYY-MM-DD-HHMM`

## What requires AI attribution?
Attribute AI when it:
- Generates substantial code or config
- Designs architecture or data structures
- Performs complex debugging or refactors
- Authors significant documentation

Lightweight autocomplete, formatting, or trivial edits do not require attribution.

## Tooling and references
- Official standard: GIT-ATT-001 v1.1.0 (referenced from profile standards)
- Global hooks and commit template installer available in your VS Code profile (see profile docs)
- Tools: AI Model Detector (panel-only) and Copilot Chat Extractor verified operational

---
Last Updated: November 5, 2025
