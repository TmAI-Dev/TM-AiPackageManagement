param(
    [string[]]$TargetRepos = @(),
    [string]$Repository = 'TmAI-Dev/TM-AiPackageManagement',
    [ValidateSet('core', 'iac', 'dev')]
    [string[]]$Packs = @('core'),
    [ValidateSet('copilot')]
    [string]$Target = 'copilot',
    [switch]$CreateSampleTarget
)

$ErrorActionPreference = 'Stop'

if ($null -eq (Get-Command apm -ErrorAction SilentlyContinue)) {
    throw 'APM CLI was not found. Install it from https://microsoft.github.io/apm/getting-started/installation/ and run this script again.'
}

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Resolve-Path (Join-Path $scriptRoot '..')

if ($CreateSampleTarget) {
    $sampleTarget = Join-Path $repoRoot 'sample-target-repo'
    if (-not (Test-Path $sampleTarget)) {
        New-Item -ItemType Directory -Path $sampleTarget -Force | Out-Null
    }

    $TargetRepos += $sampleTarget
}

if ($TargetRepos.Count -eq 0) {
    Write-Host 'No target repositories were supplied. Use -TargetRepos "<path>" or -CreateSampleTarget.' -ForegroundColor Yellow
    exit 0
}

foreach ($targetRepo in $TargetRepos) {
    $resolvedTarget = [System.IO.Path]::GetFullPath($targetRepo)
    if (-not (Test-Path $resolvedTarget)) {
        New-Item -ItemType Directory -Path $resolvedTarget -Force | Out-Null
    }

    Push-Location $resolvedTarget
    try {
        foreach ($pack in $Packs) {
            $package = "$Repository/packs/$pack"
            Write-Host "Installing $package into $resolvedTarget..." -ForegroundColor Cyan
            & apm install $package --target $Target
            if ($LASTEXITCODE -ne 0) {
                throw "APM installation of $package failed for $resolvedTarget with exit code $LASTEXITCODE."
            }
        }
    }
    finally {
        Pop-Location
    }
}

Write-Host 'APM installation completed successfully.' -ForegroundColor Green
