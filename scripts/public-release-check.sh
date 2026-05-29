#!/usr/bin/env bash
set -euo pipefail

echo "Checking public release readiness..."

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "error: public-release-check must run inside a git worktree"
  exit 1
fi

status=0
max_history_matches="${PUBLIC_RELEASE_HISTORY_MAX_MATCHES:-20}"

print_bounded_matches() {
  local match_file="$1"
  local total
  total="$(wc -l <"$match_file" | tr -d ' ')"
  head -n "$max_history_matches" "$match_file"
  if [ "$total" -gt "$max_history_matches" ]; then
    echo "... more matches omitted"
  fi
}

check_tracked_path_absent() {
  local pattern="$1"
  local description="$2"

  if git ls-files | grep -E "$pattern" >/dev/null; then
    echo "blocked: $description"
    git ls-files | grep -E "$pattern"
    status=1
  else
    echo "ok: $description"
  fi
}

check_worktree_paths_absent() {
  local description="$1"
  shift
  local match_file
  match_file="$(mktemp)"

  find . \
    -path './.git' -prune -o \
    -path './node_modules' -prune -o \
    -path './dist' -prune -o \
    -path './build' -prune -o \
    -path './coverage' -prune -o \
    "$@" \
    -print >"$match_file"

  if [ -s "$match_file" ]; then
    echo "blocked: $description"
    cat "$match_file"
    status=1
  else
    echo "ok: $description"
  fi
  rm -f "$match_file"
}

check_history_path_absent() {
  local pattern="$1"
  local description="$2"
  local exclude_pattern="${3:-}"
  local match_file
  local match_count=0
  local entry=""
  local commit=""
  match_file="$(mktemp)"

  while IFS= read -r -d '' entry; do
    case "$entry" in
      commit:*)
        commit="$entry"
        continue
        ;;
    esac

    [ -n "$entry" ] || continue
    if [[ "$entry" =~ $pattern ]]; then
      if [ -z "$exclude_pattern" ] || [[ ! "$entry" =~ $exclude_pattern ]]; then
        match_count=$((match_count + 1))
        if [ "$match_count" -le $((max_history_matches + 1)) ]; then
          printf '%s:%s\n' "$commit" "$entry" >>"$match_file"
        fi
        if [ "$match_count" -gt "$max_history_matches" ]; then
          break
        fi
      fi
    fi
  done < <(git log -z --format='commit:%H%x00' --name-only HEAD)

  if [ -s "$match_file" ]; then
    echo "blocked: $description"
    print_bounded_matches "$match_file"
    status=1
  else
    echo "ok: $description"
  fi

  rm -f "$match_file"
}

check_content_absent() {
  local pattern="$1"
  local description="$2"
  local match_file
  match_file="$(mktemp)"

  if git grep -n -I -E "$pattern" -- ':!scripts/public-release-check.sh' >"$match_file" 2>/dev/null; then
    echo "blocked: $description"
    cat "$match_file"
    status=1
  else
    echo "ok: $description"
  fi
  rm -f "$match_file"
}

check_history_content_absent() {
  local pattern="$1"
  local description="$2"
  local match_file
  local commit
  local match
  local match_count=0
  match_file="$(mktemp)"

  while IFS= read -r commit; do
    [ -n "$commit" ] || continue
    while IFS= read -r match; do
      match_count=$((match_count + 1))
      if [ "$match_count" -le $((max_history_matches + 1)) ]; then
        printf '%s\n' "$match" >>"$match_file"
      fi
      if [ "$match_count" -gt "$max_history_matches" ]; then
        break 2
      fi
    done < <(git grep -n -I -E "$pattern" "$commit" -- . ':!scripts/public-release-check.sh' 2>/dev/null || true)
  done < <(git log --format=%H -G "$pattern" HEAD -- . ':!scripts/public-release-check.sh' 2>/dev/null)

  if [ -s "$match_file" ]; then
    echo "blocked: $description"
    print_bounded_matches "$match_file"
    status=1
  else
    echo "ok: $description"
  fi

  rm -f "$match_file"
}

