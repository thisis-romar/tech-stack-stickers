# Quick Start: Branch README Tool

## 🎯 Purpose
Automatically add branch-specific context to README.md files across all proposal branches.

## ⚡ Quick Commands

```powershell
# 1. Preview what will change (SAFE - no modifications)
.\scripts\update-branch-readmes.ps1 -DryRun

# 2. Apply changes to all branches
.\scripts\update-branch-readmes.ps1

# 3. Apply but review commits manually
.\scripts\update-branch-readmes.ps1 -SkipCommit
```

## 📊 What Gets Added

Each branch gets a new section explaining its organization:

```markdown
## 📂 Organization Strategy

**This branch uses: [Strategy Name]**

[Description]

### Directory Structure
### Categories  
### Benefits
### Ideal Use Case
```

## ✅ Next Steps After Running

1. **Review changes** on each branch
2. **Push to remote** to share updated READMEs:
   ```powershell
   git push --all origin
   ```
3. **Compare branches** to choose best approach
4. **Merge winner** into main when decided

## 🔍 Files Created

- `data/branch-contexts.json` - Configuration
- `scripts/update-branch-readmes.ps1` - Automation script
- `docs/BRANCH_README_TOOL.md` - Full documentation

## 📚 Full Documentation

See `docs/BRANCH_README_TOOL.md` for complete details.
