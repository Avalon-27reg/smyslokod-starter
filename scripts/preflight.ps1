# scripts/preflight.ps1 - pre-commit / pre-deploy check
# Output kept in English so the script parses on Windows PowerShell 5.1.

$ErrorActionPreference = "Stop"

Set-Location (Split-Path -Parent $PSScriptRoot)

Write-Host "* pnpm lint"
pnpm lint
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host ""
Write-Host "* pnpm typecheck"
pnpm typecheck
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host ""
Write-Host "* pnpm build"
pnpm build
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host ""
Write-Host "Preflight ok" -ForegroundColor Green
