# scripts/doctor.ps1 - environment diagnostic for smyslokod-starter
# Usage: powershell -ExecutionPolicy Bypass -File scripts/doctor.ps1
# (Output is in English to stay compatible with Windows PowerShell 5.1
#  which parses .ps1 without BOM as ANSI and breaks on Cyrillic.)

$ErrorActionPreference = "Continue"
$script:ok = 0
$script:fail = 0
$script:warn = 0

function Write-Ok($msg)   { Write-Host "  [OK]   $msg" -ForegroundColor Green;  $script:ok++ }
function Write-Bad($msg)  { Write-Host "  [FAIL] $msg" -ForegroundColor Red;    $script:fail++ }
function Write-Warn2($msg) { Write-Host "  [WARN] $msg" -ForegroundColor Yellow; $script:warn++ }

function Check-Cmd($label, $cmd) {
  if (Get-Command $cmd -ErrorAction SilentlyContinue) { Write-Ok "$label is installed" }
  else { Write-Bad "$label not found in PATH" }
}

function Check-Path($label, $path) {
  if (Test-Path $path) { Write-Ok "$label  ($path)" }
  else { Write-Bad "$label is missing: $path" }
}

$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

Write-Host "smyslokod-starter doctor"
Write-Host "Project root: $root"
Write-Host ""

Write-Host "* Tools"
Check-Cmd "node" "node"
Check-Cmd "pnpm" "pnpm"
Check-Cmd "git"  "git"

if (Get-Command node -ErrorAction SilentlyContinue) {
  $nodeVer = (& node -v).TrimStart("v")
  $nodeMajor = [int]($nodeVer.Split(".")[0])
  if ($nodeMajor -lt 20) { Write-Warn2 "Node $nodeVer (recommended: >= 20)" }
  else { Write-Ok "Node v$nodeVer" }
}

Write-Host ""
Write-Host "* Project structure"
Check-Path "package.json"          "package.json"
Check-Path ".env.example"          ".env.example"
Check-Path ".gitignore"            ".gitignore"
Check-Path "CLAUDE.md"             "CLAUDE.md"
Check-Path "AGENTS.md"             "AGENTS.md"
Check-Path "START_HERE.md"         "START_HERE.md"
Check-Path "business/INDEX.md"     "business/INDEX.md"
Check-Path "plans/TEMPLATE.md"     "plans/TEMPLATE.md"
Check-Path "retrospectives/TEMPLATE.md" "retrospectives/TEMPLATE.md"
Check-Path ".claude/settings.json" ".claude/settings.json"
Check-Path ".claude/rules"         ".claude/rules"
Check-Path ".claude/agents"        ".claude/agents"

Write-Host ""
Write-Host "* Security"
if (Test-Path ".env") { Write-Warn2 ".env exists - make sure it is in .gitignore (it is)" }
else { Write-Ok ".env not present (create it locally from .env.example)" }

if (Test-Path "node_modules") { Write-Ok "node_modules is installed" }
else { Write-Warn2 "node_modules not found - run: pnpm install" }

Write-Host ""
Write-Host "Result:"
Write-Host ("  OK: {0}, warnings: {1}, errors: {2}" -f $script:ok, $script:warn, $script:fail)

if ($script:fail -gt 0) {
  Write-Host ""
  Write-Host "Critical issues found. Fix the [FAIL] entries above and re-run doctor."
  exit 1
}

if ($script:warn -gt 0) {
  Write-Host ""
  Write-Host "Warnings do not block work, but check them."
}

exit 0
