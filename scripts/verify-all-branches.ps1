#!/usr/bin/env pwsh
# verify-all-branches.ps1
# Verifies all 4 proposal branches have correct asset organization

param(
    [switch]$Verbose
)

$ErrorActionPreference = "Stop"

# Define expected configurations for each branch
$branchConfigs = @{
    "proposal-1-role-based" = @{
        Categories = @('backend', 'cloud', 'data-ml', 'databases', 'devops', 'frontend', 'languages', 'mobile', 'tooling')
        CategoryCount = 9
    }
    "proposal-2-layer-based" = @{
        Categories = @('application-layer', 'cloud-services', 'data-layer', 'developer-tools', 'languages', 'platform-layer', 'ui-layer')
        CategoryCount = 7
    }
    "proposal-3-ecosystem-based" = @{
        Categories = @('cloud-platforms', 'databases', 'devops-cncf', 'google-stack', 'independent-tools', 'jvm-ecosystem', 'microsoft-stack', 'python-ecosystem', 'react-ecosystem', 'vue-ecosystem', 'web-core')
        CategoryCount = 11
    }
    "proposal-4-usecase-based" = @{
        Categories = @('backend-api', 'cloud-deployment', 'collaboration', 'data-science', 'machine-learning', 'mobile-apps', 'systems-programming', 'web-development')
        CategoryCount = 8
    }
}

$results = @()
$currentBranch = (git branch --show-current).Trim()

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Branch Verification Report" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

foreach ($branch in $branchConfigs.Keys | Sort-Object) {
    Write-Host "Checking: $branch" -ForegroundColor Yellow
    
    # Switch to branch
    try {
        git checkout $branch 2>&1 | Out-Null
    } catch {
        Write-Host "  [FAIL] Cannot switch to branch" -ForegroundColor Red
        $results += [PSCustomObject]@{
            Branch = $branch
            Status = "FAIL"
            Reason = "Cannot checkout branch"
        }
        continue
    }
    
    $config = $branchConfigs[$branch]
    $issues = @()
    
    # Check 1: No flat SVG files in root
    $flatSvgs = (Get-ChildItem "assets\svg" -File -ErrorAction SilentlyContinue | Measure-Object).Count
    if ($flatSvgs -gt 0) {
        $issues += "Found $flatSvgs flat SVG files in root (should be 0)"
    }
    
    # Check 2: Correct SVG categories exist
    $svgDirs = Get-ChildItem "assets\svg" -Directory -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name | Sort-Object
    $expectedCategories = $config.Categories | Sort-Object
    
    $missingCategories = $expectedCategories | Where-Object { $_ -notin $svgDirs }
    $extraCategories = $svgDirs | Where-Object { $_ -notin $expectedCategories }
    
    if ($missingCategories) {
        $issues += "Missing SVG categories: $($missingCategories -join ', ')"
    }
    if ($extraCategories) {
        $issues += "Extra SVG categories: $($extraCategories -join ', ')"
    }
    
    # Check 3: Total SVG file count
    $totalSvgs = 0
    Get-ChildItem "assets\svg" -Directory -ErrorAction SilentlyContinue | ForEach-Object {
        $totalSvgs += (Get-ChildItem $_.FullName -File).Count
    }
    
    if ($totalSvgs -ne 123) {
        $issues += "Total SVG files: $totalSvgs (expected 123)"
    }
    
    # Check 4: PNG folders match SVG categories
    foreach ($size in @('small', 'medium', 'large')) {
        $pngDirs = Get-ChildItem "assets\png\$size" -Directory -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name | Sort-Object
        $extraPngDirs = $pngDirs | Where-Object { $_ -notin $expectedCategories }
        
        if ($extraPngDirs) {
            $issues += "Extra PNG/$size categories: $($extraPngDirs -join ', ')"
        }
    }
    
    # Check 5: Catalog.json exists and is valid
    if (-not (Test-Path "data\catalog.json")) {
        $issues += "Missing data/catalog.json"
    } else {
        try {
            $catalog = Get-Content "data\catalog.json" -Raw | ConvertFrom-Json
            if ($catalog.icons.Count -ne 123) {
                $issues += "Catalog has $($catalog.icons.Count) icons (expected 123)"
            }
        } catch {
            $issues += "Invalid catalog.json format"
        }
    }
    
    # Determine status
    $status = if ($issues.Count -eq 0) { "PASS" } else { "FAIL" }
    $statusColor = if ($status -eq "PASS") { "Green" } else { "Red" }
    
    Write-Host "  [$status]" -ForegroundColor $statusColor -NoNewline
    Write-Host " $($config.CategoryCount) categories, $totalSvgs files"
    
    if ($issues.Count -gt 0) {
        foreach ($issue in $issues) {
            Write-Host "    - $issue" -ForegroundColor Yellow
        }
    }
    
    $results += [PSCustomObject]@{
        Branch = $branch
        Status = $status
        CategoryCount = $svgDirs.Count
        FileCount = $totalSvgs
        Issues = $issues -join "; "
    }
    
    Write-Host ""
}

# Switch back to original branch
git checkout $currentBranch 2>&1 | Out-Null

# Summary
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Summary" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$passCount = ($results | Where-Object { $_.Status -eq "PASS" }).Count
$failCount = ($results | Where-Object { $_.Status -eq "FAIL" }).Count

Write-Host "PASSED: $passCount / 4 branches" -ForegroundColor $(if ($passCount -eq 4) { "Green" } else { "Yellow" })
Write-Host "FAILED: $failCount / 4 branches" -ForegroundColor $(if ($failCount -eq 0) { "Green" } else { "Red" })

if ($Verbose -or $failCount -gt 0) {
    Write-Host "`nDetailed Results:"
    $results | Format-Table -AutoSize
}

Write-Host ""

# Exit code
exit $failCount
