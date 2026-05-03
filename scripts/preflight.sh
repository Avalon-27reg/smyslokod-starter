#!/usr/bin/env bash
# scripts/preflight.sh — проверка перед коммитом / деплоем
# Запускает: pnpm lint && pnpm build

set -euo pipefail

cd "$(dirname "$0")/.."

echo "▸ pnpm lint"
pnpm lint

echo ""
echo "▸ pnpm typecheck"
pnpm typecheck

echo ""
echo "▸ pnpm build"
pnpm build

echo ""
echo "✅ Preflight ok"
