#!/usr/bin/env bash

set -euo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [ -z "${repo_root}" ]; then
  echo "after-write: not inside a git repository; skipping summary."
  exit 0
fi

cd "${repo_root}"

echo "after-write: pending changes summary"
echo "--- status (staged vs unstaged) ---"
git status --short || true

echo
echo "--- diff stat (working tree) ---"
git diff --stat || true

if ! git diff --cached --quiet 2>/dev/null; then
  echo
  echo "--- diff stat (staged) ---"
  git diff --cached --stat || true
fi

echo
echo "Tip: run /review-changes for a structured review or /suggest-commit-message before committing."
