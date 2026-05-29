#!/usr/bin/env bash
set -euo pipefail

echo "Checking Dockerfile dependency pins..."

status=0
found=0

trim() {
  local value="$1"
  value="${value#"${value%%[![:space:]]*}"}"
  value="${value%"${value##*[![:space:]]}"}"
  printf '%s' "$value"
}

while IFS= read -r dockerfile; do
  found=1
  line_no=0

  while IFS= read -r line; do
    line_no=$((line_no + 1))
    if [[ "$line" =~ ^[[:space:]]*FROM[[:space:]]+(.+)$ ]]; then
      from_value="$(trim "${BASH_REMATCH[1]}")"
      while [[ "$from_value" == --* ]]; do
        from_value="$(trim "${from_value#* }")"
      done
      image="${from_value%%[[:space:]]*}"

      case "$image" in
        scratch)
          echo "ok: $dockerfile:$line_no scratch base"
          ;;
        *@sha256:*)
          echo "ok: $dockerfile:$line_no pinned base $image"
          ;;
        *)
          echo "blocked: $dockerfile:$line_no base image is not pinned by digest: $image"
          status=1
          ;;
      esac
    fi
  done <"$dockerfile"

  if grep -nE '(curl|wget)[^|]*\|[[:space:]]*(sh|bash)' "$dockerfile"; then
    echo "blocked: $dockerfile runs a downloaded script through a shell pipeline"
    status=1
  else
    echo "ok: $dockerfile no download-to-shell pipeline"
  fi
done < <(git ls-files --cached --others --exclude-standard | grep -E '(^|/)(Dockerfile|.*\.Dockerfile)$' | sort -u)

if [ "$found" -eq 0 ]; then
  echo "warning: no Dockerfiles found"
fi

if [ "$status" -ne 0 ]; then
  echo "Dockerfile pin audit failed."
  exit 1
fi

echo "Dockerfile pin audit passed."
