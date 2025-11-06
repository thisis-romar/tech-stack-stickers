# Cleanup script: Remove flat PNG files and empty category folders
# Run this after generating categorized assets

param(
    [switch]$WhatIf
)

Write-Host "🧹 Cleaning up PNG structure..." -ForegroundColor Cyan

$sizes = @('small', 'medium', 'large')
$totalRemoved = 0

foreach ($size in $sizes) {
    $pngDir = "assets\png\$size"
    
    # Remove flat PNG files (direct children, not in subdirectories)
    $flatFiles = Get-ChildItem "$pngDir\*.png" -File -ErrorAction SilentlyContinue
    if ($flatFiles) {
        Write-Host "`n📂 $size folder:" -ForegroundColor Yellow
        Write-Host "  Removing $($flatFiles.Count) flat PNG files..." -ForegroundColor White
        
        if ($WhatIf) {
            $flatFiles | ForEach-Object { Write-Host "    Would remove: $($_.Name)" -ForegroundColor Gray }
        } else {
            $flatFiles | Remove-Item -Force
            $totalRemoved += $flatFiles.Count
        }
    }
    
    # Remove empty category directories
    $emptyDirs = Get-ChildItem $pngDir -Directory | Where-Object {
        $fileCount = (Get-ChildItem $_.FullName -File -ErrorAction SilentlyContinue).Count
        $fileCount -eq 0
    }
    
    if ($emptyDirs) {
        Write-Host "  Removing $($emptyDirs.Count) empty category folders..." -ForegroundColor White
        
        if ($WhatIf) {
            $emptyDirs | ForEach-Object { Write-Host "    Would remove: $($_.Name)/" -ForegroundColor Gray }
        } else {
            $emptyDirs | Remove-Item -Force -Recurse
        }
    }
}

if ($WhatIf) {
    Write-Host "`n✓ Dry run complete. Run without -WhatIf to execute cleanup." -ForegroundColor Cyan
} else {
    Write-Host "`n✅ Cleanup complete! Removed $totalRemoved flat PNG files." -ForegroundColor Green
    
    # Show final structure
    Write-Host "`n📊 Final PNG structure:" -ForegroundColor Cyan
    foreach ($size in $sizes) {
        $categories = Get-ChildItem "assets\png\$size" -Directory
        Write-Host "  $size/: $($categories.Count) categories" -ForegroundColor White
        foreach ($cat in $categories | Sort-Object Name) {
            $count = (Get-ChildItem $cat.FullName -File).Count
            Write-Host "    $($cat.Name): $count files" -ForegroundColor Gray
        }
    }
}
