[CmdletBinding()]
param(
    [string]$CodexRoot = (Join-Path ([Environment]::GetFolderPath("UserProfile")) ".codex\skills"),
    [switch]$Force
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot
$SourceDir = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    (Join-Path $RepoRoot "plugins\hkdse-contentops\skills\hkdse-contentops")
)

if (-not (Test-Path -LiteralPath (Join-Path $SourceDir "SKILL.md") -PathType Leaf)) {
    throw "Skill source is incomplete: $SourceDir"
}

$CodexRoot = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($CodexRoot)
New-Item -ItemType Directory -Path $CodexRoot -Force | Out-Null
$CodexRoot = (Resolve-Path -LiteralPath $CodexRoot).ProviderPath

if ($CodexRoot -eq [System.IO.Path]::GetPathRoot($CodexRoot)) {
    throw "Refusing Codex root: $CodexRoot"
}

$Destination = Join-Path $CodexRoot "hkdse-contentops"
if ($Destination -eq $SourceDir) {
    throw "Refusing to install the skill onto its source directory: $SourceDir"
}
if ((Test-Path -LiteralPath $Destination) -and -not $Force) {
    throw "Already exists: $Destination. Re-run with -Force to back it up and replace it."
}

if (Test-Path -LiteralPath $Destination) {
    $Timestamp = (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")
    $BackupBase = "$Destination.backup-$Timestamp"
    $Backup = $BackupBase
    $Suffix = 2
    while (Test-Path -LiteralPath $Backup) {
        $Backup = "$BackupBase-$Suffix"
        $Suffix += 1
    }
    Move-Item -LiteralPath $Destination -Destination $Backup
    Write-Output "Codex backup: $Backup"
}

Copy-Item -LiteralPath $SourceDir -Destination $Destination -Recurse
Write-Output "Codex installed: $Destination"
Write-Output "Start a new Codex task before testing the updated skill."
