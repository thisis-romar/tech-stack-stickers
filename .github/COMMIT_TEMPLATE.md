# Commit Template (GIT-ATT-001 v1.1.0)

# Summary (Conventional Commit)
# <type>(<scope>): <subject>

# Body (wrap at 72 cols, bullets allowed)
# - What changed
# - Why it changed
# - Any side effects

AI-Attribution:
- Model: <platform/model-id> (Vendor)
- Session: <chat-session-uuid or manual-commit-YYYY-MM-DD-HHMM>
- Context: <brief context>

Co-authored-by: <Platform-Name> (<platform/model-id>) <admin+llm-[normalized-model-id]@emblemprojects.com>

# Examples
# feat(stickers): add colorized SVG export with brand hex
# 
# - Inject fill="#HEX" into <path> elements
# - Build slug→icon map from simple-icons named exports
# - Export 375/525/750px PNGs and catalog.json
# 
# AI-Attribution:
# - Model: copilot/claude-sonnet-4.5 (Anthropic)
# - Session: manual-commit-2025-11-05-1200
# - Context: Generator refactor and slug normalization
# 
# Co-authored-by: anthropic_Claude (copilot/claude-sonnet-4.5) <admin+llm-claude-sonnet-4-5@emblemprojects.com>
