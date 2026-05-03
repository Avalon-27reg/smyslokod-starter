#!/usr/bin/env bash
# scripts/doctor.sh — диагностика окружения для smyslokod-starter
# Использование: bash scripts/doctor.sh

set -u

GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
RESET="\033[0m"

ok=0
fail=0
warn=0

check() {
  local label="$1"
  local cmd="$2"
  if eval "$cmd" >/dev/null 2>&1; then
    printf "  ${GREEN}✓${RESET} %s\n" "$label"
    ok=$((ok+1))
  else
    printf "  ${RED}✗${RESET} %s\n" "$label"
    fail=$((fail+1))
  fi
}

check_file() {
  local label="$1"
  local path="$2"
  if [ -f "$path" ] || [ -d "$path" ]; then
    printf "  ${GREEN}✓${RESET} %s (%s)\n" "$label" "$path"
    ok=$((ok+1))
  else
    printf "  ${RED}✗${RESET} %s (отсутствует: %s)\n" "$label" "$path"
    fail=$((fail+1))
  fi
}

cd "$(dirname "$0")/.."
ROOT="$(pwd)"
echo "smyslokod-starter doctor"
echo "Корень проекта: $ROOT"
echo ""

echo "▸ Инструменты"
check "node установлен" "command -v node"
check "pnpm установлен" "command -v pnpm"
check "git установлен" "command -v git"

if command -v node >/dev/null 2>&1; then
  NODE_MAJOR=$(node -p "process.versions.node.split('.')[0]")
  if [ "$NODE_MAJOR" -lt 20 ]; then
    printf "  ${YELLOW}!${RESET} Node %s — рекомендуем ≥ 20\n" "$(node -v)"
    warn=$((warn+1))
  else
    printf "  ${GREEN}✓${RESET} Node $(node -v)\n"
    ok=$((ok+1))
  fi
fi

echo ""
echo "▸ Структура проекта"
check_file "package.json" "package.json"
check_file ".env.example" ".env.example"
check_file ".gitignore" ".gitignore"
check_file "CLAUDE.md" "CLAUDE.md"
check_file "AGENTS.md" "AGENTS.md"
check_file "START_HERE.md" "START_HERE.md"
check_file "business/INDEX.md" "business/INDEX.md"
check_file "plans/TEMPLATE.md" "plans/TEMPLATE.md"
check_file "retrospectives/TEMPLATE.md" "retrospectives/TEMPLATE.md"
check_file ".claude/settings.json" ".claude/settings.json"
check_file ".claude/rules/" ".claude/rules"
check_file ".claude/agents/" ".claude/agents"

echo ""
echo "▸ Безопасность"
if [ -f ".env" ]; then
  printf "  ${YELLOW}!${RESET} .env существует — убедитесь, что он в .gitignore (он там)\n"
  warn=$((warn+1))
else
  printf "  ${GREEN}✓${RESET} .env отсутствует (создайте локально из .env.example)\n"
  ok=$((ok+1))
fi

if [ -d "node_modules" ]; then
  printf "  ${GREEN}✓${RESET} node_modules установлен\n"
  ok=$((ok+1))
else
  printf "  ${YELLOW}!${RESET} node_modules нет — запустите: pnpm install\n"
  warn=$((warn+1))
fi

echo ""
echo "Результат:"
printf "  ${GREEN}OK: %d${RESET}, ${YELLOW}предупреждений: %d${RESET}, ${RED}ошибок: %d${RESET}\n" "$ok" "$warn" "$fail"

if [ "$fail" -gt 0 ]; then
  echo ""
  echo "Есть критичные проблемы. Исправьте отмеченное ✗ и запустите doctor снова."
  exit 1
fi

if [ "$warn" -gt 0 ]; then
  echo ""
  echo "Предупреждения не блокируют работу, но обратите внимание."
fi

exit 0
