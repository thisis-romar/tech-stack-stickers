# Branch README Contextualization Tool

Automatically updates README.md files across all proposal branches with branch-specific organizational context.

## 📁 Files Created

### 1. `data/branch-contexts.json`
Configuration file defining each branch's organizational strategy:
- Branch metadata (name, strategy, description)
- Directory structure patterns
- Category listings
- Benefits and use cases

### 2. `scripts/update-branch-readmes.ps1`
PowerShell automation script that:
- Reads branch configurations
- Iterates through all branches
- Injects/updates "Organization Strategy" section in README
- Commits changes with proper AI attribution
- Returns to original branch when complete

## 🚀 Usage

### Dry Run (Preview Changes)
```powershell
.\scripts\update-branch-readmes.ps1 -DryRun
```
Shows what would be changed without modifying any files.

### Apply Changes
```powershell
.\scripts\update-branch-readmes.ps1
```
Updates all branch READMEs and commits changes.

### Apply Without Committing
```powershell
.\scripts\update-branch-readmes.ps1 -SkipCommit
```
Updates files but doesn't commit (for manual review).

## 📋 What It Does

### For Each Branch:
1. Checks out the branch
2. Reads current README.md
3. Inserts/updates "## 📂 Organization Strategy" section
4. Includes:
   - Strategy name and description
   - Directory structure
   - Category listings
   - Benefits
   - Ideal use cases
5. Commits with AI attribution (GIT-ATT-001 v1.1.0 compliant)
6. Moves to next branch

### Branches Processed:
- ✅ `main` - Flat structure
- ✅ `proposal-1-role-based` - Role-based organization
- ✅ `proposal-2-layer-based` - Architecture layer organization
- ✅ `proposal-3-ecosystem-based` - Technology ecosystem organization
- ✅ `proposal-4-usecase-based` - Use case organization

## 🎯 Example Output

The script adds this section to each README (content varies by branch):

```markdown
## 📂 Organization Strategy

**This branch uses: Technology Ecosystem Organization**

Icons grouped by technology families and ecosystems

### Directory Structure
```
assets/svg/{ecosystem}/*.svg
```

### Categories
- `cloud-platforms/`
- `databases/`
- `devops-cncf/`
- `react-ecosystem/`
- `python-ecosystem/`
...

### Benefits
- Natural grouping by technology communities
- Easy to find complementary tools
- Reflects how developers identify ("I'm a React developer")
- Great for ecosystem-specific sticker sets

### Ideal Use Case
"Give me all React-related tools" or "What's in the Python ecosystem?"
```

## 🔧 Customization

### Edit Branch Contexts
Modify `data/branch-contexts.json` to:
- Update descriptions
- Change category listings
- Add/remove benefits
- Adjust use case examples

### Commit Message Format
The script follows GIT-ATT-001 v1.1.0:
- Conventional Commits header
- Detailed body
- AI-Attribution block
- Single Co-authored-by trailer

## ✅ Safety Features

- **Non-destructive**: Preserves all existing README content
- **Idempotent**: Can run multiple times safely (updates existing section)
- **Dry-run mode**: Preview changes before applying
- **Error handling**: Gracefully handles missing files/branches
- **Branch restoration**: Returns to original branch after completion

## 📊 Expected Results

After running, each branch will have a contextualized README explaining:
- Why this organizational strategy was chosen
- How assets are structured
- What benefits it provides
- When to use this approach

This makes it easy for developers to understand the differences between proposals and choose the best organization for their needs.
