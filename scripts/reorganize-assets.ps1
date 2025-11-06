# Reorganize assets into categorized structure
# Usage: .\scripts\reorganize-assets.ps1 -Proposal <1|2|3|4>

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("1", "2", "3", "4")]
    [string]$Proposal
)

# Category mappings for each proposal
$categoryMappings = @{
    "1" = @{
        "frontend" = @("react", "vuedotjs", "angular", "svelte", "nextdotjs", "nuxt", "astro", "solid", "qwik", "html5", "css", "tailwindcss", "bootstrap", "materialdesign", "sass", "less", "stylus", "d3")
        "backend" = @("nodedotjs", "django", "flask", "fastapi", "spring", "laravel", "symfony", "rubyonrails", "phoenixframework")
        "languages" = @("javascript", "typescript", "python", "rust", "go", "openjdk", "kotlin", "scala", "apachegroovy", "c", "cplusplus", "dotnet", "sharp", "fsharp", "php", "ruby", "crystal", "elixir", "erlang", "dart", "swift")
        "devops" = @("docker", "kubernetes", "helm", "terraform", "pulumi", "ansible", "github", "gitlab", "bitbucket")
        "databases" = @("mongodb", "postgresql", "mysql", "sqlite", "redis", "apachekafka", "rabbitmq", "elasticsearch", "neo4j")
        "cloud" = @("googlecloud", "firebase", "vercel", "netlify", "digitalocean", "cloudflare", "heroku", "supabase")
        "data-ml" = @("pandas", "numpy", "jupyter", "scikitlearn", "tensorflow", "pytorch", "opencv", "openai", "huggingface", "langchain", "weightsandbiases", "airbyte", "apacheairflow")
        "mobile" = @("android", "androidstudio", "ios", "flutter", "xcode", "apple")
        "tooling" = @("webpack", "vite", "babel", "eslint", "prettier", "jest", "vitest", "cypress", "storybook", "apachemaven", "gradle", "poetry", "pipx", "anaconda", "pydantic", "qt", "webassembly", "wordpress", "meta", "grafana", "prometheus", "sentry", "newrelic", "datadog", "jira", "notion", "slack", "discord", "linux", "ubuntu")
    }
    "2" = @{
        "languages" = @("javascript", "typescript", "python", "rust", "go", "openjdk", "kotlin", "scala", "apachegroovy", "c", "cplusplus", "dotnet", "sharp", "fsharp", "php", "ruby", "crystal", "elixir", "erlang", "dart", "swift", "webassembly")
        "ui-layer" = @("react", "vuedotjs", "angular", "svelte", "solid", "qwik", "html5", "css", "tailwindcss", "bootstrap", "materialdesign", "sass", "less", "stylus", "d3")
        "application-layer" = @("nextdotjs", "nuxt", "astro", "django", "flask", "fastapi", "spring", "laravel", "symfony", "rubyonrails", "phoenixframework", "nodedotjs")
        "data-layer" = @("mongodb", "postgresql", "mysql", "sqlite", "redis", "apachekafka", "rabbitmq", "elasticsearch", "neo4j")
        "platform-layer" = @("docker", "kubernetes", "helm", "linux", "ubuntu")
        "cloud-services" = @("googlecloud", "firebase", "vercel", "netlify", "digitalocean", "cloudflare", "heroku", "supabase")
        "developer-tools" = @("github", "gitlab", "bitbucket", "webpack", "vite", "babel", "eslint", "prettier", "jest", "vitest", "cypress", "storybook", "terraform", "pulumi", "ansible", "apachemaven", "gradle", "poetry", "pipx", "anaconda", "pydantic", "qt", "wordpress", "meta", "grafana", "prometheus", "sentry", "newrelic", "datadog", "jira", "notion", "slack", "discord", "jupyter", "pandas", "numpy", "scikitlearn", "tensorflow", "pytorch", "opencv", "openai", "huggingface", "langchain", "weightsandbiases", "airbyte", "apacheairflow", "android", "androidstudio", "ios", "flutter", "xcode", "apple")
    }
    "3" = @{
        "web-core" = @("html5", "css", "javascript", "typescript", "webassembly")
        "react-ecosystem" = @("react", "nextdotjs", "vite")
        "vue-ecosystem" = @("vuedotjs", "nuxt")
        "python-ecosystem" = @("python", "django", "flask", "fastapi", "pydantic", "poetry", "pipx", "anaconda", "jupyter", "pandas", "numpy", "scikitlearn", "tensorflow", "pytorch", "opencv")
        "jvm-ecosystem" = @("openjdk", "kotlin", "scala", "apachegroovy", "spring", "gradle", "apachemaven")
        "microsoft-stack" = @("dotnet", "sharp", "fsharp")
        "google-stack" = @("googlecloud", "firebase", "angular", "dart", "flutter")
        "devops-cncf" = @("docker", "kubernetes", "helm", "prometheus", "grafana")
        "databases" = @("mongodb", "postgresql", "mysql", "sqlite", "redis", "apachekafka", "rabbitmq", "elasticsearch", "neo4j")
        "cloud-platforms" = @("vercel", "netlify", "heroku", "cloudflare", "digitalocean", "supabase")
        "independent-tools" = @("github", "gitlab", "bitbucket", "slack", "discord", "notion", "jira", "sentry", "newrelic", "datadog", "svelte", "angular", "solid", "qwik", "astro", "webpack", "babel", "eslint", "prettier", "jest", "vitest", "cypress", "storybook", "tailwindcss", "bootstrap", "materialdesign", "sass", "less", "stylus", "rust", "go", "c", "cplusplus", "qt", "php", "laravel", "symfony", "wordpress", "ruby", "rubyonrails", "crystal", "elixir", "phoenixframework", "erlang", "swift", "xcode", "android", "androidstudio", "apple", "ios", "linux", "ubuntu", "terraform", "pulumi", "ansible", "nodedotjs", "openai", "huggingface", "langchain", "meta", "weightsandbiases", "airbyte", "apacheairflow", "d3")
    }
    "4" = @{
        "web-development" = @("html5", "css", "javascript", "typescript", "react", "vuedotjs", "angular", "svelte", "nextdotjs", "nuxt", "astro", "solid", "qwik", "tailwindcss", "bootstrap", "materialdesign", "sass", "less", "stylus", "webpack", "vite", "babel", "d3")
        "backend-api" = @("nodedotjs", "python", "django", "flask", "fastapi", "spring", "laravel", "symfony", "rubyonrails", "phoenixframework", "mongodb", "postgresql", "mysql", "sqlite", "redis", "apachekafka", "rabbitmq", "elasticsearch", "neo4j")
        "mobile-apps" = @("android", "androidstudio", "ios", "flutter", "swift", "dart", "xcode", "apple")
        "data-science" = @("jupyter", "pandas", "numpy", "scikitlearn", "python", "anaconda")
        "machine-learning" = @("tensorflow", "pytorch", "opencv", "openai", "huggingface", "langchain", "weightsandbiases")
        "cloud-deployment" = @("docker", "kubernetes", "helm", "googlecloud", "firebase", "vercel", "netlify", "heroku", "cloudflare", "digitalocean", "supabase", "terraform", "pulumi", "ansible")
        "collaboration" = @("github", "gitlab", "bitbucket", "slack", "discord", "notion", "jira", "grafana", "prometheus", "sentry", "newrelic", "datadog", "airbyte", "apacheairflow")
        "systems-programming" = @("rust", "go", "c", "cplusplus", "openjdk", "kotlin", "scala", "apachegroovy", "dotnet", "sharp", "fsharp", "php", "ruby", "crystal", "elixir", "erlang", "linux", "ubuntu", "qt", "webassembly", "wordpress", "meta", "apachemaven", "gradle", "poetry", "pipx", "pydantic", "eslint", "prettier", "jest", "vitest", "cypress", "storybook")
    }
}

