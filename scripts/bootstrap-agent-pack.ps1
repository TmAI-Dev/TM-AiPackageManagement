param(
    [string[]]$TargetRepos = @(),
    [switch]$CreateSampleTarget
)

$ErrorActionPreference = 'Stop'

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Resolve-Path (Join-Path $scriptRoot '..')
$agentsRoot = Join-Path $repoRoot 'agents'
$skillsRoot = Join-Path $repoRoot 'skills'

function Copy-AgentPack {
    param(
        [Parameter(Mandatory = $true)]
        [string]$TargetRoot
    )

    $copilotRoot = Join-Path $TargetRoot '.copilot'
    $agentTarget = Join-Path $copilotRoot 'agents'
    $skillsTarget = Join-Path $copilotRoot 'skills'

    New-Item -ItemType Directory -Path $agentTarget -Force | Out-Null
    New-Item -ItemType Directory -Path $skillsTarget -Force | Out-Null

    foreach ($file in Get-ChildItem -Path $agentsRoot -Filter '*.agent.md' -File) {
        Copy-Item -Path $file.FullName -Destination (Join-Path $agentTarget $file.Name) -Force
    }

    foreach ($skillFolder in Get-ChildItem -Path $skillsRoot -Directory) {
        $destinationFolder = Join-Path $skillsTarget $skillFolder.Name
        New-Item -ItemType Directory -Path $destinationFolder -Force | Out-Null

        $skillFile = Join-Path $skillFolder.FullName 'SKILL.md'
        if (Test-Path $skillFile) {
            Copy-Item -Path $skillFile -Destination (Join-Path $destinationFolder 'SKILL.md') -Force
        }
    }

    $manifest = @{
        packageName = 'tm-agent-pack'
        source = $repoRoot
        copiedAtUtc = (Get-Date).ToString('o')
        agents = @(Get-ChildItem -Path $agentTarget -Filter '*.agent.md' | ForEach-Object { $_.Name })
        skills = @(Get-ChildItem -Path $skillsTarget -Directory | ForEach-Object { $_.Name })
    } | ConvertTo-Json -Depth 4

    Set-Content -Path (Join-Path $copilotRoot 'manifest.json') -Value $manifest -Encoding UTF8
    Set-Content -Path (Join-Path $copilotRoot 'README.md') -Value @"
# Copilot agent pack

This folder was created by the shared bootstrap script.

It contains the reusable agent and skill definitions from the central source repository.

## Contents

- agents/
- skills/
- manifest.json
"@ -Encoding UTF8

    Write-Host "Installed agent pack into $copilotRoot" -ForegroundColor Green
}

if ($CreateSampleTarget) {
    $sampleTarget = Join-Path $repoRoot 'sample-target-repo'
    if (-not (Test-Path $sampleTarget)) {
        New-Item -ItemType Directory -Path $sampleTarget -Force | Out-Null
    }
    $TargetRepos += $sampleTarget
}

if ($TargetRepos.Count -eq 0) {
    Write-Host "No target repos were supplied. Use -TargetRepos ""<path>"" or -CreateSampleTarget." -ForegroundColor Yellow
    exit 0
}

foreach ($target in $TargetRepos) {
    $resolvedTarget = [System.IO.Path]::GetFullPath($target)
    if (-not (Test-Path $resolvedTarget)) {
        New-Item -ItemType Directory -Path $resolvedTarget -Force | Out-Null
    }

    Copy-AgentPack -TargetRoot $resolvedTarget
}

Write-Host "Bootstrap completed successfully." -ForegroundColor Green
