#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Updates README.md files across all branches with branch-specific context.

.DESCRIPTION
    This script iterates through all proposal branches and the main branch,
    updating each README.md with a contextual section explaining the branch's
    organizational strategy for asset management.

.NOTES
    Author: Tech Stack Stickers Project
    Requires: PowerShell 7+, Git, branch-contexts.json
    AI-Attribution: Built with GitHub Copilot assistance
#>

param(
    [switch]$DryRun,
    [switch]$SkipCommit
)

$ErrorActionPreference = "Stop"

# Color output functions
function Write-Info { Write-Host "ℹ️  $args" -ForegroundColor Cyan }
function Write-Success { Write-Host "✅ $args" -ForegroundColor Green }
function Write-Warning { Write-Host "⚠️  $args" -ForegroundColor Yellow }
function Write-Error { Write-Host "❌ $args" -ForegroundColor Red }

# Load branch context configuration
$configPath = Join-Path $PSScriptRoot ".." "data" "branch-contexts.json"
if (-not (Test-Path $configPath)) {
    Write-Error "Configuration file not found: $configPath"
    exit 1
}

Write-Info "Loading branch contexts from: $configPath"
$config = Get-Content $configPath -Raw | ConvertFrom-Json

# Get current branch to restore later
$originalBranch = git branch --show-current
Write-Info "Current branch: $originalBranch"

# Function to generate README section for a branch
function Get-ReadmeSection {
    param($branchConfig)

    $categories = if ($branchConfig.categories) {
        ($branchConfig.categories | ForEach-Object { "- ``$_/``" }) -join "`n"
    } else {
        "- All icons in root directory"
    }

    $benefits = ($branchConfig.benefits | ForEach-Object { "- $_" }) -join "`n"

    return @"

## 📂 Organization Strategy

**This branch uses: $($branchConfig.strategy)**

$($branchConfig.description)

### Directory Structure
``````
$($branchConfig.structure)
``````

### Categories
$categories

### Benefits
$benefits

### Ideal Use Case
$($branchConfig.useCase)

---

"@
}

# Function to update README for a branch
function Update-BranchReadme {
    param(
        [string]$branchName,
        [object]$branchConfig
    )

    Write-Info "Processing branch: $branchName"

    # Checkout the branch
    try {
        git checkout $branchName 2>&1 | Out-Null
        Write-Success "Checked out branch: $branchName"
    } catch {
        Write-Error "Failed to checkout branch: $branchName"
        return $false
    }

    # Check if README exists
    $readmePath = "README.md"
    if (-not (Test-Path $readmePath)) {
        Write-Warning "README.md not found in branch: $branchName"
        return $false
    }

    # Read current README
    $readmeContent = Get-Content $readmePath -Raw

    # Generate new section
    $newSection = Get-ReadmeSection -branchConfig $branchConfig

    # Check if section already exists
    $sectionMarker = "## 📂 Organization Strategy"
    $hasSection = $readmeContent -match [regex]::Escape($sectionMarker)

    if ($hasSection) {
        Write-Info "Updating existing Organization Strategy section..."
        
        # Remove old section (from marker to next ## heading or end)
        $pattern = "(?s)## 📂 Organization Strategy.*?(?=\n## |\z)"
        $readmeContent = $readmeContent -replace $pattern, ""
    } else {
        Write-Info "Adding new Organization Strategy section..."
    }

    # Insert new section after status section
    $insertPattern = "(## ✅ Project Status.*?(?=\n## ))"
    if ($readmeContent -match $insertPattern) {
        $readmeContent = $readmeContent -replace $insertPattern, "`$1$newSection"
    } else {
        # Fallback: insert after title
        $insertPattern = "(# Tech Stack Stickers.*?\n)"
        $readmeContent = $readmeContent -replace $insertPattern, "`$1$newSection"
    }

    if ($DryRun) {
        Write-Warning "DRY RUN: Would update README.md in $branchName"
        Write-Host "`n--- Preview of new section ---" -ForegroundColor Magenta
        Write-Host $newSection
        Write-Host "--- End of preview ---`n" -ForegroundColor Magenta
        return $true
    }

    # Write updated content
    Set-Content -Path $readmePath -Value $readmeContent -NoNewline

    Write-Success "README.md updated in branch: $branchName"

    # Stage and commit if not skipping
    if (-not $SkipCommit) {
        git add $readmePath
        
        $commitMessage = @"
docs(readme): add $($branchConfig.strategy) context

- Explain branch-specific asset organization
- Document directory structure and categories
- Clarify benefits and use cases for this organizational approach

AI-Attribution:
- Model: copilot/claude-sonnet-4.5 (Anthropic)
- Session: manual-commit-$(Get-Date -Format 'yyyy-MM-dd-HHmm')
- Context: Automated README contextualization across proposal branches

Co-authored-by: anthropic_Claude (copilot/claude-sonnet-4.5) <admin+llm-claude-sonnet-4-5@emblemprojects.com>
"@

        git commit -m $commitMessage
        Write-Success "Changes committed in branch: $branchName"
    }

    return $true
}

# Main execution
Write-Info "`n🚀 Starting README contextualization across branches...`n"

$processedCount = 0
$failedCount = 0

foreach ($branch in $config.branches.PSObject.Properties) {
    $branchName = $branch.Value.name
    $branchConfig = $branch.Value

    Write-Host "`n$('=' * 60)" -ForegroundColor DarkGray
    
    $success = Update-BranchReadme -branchName $branchName -branchConfig $branchConfig
    
    if ($success) {
        $processedCount++
    } else {
        $failedCount++
    }
}

Write-Host "`n$('=' * 60)" -ForegroundColor DarkGray

# Return to original branch
Write-Info "`nReturning to original branch: $originalBranch"
git checkout $originalBranch 2>&1 | Out-Null

# Summary
Write-Host "`n📊 Summary:" -ForegroundColor Cyan
Write-Success "Processed: $processedCount branches"
if ($failedCount -gt 0) {
    Write-Warning "Failed: $failedCount branches"
}

if ($DryRun) {
    Write-Warning "`nDRY RUN MODE - No changes were made"
    Write-Info "Run without -DryRun to apply changes"
}

if ($SkipCommit -and -not $DryRun) {
    Write-Warning "`nChanges made but not committed (SkipCommit flag used)"
    Write-Info "Review changes and commit manually"
}

Write-Success "`n✨ README contextualization complete!`n"
