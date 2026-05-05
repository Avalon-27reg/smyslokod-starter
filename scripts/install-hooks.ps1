# scripts/install-hooks.ps1 - point git at .githooks/ in this repo
# Run once after cloning the project.

$ErrorActionPreference = "Stop"
Set-Location (Split-Path -Parent $PSScriptRoot)

git config core.hooksPath .githooks
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "[OK] Git hooks path set to .githooks/" -ForegroundColor Green
Write-Host "[OK] pre-push hook will block force-push and deletion of main/master." -ForegroundColor Green
