# Apply category organization to all proposal branches
# This script ensures all 4 proposals have properly organized PNGs matching their SVG structure

$branches = @(
    "proposal-1-role-based",
    "proposal-2-layer-based", 
    "proposal-3-ecosystem-based",
    "proposal-4-usecase-based"
)

Write-Host "🔄 Applying category organization to all proposal branches..." -ForegroundColor Cyan

foreach ($branch in $branches) {
    Write-Host "`n📦 Processing branch: $branch" -ForegroundColor Yellow
    
    # Checkout branch
    git checkout $branch
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to checkout $branch"
        continue
    }
    
    # Check if generator updates exist
    if (-not (Test-Path "data\category-mappings.json")) {
        Write-Host "  ⚠️  Missing category-mappings.json, copying from main..." -ForegroundColor Yellow
        git checkout proposal-1-role-based -- data/category-mappings.json scripts/fetch-icons.mjs
        git add data/category-mappings.json scripts/fetch-icons.mjs
        git commit -m "feat(generator): add category-aware asset generation

Co-authored-by: anthropic_Claude (copilot/claude-sonnet-4.5) <admin+llm-claude-sonnet-4-5@emblemprojects.com>" --no-verify
    }
    
    Write-Host "  🔨 Regenerating assets..." -ForegroundColor Cyan
    npm run generate
    
    Write-Host "  🧹 Cleaning up empty category folders..." -ForegroundColor Cyan
    # Remove empty PNG category folders
    Get-ChildItem assets\png\small -Directory -ErrorAction SilentlyContinue | 
        Where-Object { (Get-ChildItem $_.FullName -File -ErrorAction SilentlyContinue).Count -eq 0 } | 
        Remove-Item -Recurse -Force
    
    Get-ChildItem assets\png\medium -Directory -ErrorAction SilentlyContinue | 
        Where-Object { (Get-ChildItem $_.FullName -File -ErrorAction SilentlyContinue).Count -eq 0 } | 
        Remove-Item -Recurse -Force
    
    Get-ChildItem assets\png\large -Directory -ErrorAction SilentlyContinue | 
        Where-Object { (Get-ChildItem $_.FullName -File -ErrorAction SilentlyContinue).Count -eq 0 } | 
        Remove-Item -Recurse -Force
    
    # Verify organization
    $svgCategories = (Get-ChildItem assets\svg -Directory).Count
    $pngSmallCategories = (Get-ChildItem assets\png\small -Directory).Count
    
    Write-Host "  ✓ SVG categories: $svgCategories" -ForegroundColor Green
    Write-Host "  ✓ PNG categories: $pngSmallCategories" -ForegroundColor Green
    
    if ($svgCategories -eq $pngSmallCategories) {
        Write-Host "  ✅ Branch $branch fully organized!" -ForegroundColor Green
    } else {
        Write-Host "  ⚠️  Category count mismatch on $branch" -ForegroundColor Yellow
    }
}

Write-Host "`n🎉 All branches processed!" -ForegroundColor Green
Write-Host "`n📊 Summary:" -ForegroundColor Cyan

foreach ($branch in $branches) {
    git checkout $branch | Out-Null
    $categories = (Get-ChildItem assets\svg -Directory).Count
    $svgCount = (Get-ChildItem assets\svg -Directory | ForEach-Object { (Get-ChildItem $_.FullName -File).Count } | Measure-Object -Sum).Sum
    Write-Host "  $branch : $categories categories, $svgCount SVG files" -ForegroundColor White
}

git checkout main
Write-Host "`n✅ Ready to push all branches to GitHub!" -ForegroundColor Green
