[CmdletBinding()]
param(
    [ValidateSet("codex", "claude", "both")]
    [string]$Target = "both",
    [string]$CodexRoot = (Join-Path ([Environment]::GetFolderPath("UserProfile")) ".codex\skills"),
    [string]$ClaudeRoot = (Join-Path ([Environment]::GetFolderPath("UserProfile")) ".claude\skills"),
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
$ClaudeRoot = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($ClaudeRoot)

if ($Target -eq "codex" -or $Target -eq "both") {
    New-Item -ItemType Directory -Path $CodexRoot -Force | Out-Null
    $CodexRoot = (Resolve-Path -LiteralPath $CodexRoot).ProviderPath
}
if ($Target -eq "claude" -or $Target -eq "both") {
    New-Item -ItemType Directory -Path $ClaudeRoot -Force | Out-Null
    $ClaudeRoot = (Resolve-Path -LiteralPath $ClaudeRoot).ProviderPath
}

if ($Target -eq "codex" -or $Target -eq "both") {
    if ($CodexRoot -eq [System.IO.Path]::GetPathRoot($CodexRoot)) {
        throw "Refusing Codex root: $CodexRoot"
    }
}
if ($Target -eq "claude" -or $Target -eq "both") {
    if ($ClaudeRoot -eq [System.IO.Path]::GetPathRoot($ClaudeRoot)) {
        throw "Refusing Claude root: $ClaudeRoot"
    }
}

if ($Target -eq "both" -and $CodexRoot -eq $ClaudeRoot) {
    throw "Codex and Claude roots must be different when -Target both is used."
}

function Test-PathAtOrBelow {
    param([string]$Path, [string]$Parent)
    $Separators = [char[]]"\/"
    $PathWithSeparator = $Path.TrimEnd($Separators) + [System.IO.Path]::DirectorySeparatorChar
    $ParentWithSeparator = $Parent.TrimEnd($Separators) + [System.IO.Path]::DirectorySeparatorChar
    return $PathWithSeparator.StartsWith($ParentWithSeparator, [System.StringComparison]::OrdinalIgnoreCase)
}

if ($Target -eq "both") {
    $CodexDestination = Join-Path $CodexRoot "hkdse-contentops"
    $ClaudeDestination = Join-Path $ClaudeRoot "hkdse-contentops"
    if ((Test-PathAtOrBelow $ClaudeRoot $CodexDestination) -or
        (Test-PathAtOrBelow $CodexRoot $ClaudeDestination)) {
        throw "Codex and Claude roots must not overlap either skill destination."
    }
}

$InstallTargets = @()
if ($Target -eq "codex" -or $Target -eq "both") {
    $InstallTargets += [PSCustomObject]@{ Name = "Codex"; Root = $CodexRoot }
}
if ($Target -eq "claude" -or $Target -eq "both") {
    $InstallTargets += [PSCustomObject]@{ Name = "Claude"; Root = $ClaudeRoot }
}

foreach ($InstallTarget in $InstallTargets) {
    $Destination = Join-Path $InstallTarget.Root "hkdse-contentops"
    if ($Destination -eq $SourceDir) {
        throw "Refusing to install the skill onto its source directory: $SourceDir"
    }
    if ((Test-Path -LiteralPath $Destination) -and -not $Force) {
        throw "Already exists: $Destination. Re-run with -Force to back it up and replace it."
    }
}

foreach ($InstallTarget in $InstallTargets) {
    $Destination = Join-Path $InstallTarget.Root "hkdse-contentops"

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
        Write-Output "$($InstallTarget.Name) backup: $Backup"
    }

    Copy-Item -LiteralPath $SourceDir -Destination $Destination -Recurse
    Write-Output "$($InstallTarget.Name) installed: $Destination"
}

Write-Output "Start a new Codex task or Claude session before testing the updated skill."
