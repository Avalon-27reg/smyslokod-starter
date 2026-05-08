#!/usr/bin/env bash
# scripts/doctor.sh — диагностика smyslokod-starter (стек-агностично)
# Использование: bash scripts/doctor.sh

set -u

GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
RESET="\033[0m"

ok=0; fail=0; warn=0

check_cmd() {
  local label="$1"; local cmd="$2"
  if command -v "$cmd" >/dev/null 2>&1; then
    printf "  ${GREEN}✓${RESET} %s\n" "$label"; ok=$((ok+1))
  else
    printf "  ${RED}✗${RESET} %s (не найдено в PATH)\n" "$label"; fail=$((fail+1))
  fi
}

check_path() {
  local label="$1"; local path="$2"
  if [ -e "$path" ]; then
    printf "  ${GREEN}✓${RESET} %s\n" "$label"; ok=$((ok+1))
  else
    printf "  ${RED}✗${RESET} %s (отсутствует: %s)\n" "$label" "$path"; fail=$((fail+1))
  fi
}

cd "$(dirname "$0")/.."
ROOT="$(pwd)"
echo "smyslokod-starter doctor"
echo "Корень: $ROOT"
echo ""

echo "▸ Базовые инструменты"
check_cmd "git" "git"

echo ""
echo "▸ Методология"
check_path "CLAUDE.md" "CLAUDE.md"
check_path "AGENTS.md" "AGENTS.md"
check_path "START_HERE.md" "START_HERE.md"
check_path "README.md" "README.md"
check_path "LICENSE" "LICENSE"
check_path "business/INDEX.md" "business/INDEX.md"
check_path "plans/TEMPLATE.md" "plans/TEMPLATE.md"
check_path "retrospectives/TEMPLATE.md" "retrospectives/TEMPLATE.md"
check_path ".claude/settings.json" ".claude/settings.json"
check_path ".claude/rules/" ".claude/rules"
check_path ".claude/agents/" ".claude/agents"
check_path ".claude/skills/" ".claude/skills"
check_path "docs/prompts/INDEX.md" "docs/prompts/INDEX.md"

echo ""
echo "▸ Git-хуки"
HOOKS_PATH=$(git config --get core.hooksPath 2>/dev/null || echo "")
if [ "$HOOKS_PATH" = ".githooks" ]; then
  printf "  ${GREEN}✓${RESET} core.hooksPath = .githooks (хуки активны)\n"; ok=$((ok+1))
else
  printf "  ${YELLOW}!${RESET} core.hooksPath не выставлен — выполните: bash scripts/install-hooks.sh\n"; warn=$((warn+1))
fi
check_path "pre-push hook" ".githooks/pre-push"
check_path "pre-commit hook" ".githooks/pre-commit"

echo ""
echo "▸ Безопасность"
if [ -f ".env" ]; then
  printf "  ${YELLOW}!${RESET} .env существует — убедитесь, что он в .gitignore (он там)\n"; warn=$((warn+1))
else
  printf "  ${GREEN}✓${RESET} .env отсутствует (создайте локально из .env.example при необходимости)\n"; ok=$((ok+1))
fi

echo ""
echo "▸ Стек проекта (опционально)"
if [ -f "package.json" ]; then
  printf "  ${GREEN}i${RESET} package.json найден — Node-стек установлен пользователем\n"
elif [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
  printf "  ${GREEN}i${RESET} Python-стек найден\n"
elif [ -f "Cargo.toml" ]; then
  printf "  ${GREEN}i${RESET} Rust-стек найден\n"
elif [ -f "go.mod" ]; then
  printf "  ${GREEN}i${RESET} Go-стек найден\n"
else
  printf "  ${YELLOW}i${RESET} Стек ещё не выбран — запустите bootstrap из START_HERE.md\n"
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
