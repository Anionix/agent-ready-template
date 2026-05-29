#!/usr/bin/env bash
set -euo pipefail

branch="${GITHUB_BRANCH:-main}"
required_check="${GITHUB_REQUIRED_CHECK:-check}"

if ! command -v gh >/dev/null; then
  echo "GitHub protection status"
  echo "unavailable: gh CLI is not installed; install GitHub CLI to read protection status"
  exit 0
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "GitHub protection status"
  echo "unavailable: gh is not authenticated; run gh auth login to read protection status"
  exit 0
fi

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

  gh repo view --json nameWithOwner --jq .nameWithOwner
}

if ! repo="$(resolve_repo)"; then
  echo "GitHub protection status"
  echo "unavailable: unable to determine GitHub repository"
  exit 0
fi

protection_output=""
protection_error=""
ruleset_output=""
ruleset_error=""

cleanup() {
  [ -n "${protection_output:-}" ] && rm -f "$protection_output"
  [ -n "${protection_error:-}" ] && rm -f "$protection_error"
  [ -n "${ruleset_output:-}" ] && rm -f "$ruleset_output"
  [ -n "${ruleset_error:-}" ] && rm -f "$ruleset_error"
}

trap cleanup EXIT

echo "GitHub protection status"
echo "repo: $repo"
echo "branch: $branch"

echo
echo "Repository:"
if gh api "repos/$repo" --jq \
  '"visibility=\(.visibility) private=\(.private) template=\(.is_template) default_branch=\(.default_branch)\nsecret_scanning=\(.security_and_analysis.secret_scanning.status // "unknown") push_protection=\(.security_and_analysis.secret_scanning_push_protection.status // "unknown") dependabot_security_updates=\(.security_and_analysis.dependabot_security_updates.status // "unknown")"'; then
  :
else
  echo "warning: unable to read repository security settings"
fi

echo
echo "Branch protection:"
if gh api "repos/$repo/branches/$branch" --jq '"protected=\(.protected)"'; then
  :
else
  echo "warning: unable to read branch protection state"
fi

echo
echo "Protection details:"
protection_output="$(mktemp)"
protection_error="$(mktemp)"
if gh api "repos/$repo/branches/$branch/protection" --jq \
  '"required_checks=\((.required_status_checks.contexts // []) | join(",")) strict_status_checks=\(.required_status_checks.strict // false)\napprovals=\(.required_pull_request_reviews.required_approving_review_count // 0) code_owner_reviews=\(.required_pull_request_reviews.require_code_owner_reviews // false) dismiss_stale_reviews=\(.required_pull_request_reviews.dismiss_stale_reviews // false)\nlinear_history=\(.required_linear_history.enabled // false) force_pushes_allowed=\(.allow_force_pushes.enabled // false) deletions_allowed=\(.allow_deletions.enabled // false)"' >"$protection_output" 2>"$protection_error"; then
  cat "$protection_output"
  required_contexts="$(gh api "repos/$repo/branches/$branch/protection" --jq '(.required_status_checks.contexts // []) | join(",")' 2>/dev/null || true)"
  case ",$required_contexts," in
    *",$required_check,"*)
      echo "required_check=$required_check present"
      ;;
    *)
      echo "warning: required check '$required_check' is not present"
      ;;
  esac
else
  cat "$protection_output"
  cat "$protection_error"
  echo "warning: unable to read detailed branch protection"
fi

echo
echo "Rulesets:"
ruleset_output="$(mktemp)"
ruleset_error="$(mktemp)"
if gh api "repos/$repo/rulesets" --jq '.[] | "name=\(.name) target=\(.target) enforcement=\(.enforcement)"' >"$ruleset_output" 2>"$ruleset_error"; then
  if [ -s "$ruleset_output" ]; then
    cat "$ruleset_output"
  else
    echo "none"
  fi
else
  if grep -q "Upgrade to GitHub Pro or make this repository public" "$ruleset_output" "$ruleset_error"; then
    echo "unavailable: private repository rulesets require a supported GitHub plan or public visibility"
  else
    cat "$ruleset_output"
    cat "$ruleset_error"
    echo "warning: unable to read repository rulesets"
  fi
fi

echo
echo "Policy:"
echo "- while private and unsupported: rely on release-check plus CI"
echo "- after public release: apply main branch protection"
echo "- for outside contributions: apply main branch protection with --strict"
echo "- when rulesets are available: prefer rulesets for layered branch and push rules"
