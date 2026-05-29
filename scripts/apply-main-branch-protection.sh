#!/usr/bin/env bash
set -euo pipefail

branch="${GITHUB_BRANCH:-main}"
required_check="${GITHUB_REQUIRED_CHECK:-check}"
mode="--dry-run"
strict=0

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run|--apply)
      mode="$1"
      ;;
    --strict)
      strict=1
      ;;
    *)
      echo "usage: $0 [--dry-run|--apply] [--strict]"
      exit 2
      ;;
  esac
  shift
done

if ! command -v gh >/dev/null; then
  echo "error: missing gh; install GitHub CLI and authenticate before applying branch protection"
  exit 1
fi

if ! command -v jq >/dev/null; then
  echo "error: missing jq; install jq before applying branch protection"
  exit 1
fi

require_gh_auth() {
  if ! gh auth status >/dev/null 2>&1; then
    echo "error: gh is not authenticated; run 'gh auth login' or set GITHUB_TOKEN before applying branch protection"
    exit 1
  fi
}

resolve_repo() {
  local remote_url
  local parsed

  if [ -n "${GITHUB_REPOSITORY:-}" ]; then
    printf '%s\n' "$GITHUB_REPOSITORY"
    return 0
  fi

  remote_url="$(git config --get remote.origin.url 2>/dev/null || true)"
  case "$remote_url" in
    https://github.com/*)
      parsed="${remote_url#https://github.com/}"
      printf '%s\n' "${parsed%.git}"
      return 0
      ;;
    git@github.com:*)
      parsed="${remote_url#git@github.com:}"
      printf '%s\n' "${parsed%.git}"
      return 0
      ;;
  esac

  require_gh_auth
  gh repo view --json nameWithOwner --jq .nameWithOwner
}

repo="$(resolve_repo)"

dismiss_stale_reviews=false
require_code_owner_reviews=false
required_approving_review_count=0
protection_mode="solo"

if [ "$strict" -eq 1 ]; then
  dismiss_stale_reviews=true
  require_code_owner_reviews=true
  required_approving_review_count=1
  protection_mode="public-strict"
fi

if [ "$mode" = "--apply" ]; then
  require_gh_auth
fi

payload="$(mktemp)"
trap 'rm -f "$payload"' EXIT

jq -n \
  --arg required_check "$required_check" \
  --argjson dismiss_stale_reviews "$dismiss_stale_reviews" \
  --argjson require_code_owner_reviews "$require_code_owner_reviews" \
  --argjson required_approving_review_count "$required_approving_review_count" \
  '{
    required_status_checks: {
      strict: true,
      contexts: [$required_check]
    },
    enforce_admins: false,
    required_pull_request_reviews: {
      dismiss_stale_reviews: $dismiss_stale_reviews,
      require_code_owner_reviews: $require_code_owner_reviews,
      required_approving_review_count: $required_approving_review_count
    },
    restrictions: null,
    required_linear_history: true,
    allow_force_pushes: false,
    allow_deletions: false
  }' >"$payload"

jq empty "$payload"

echo "target: $repo:$branch"
echo "required check: $required_check"
echo "protection mode: $protection_mode"
echo "strict status checks: true"
echo "dismiss stale reviews: $dismiss_stale_reviews"
echo "require code owner reviews: $require_code_owner_reviews"
echo "required approving review count: $required_approving_review_count"
echo "required linear history: true"
echo "allow force pushes: false"
echo "allow deletions: false"

if [ "$mode" = "--dry-run" ]; then
  echo "dry run only; pass --apply after the repository is public or the GitHub plan supports branch protection"
  echo "add --strict for public contribution mode with code-owner review and one approval"
  exit 0
fi

gh api \
  --method PUT \
  "repos/$repo/branches/$branch/protection" \
  --input "$payload" \
  --jq '"protected=true required_checks=\((.required_status_checks.contexts // []) | join(",")) linear_history=\(.required_linear_history.enabled // false) force_pushes=\(.allow_force_pushes.enabled // false) deletions=\(.allow_deletions.enabled // false)"'
