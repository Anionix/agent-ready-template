#!/usr/bin/env bash
set -euo pipefail

echo "Waiting for services..."

services="${WAIT_SERVICES:-postgres redis}"
attempts="${WAIT_ATTEMPTS:-30}"
sleep_seconds="${WAIT_SLEEP_SECONDS:-2}"

service_ready() {
  local service="$1"
  local ids
  local id
  local state
  local health
  ids="$(docker compose ps -q "$service" 2>/dev/null || true)"

  if [ -z "$ids" ]; then
    return 1
  fi

  while IFS= read -r id; do
    [ -n "$id" ] || continue

    state="$(docker inspect --format '{{.State.Status}}' "$id" 2>/dev/null || true)"
    health="$(docker inspect --format '{{if .State.Health}}{{.State.Health.Status}}{{end}}' "$id" 2>/dev/null || true)"

    case "$health" in
      healthy)
        ;;
      starting|unhealthy)
        return 1
        ;;
      "")
        if [ "$state" != "running" ]; then
          return 1
        fi
        ;;
      *)
        return 1
        ;;
    esac
  done <<< "$ids"

  return 0
}

for i in $(seq 1 "$attempts"); do
  pending=()
  for service in $services; do
    if service_ready "$service"; then
      echo "$service is ready"
    else
      pending+=("$service")
    fi
  done

  if [ "${#pending[@]}" -eq 0 ]; then
    echo "All requested services are ready: $services"
    exit 0
  fi

  echo "waiting for: ${pending[*]} ($i/$attempts)"
  sleep "$sleep_seconds"
done

echo "Timed out waiting for services: $services"
docker compose ps
exit 1
