#!/usr/bin/env bash
# scripts/install-hooks.sh - point git at .githooks/ in this repo
# Run once after cloning the project.

set -euo pipefail

cd "$(dirname "$0")/.."

git config core.hooksPath .githooks
chmod +x .githooks/* 2>/dev/null || true

echo "[OK] Git hooks path set to .githooks/"
echo "[OK] pre-push hook will block force-push and deletion of main/master."
