#!/usr/bin/env bash
set -euo pipefail

skip_public_release_check=0

while [ "$#" -gt 0 ]; do
  case "$1" in
    --skip-public-release-check)
      skip_public_release_check=1
      ;;
    *)
      echo "usage: $0 [--skip-public-release-check]"
      exit 2
      ;;
  esac
  shift
done

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "error: secret-scan must run inside a git worktree"
  exit 1
fi

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

if [ "$skip_public_release_check" -eq 1 ]; then
  echo "Skipping custom public release checks; caller already ran public-release-check."
else
  echo "Running custom public release checks..."
  scripts/public-release-check.sh
fi

echo "Running gitleaks..."
if command -v gitleaks >/dev/null; then
  gitleaks detect --source . --redact --no-banner
elif command -v mise >/dev/null; then
  mise x gitleaks -- gitleaks detect --source . --redact --no-banner
else
  echo "missing: gitleaks"
  exit 1
fi

echo "Running TruffleHog..."
if command -v trufflehog >/dev/null; then
  trufflehog git "file://$repo_root" --results=verified --fail --no-update
elif command -v mise >/dev/null; then
  mise x trufflehog -- trufflehog git "file://$repo_root" --results=verified --fail --no-update
else
  echo "missing: trufflehog"
  exit 1
fi

echo "Secret scan passed."
