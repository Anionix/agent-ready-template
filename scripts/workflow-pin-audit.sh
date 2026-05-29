#!/usr/bin/env bash
set -euo pipefail

echo "Checking GitHub Actions pins..."

status=0
found=0

trim() {
  local value="$1"
  value="${value%%#*}"
  value="${value#"${value%%[![:space:]]*}"}"
  value="${value%"${value##*[![:space:]]}"}"
  value="${value%\"}"
  value="${value#\"}"
  value="${value%\'}"
  value="${value#\'}"
  printf '%s' "$value"
}

while IFS= read -r workflow; do
  line_no=0
  while IFS= read -r line; do
    line_no=$((line_no + 1))
    if [[ "$line" =~ ^[[:space:]]*-?[[:space:]]*uses:[[:space:]]*(.+)$ ]]; then
      found=1
      action="$(trim "${BASH_REMATCH[1]}")"

      if [[ "$action" == ./* ]]; then
        echo "ok: $workflow:$line_no local action $action"
        continue
      fi

      if [[ "$action" != *@* ]]; then
        echo "blocked: $workflow:$line_no external action missing ref: $action"
        status=1
        continue
      fi

      ref="${action##*@}"
      if [[ "$ref" =~ ^[0-9a-f]{40}$ ]]; then
        echo "ok: $workflow:$line_no pinned action $action"
      else
        echo "blocked: $workflow:$line_no external action is not pinned to a full commit SHA: $action"
        status=1
      fi
    fi
  done <"$workflow"
done < <(find .github/workflows -type f '(' -name '*.yml' -o -name '*.yaml' ')' | sort)

if [ "$found" -eq 0 ]; then
  echo "warning: no uses: entries found in .github/workflows"
fi

if [ "$status" -ne 0 ]; then
  echo "Workflow pin audit failed."
  exit 1
fi

echo "Workflow pin audit passed."