if git ls-files | grep -E '(^|/)\.env(\.|$)' | grep -v -E '(^|/)\.env(\.test)?\.example$' >/dev/null; then
  echo "blocked: tracked real .env files"
  git ls-files | grep -E '(^|/)\.env(\.|$)' | grep -v -E '(^|/)\.env(\.test)?\.example$'
  status=1
else
  echo "ok: tracked real .env files"
fi

check_worktree_paths_absent "worktree real .env files" \
  -type f '(' -name '.env' -o -name '.env.*' ')' \
  ! -name '.env.example' \
  ! -name '.env.test.example'
check_history_path_absent '(^|/)\.env(\.|$)' "history real .env files" '(^|/)\.env(\.test)?\.example$'

check_tracked_path_absent '(^|/)\.DS_Store$|(^|/)Icon'$'\r''?$' "tracked macOS metadata files"
check_worktree_paths_absent "worktree macOS metadata files" \
  -type f '(' -name '.DS_Store' -o -name 'Icon'$'\r' ')'
check_history_path_absent '(^|/)\.DS_Store$|(^|/)Icon'$'\r''?$' "history macOS metadata files"
check_tracked_path_absent '(^|/)secrets(/|$)|\.(pem|key)$' "tracked secret-bearing paths"
check_history_path_absent '(^|/)secrets(/|$)|\.(pem|key)$' "history secret-bearing paths"
check_tracked_path_absent '(^|/)(\.npmrc|\.pypirc|\.netrc|credentials\.json|token\.json|id_rsa|id_ed25519)$|(^|/)(\.aws|\.kube)(/|$)|\.(p12|pfx)$' "tracked credential config and key paths"
check_worktree_paths_absent "worktree credential config and key paths" \
  '(' \
    -path './.aws/*' -o \
    -path './.kube/*' -o \
    -type f '(' \
      -name '.npmrc' -o \
      -name '.pypirc' -o \
      -name '.netrc' -o \
      -name 'credentials.json' -o \
      -name 'token.json' -o \
      -name 'id_rsa' -o \
      -name 'id_ed25519' -o \
      -name '*.p12' -o \
      -name '*.pfx' \
    ')' \
  ')'
check_history_path_absent '(^|/)(\.npmrc|\.pypirc|\.netrc|credentials\.json|token\.json|id_rsa|id_ed25519)$|(^|/)(\.aws|\.kube)(/|$)|\.(p12|pfx)$' "history credential config and key paths"

check_content_absent '/Users/[^[:space:]]+|/private/var/folders/[^[:space:]]+|\.local-backup' "local machine paths"
check_history_content_absent '/Users/[^[:space:]]+|/private/var/folders/[^[:space:]]+|\.local-backup' "history local machine paths"
check_content_absent 'gh[opsu]_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]{20,}|sk-[A-Za-z0-9_-]{20,}' "known API token shapes"
check_history_content_absent 'gh[opsu]_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]{20,}|sk-[A-Za-z0-9_-]{20,}' "history known API token shapes"
check_content_absent 'AKIA[0-9A-Z]{16}|-----BEGIN (RSA |OPENSSH |EC |DSA |)?PRIVATE KEY-----' "cloud or private key material"
check_history_content_absent 'AKIA[0-9A-Z]{16}|-----BEGIN (RSA |OPENSSH |EC |DSA |)?PRIVATE KEY-----' "history cloud or private key material"
check_content_absent 'DO_NOT_PUBLISH|INTERNAL_ONLY|PRIVATE_REPO_ONLY|CONFIDENTIAL|PROPRIETARY|[Ii]nternal[ -]only|[Ff]or internal use|[Dd]o not publish|[Pp]rivate repo only|[Nn]ot for public release|[Cc]onfidential|[Pp]roprietary' "public-incompatible markers"
check_history_content_absent 'DO_NOT_PUBLISH|INTERNAL_ONLY|PRIVATE_REPO_ONLY|CONFIDENTIAL|PROPRIETARY|[Ii]nternal[ -]only|[Ff]or internal use|[Dd]o not publish|[Pp]rivate repo only|[Nn]ot for public release|[Cc]onfidential|[Pp]roprietary' "history public-incompatible markers"

if [ "$status" -ne 0 ]; then
  echo "Public release readiness check failed."
  exit 1
fi

echo "Public release readiness check passed."
