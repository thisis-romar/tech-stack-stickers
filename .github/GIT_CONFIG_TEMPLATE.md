# Git Config Template for AI-Attributed Commits

Use these commands to set the local author identity for AI-assisted commits.
Replace the name/email as needed per model.

# Claude Sonnet 4.5 via Copilot (Anthropic)
# Name matches trailer prefix; email uses normalized model id
#
# git config --local user.name "anthropic_Claude (copilot/claude-sonnet-4.5)"
# git config --local user.email "admin+llm-claude-sonnet-4-5@emblemprojects.com"

# GitHub Copilot (GPT-4o, OpenAI)
# git config --local user.name "github_Copilot (copilot/gpt-4o)"
# git config --local user.email "admin+llm-gpt-4o@emblemprojects.com"

# Verify
# git config --local user.name
# git config --local user.email

# Optional: set commit template for this repo
# git config --local commit.template ".github/COMMIT_TEMPLATE.md"