$mapping = $categoryMappings[$Proposal]

Write-Host "🔄 Reorganizing assets for Proposal $Proposal..." -ForegroundColor Cyan

# Create category directories
foreach ($category in $mapping.Keys) {
    $svgDir = "assets\svg\$category"
    $pngSmallDir = "assets\png\small\$category"
    $pngMediumDir = "assets\png\medium\$category"
    $pngLargeDir = "assets\png\large\$category"
    
    New-Item -ItemType Directory -Path $svgDir -Force | Out-Null
    New-Item -ItemType Directory -Path $pngSmallDir -Force | Out-Null
    New-Item -ItemType Directory -Path $pngMediumDir -Force | Out-Null
    New-Item -ItemType Directory -Path $pngLargeDir -Force | Out-Null
    
    Write-Host "  ✓ Created category: $category" -ForegroundColor Green
}

# Move SVG files to categorized directories
$moved = 0
foreach ($category in $mapping.Keys) {
    foreach ($slug in $mapping[$category]) {
        $sourceSvg = "assets\svg\$slug.svg"
        $targetSvg = "assets\svg\$category\$slug.svg"
        
        if (Test-Path $sourceSvg) {
            Move-Item -Path $sourceSvg -Destination $targetSvg -Force
            $moved++
        }
    }
}

Write-Host "✅ Moved $moved SVG files into categories" -ForegroundColor Green

# Clean up old flat svg directory if empty
$remainingFiles = Get-ChildItem "assets\svg\*.svg" -File -ErrorAction SilentlyContinue
if (-not $remainingFiles) {
    Write-Host "✅ All SVG files categorized successfully!" -ForegroundColor Green
} else {
    Write-Host "⚠️  Warning: $($remainingFiles.Count) files not categorized:" -ForegroundColor Yellow
    $remainingFiles | ForEach-Object { Write-Host "    - $($_.Name)" -ForegroundColor Yellow }
}

Write-Host "`n📊 Category Distribution:" -ForegroundColor Cyan
foreach ($category in $mapping.Keys | Sort-Object) {
    $count = $mapping[$category].Count
    Write-Host "  $category : $count icons" -ForegroundColor White
}
