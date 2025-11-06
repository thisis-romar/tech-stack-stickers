#!/usr/bin/env pwsh
# cleanup-png-folders.ps1
# Cleans up contaminated PNG folders on all branches

param(
    [switch]$DryRun,
    [string[]]$Branches = @('proposal-1-role-based', 'proposal-2-layer-based', 'proposal-3-ecosystem-based')
)

$ErrorActionPreference = "Stop"

# Define expected categories for each branch
$branchCategories = @{
    "proposal-1-role-based" = @('backend', 'cloud', 'data-ml', 'databases', 'devops', 'frontend', 'languages', 'mobile', 'tooling')
    "proposal-2-layer-based" = @('application-layer', 'cloud-services', 'data-layer', 'developer-tools', 'languages', 'platform-layer', 'ui-layer')
    "proposal-3-ecosystem-based" = @('cloud-platforms', 'databases', 'devops-cncf', 'google-stack', 'independent-tools', 'jvm-ecosystem', 'microsoft-stack', 'python-ecosystem', 'react-ecosystem', 'vue-ecosystem', 'web-core')
    "proposal-4-usecase-based" = @('backend-api', 'cloud-deployment', 'collaboration', 'data-science', 'machine-learning', 'mobile-apps', 'systems-programming', 'web-development')
}

$currentBranch = (git branch --show-current).Trim()

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  PNG Folder Cleanup" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

if ($DryRun) {
    Write-Host "[DRY RUN MODE - No changes will be made]`n" -ForegroundColor Yellow
}

foreach ($branch in $Branches) {
    Write-Host "Processing: $branch" -ForegroundColor Yellow
    
    # Switch to branch
    try {
        $checkoutOutput = git checkout $branch 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Host "  [ERROR] Cannot switch to branch: $checkoutOutput" -ForegroundColor Red
            continue
        }
    } catch {
        Write-Host "  [ERROR] Cannot switch to branch: $_" -ForegroundColor Red
        continue
    }
    
    $correctFolders = $branchCategories[$branch]
    $removedCount = 0
    
    # Clean each PNG size directory
    foreach ($size in @('small', 'medium', 'large')) {
        $pngPath = "assets\png\$size"
        
        if (-not (Test-Path $pngPath)) {
            Write-Host "  [WARN] PNG path not found: $pngPath" -ForegroundColor Yellow
            continue
        }
        
        $existingFolders = Get-ChildItem $pngPath -Directory -ErrorAction SilentlyContinue
        $foldersToRemove = $existingFolders | Where-Object { $_.Name -notin $correctFolders }
        
        foreach ($folder in $foldersToRemove) {
            if ($DryRun) {
                Write-Host "    [DRY RUN] Would remove: $size/$($folder.Name)" -ForegroundColor Gray
            } else {
                Remove-Item $folder.FullName -Recurse -Force
                Write-Host "    Removed: $size/$($folder.Name)" -ForegroundColor Green
            }
            $removedCount++
        }
    }
    
    if ($removedCount -eq 0) {
        Write-Host "  ✓ No contaminated folders found" -ForegroundColor Green
    } else {
        Write-Host "  ✓ Cleaned $removedCount contaminated PNG folders" -ForegroundColor Green
    }
    
    Write-Host ""
}

# Switch back to original branch
Write-Host "Returning to: $currentBranch" -ForegroundColor Cyan
git checkout $currentBranch 2>&1 | Out-Null

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Cleanup Complete" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

if (-not $DryRun) {
    Write-Host "Run 'pwsh scripts/verify-all-branches.ps1' to verify the cleanup.`n" -ForegroundColor Yellow
}
