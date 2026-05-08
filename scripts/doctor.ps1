# scripts/doctor.ps1 - smyslokod-starter diagnostic (stack-agnostic)
# Usage: powershell -ExecutionPolicy Bypass -File scripts/doctor.ps1
# Output is in English so the script parses on Windows PowerShell 5.1
# (which interprets non-BOM .ps1 as ANSI and breaks on Cyrillic).

$ErrorActionPreference = "Continue"
$script:ok = 0
$script:fail = 0
$script:warn = 0

function Write-Ok($msg)   { Write-Host "  [OK]   $msg" -ForegroundColor Green;  $script:ok++ }
function Write-Bad($msg)  { Write-Host "  [FAIL] $msg" -ForegroundColor Red;    $script:fail++ }
function Write-Warn2($msg) { Write-Host "  [WARN] $msg" -ForegroundColor Yellow; $script:warn++ }
function Write-Info($msg) { Write-Host "  [info] $msg" -ForegroundColor Cyan }

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

Write-Host "* Base tools"
Check-Cmd "git" "git"

Write-Host ""
Write-Host "* Methodology"
Check-Path "CLAUDE.md"            "CLAUDE.md"
Check-Path "AGENTS.md"            "AGENTS.md"
Check-Path "START_HERE.md"        "START_HERE.md"
Check-Path "README.md"            "README.md"
Check-Path "LICENSE"              "LICENSE"
Check-Path "business/INDEX.md"    "business/INDEX.md"
Check-Path "plans/TEMPLATE.md"    "plans/TEMPLATE.md"
Check-Path "retrospectives/TEMPLATE.md" "retrospectives/TEMPLATE.md"
Check-Path ".claude/settings.json" ".claude/settings.json"
Check-Path ".claude/rules"        ".claude/rules"
Check-Path ".claude/agents"       ".claude/agents"
Check-Path ".claude/skills"       ".claude/skills"
Check-Path "docs/prompts/INDEX.md" "docs/prompts/INDEX.md"

Write-Host ""
Write-Host "* Git hooks"
$hooksPath = & git config --get core.hooksPath 2>$null
if ($hooksPath -eq ".githooks") {
  Write-Ok "core.hooksPath = .githooks (hooks active)"
} else {
  Write-Warn2 "core.hooksPath not set - run: pwsh scripts/install-hooks.ps1"
}
Check-Path "pre-push hook"   ".githooks/pre-push"
Check-Path "pre-commit hook" ".githooks/pre-commit"

Write-Host ""
Write-Host "* Security"
if (Test-Path ".env") { Write-Warn2 ".env exists - make sure it is in .gitignore (it is)" }
else { Write-Ok ".env not present (create it locally from .env.example if needed)" }

Write-Host ""
Write-Host "* Project stack (optional)"
if (Test-Path "package.json") { Write-Info "package.json found - Node stack installed by user" }
elseif ((Test-Path "pyproject.toml") -or (Test-Path "requirements.txt")) { Write-Info "Python stack detected" }
elseif (Test-Path "Cargo.toml") { Write-Info "Rust stack detected" }
elseif (Test-Path "go.mod") { Write-Info "Go stack detected" }
else { Write-Info "Stack not chosen yet - run the bootstrap prompt from START_HERE.md" }

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
