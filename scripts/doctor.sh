#!/usr/bin/env bash
set -euo pipefail

mode="${1:---full}"

if [ "$mode" != "--full" ] && [ "$mode" != "--static" ]; then
  echo "usage: $0 [--full|--static]"
  exit 2
fi

print_static_hint() {
  echo
  echo "Docker is required for the full service lane."
  echo "Start Docker Desktop, OrbStack, Colima, or another Docker-compatible runtime, then rerun:"
  echo "  mise run doctor"
  echo
  echo "For Docker-free static validation, run:"
  echo "  mise run doctor-static"
  echo "  mise run agent-ready-static-json"
}

echo "Checking required tools..."

command -v mise >/dev/null || { echo "missing: mise"; exit 1; }

echo "mise: $(mise --version)"

if [ "$mode" = "--static" ]; then
  echo "Running static lane checks..."

  scripts/agent-ready-check.sh --static
  scripts/public-release-check.sh

  echo "doctor static checks passed"
  exit 0
fi

if ! command -v docker >/dev/null; then
  echo "missing: docker"
  print_static_hint
  exit 1
fi

if ! docker version >/dev/null 2>&1; then
  echo "docker daemon is not reachable"
  print_static_hint
  exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
  echo "missing: docker compose"
  print_static_hint
  exit 1
fi

echo "Checking compose config..."
if ! docker compose config >/dev/null 2>&1; then
  echo "docker compose config failed"
  print_static_hint
  exit 1
fi

if command -v node >/dev/null; then
  echo "node: $(node --version)"
else
  echo "warning: node not found before mise install"
fi

if command -v pnpm >/dev/null; then
  echo "pnpm: $(pnpm --version)"
else
  echo "warning: pnpm not found before mise install"
fi

echo "doctor passed"
