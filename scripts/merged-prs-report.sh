#!/usr/bin/env bash
# Report which PRs/commits are in main vs prod.
# Run from repo root. Requires: git, optionally gh (for PR numbers in output).
set -e

# Ensure we have latest prod and main
git fetch origin main prod 2>/dev/null || true

MAIN_REF="${1:-origin/main}"
PROD_REF="${2:-origin/prod}"

echo "=============================================="
echo "  Merge status: main vs prod"
echo "  main = $MAIN_REF   prod = $PROD_REF"
echo "=============================================="
echo ""

echo "📌 In MAIN but NOT in PROD (pending promotion to prod):"
echo "-----------------------------------------------------------"
git log "$PROD_REF..$MAIN_REF" --oneline || echo "  (none)"
echo ""

echo "📌 In PROD but NOT in MAIN (prod-only merges, e.g. release PRs):"
echo "-----------------------------------------------------------"
git log "$MAIN_REF..$PROD_REF" --oneline || echo "  (none)"
echo ""

echo "Tip: Use 'git fetch origin main prod' first if you see 'bad object'."
echo "     Commit SHAs from GitHub (e.g. from PR merge commit) must exist locally (e.g. on prod) to run 'git show'."
