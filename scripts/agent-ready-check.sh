#!/usr/bin/env bash
set -euo pipefail

static=0
json=0

while [ "$#" -gt 0 ]; do
  case "$1" in
    --json)
      json=1
      ;;
    --static)
      static=1
      ;;
    *)
      echo "usage: $0 [--json] [--static]"
      exit 2
      ;;
  esac
  shift
done

status=0
checks=0
failures=0
finding_statuses=()
finding_names=()
finding_details=()

json_escape() {
  local value="${1:-}"
  value="${value//\\/\\\\}"
  value="${value//\"/\\\"}"
  value="${value//$'\n'/\\n}"
  value="${value//$'\r'/}"
  printf '%s' "$value"
}

add_finding() {
  local result="$1"
  local name="$2"
  local detail="${3:-}"

  checks=$((checks + 1))
  finding_statuses+=("$result")
  finding_names+=("$name")
  finding_details+=("$detail")

  if [ "$result" = "fail" ]; then
    status=1
    failures=$((failures + 1))
  fi

  if [ "$json" -eq 0 ]; then
    if [ -n "$detail" ]; then
      echo "$result: $name - $detail"
    else
      echo "$result: $name"
    fi
  fi
}

run_check() {
  local name="$1"
  shift
  local output_file
  local detail
  output_file="$(mktemp)"

  if "$@" >"$output_file" 2>&1; then
    add_finding "ok" "$name" "passed"
  else
    detail="$(head -n 5 "$output_file" | tr '\n' ' ')"
    add_finding "fail" "$name" "${detail:-failed}"
  fi

  rm -f "$output_file"
}

workflow_lint() {
  actionlint .github/workflows/*.yml
}

workflow_pin_audit() {
  scripts/workflow-pin-audit.sh
}

dockerfile_pin_audit() {
  scripts/dockerfile-pin-audit.sh
}

compose_config() {
  docker compose config
}

emit_json() {
  local score=$((100 - failures * 5))
  local state="pass"
  if [ "$score" -lt 0 ]; then
    score=0
  fi
  if [ "$status" -ne 0 ]; then
    state="fail"
  fi

  printf '{\n'
  printf '  "status": "%s",\n' "$state"
  printf '  "score": %d,\n' "$score"
  printf '  "checks": %d,\n' "$checks"
  printf '  "failures": %d,\n' "$failures"
  printf '  "findings": [\n'
  for i in "${!finding_statuses[@]}"; do
    if [ "$i" -gt 0 ]; then
      printf ',\n'
    fi
    printf '    {"status": "%s", "name": "%s", "detail": "%s"}' \
      "$(json_escape "${finding_statuses[$i]}")" \
      "$(json_escape "${finding_names[$i]}")" \
      "$(json_escape "${finding_details[$i]}")"
  done
  printf '\n  ]\n'
  printf '}\n'
}

required_files=(
  "AGENTS.md"
  "CLAUDE.md"
  "CONVENTIONS.md"
  "README.md"
  "CHANGELOG.md"
  "CODE_OF_CONDUCT.md"
  "CONTRIBUTING.md"
  "GOVERNANCE.md"
  "LICENSE"
  "MAINTAINERS.md"
  "SECURITY.md"
  "mise.toml"
  "compose.yaml"
  ".env.example"
  ".env.test.example"
  ".github/CODEOWNERS"
  ".github/dependabot.yml"
  ".github/pull_request_template.md"
  ".github/ISSUE_TEMPLATE/bug_report.md"
  ".github/ISSUE_TEMPLATE/feature_request.md"
  ".github/workflows/ci.yml"
  ".github/workflows/codeql.yml"
  ".github/workflows/copilot-setup-steps.yml"
  ".github/workflows/release.yml"
  ".github/workflows/scorecard.yml"
  ".hadolint.yaml"
  "scripts/agent-ready-check.sh"
  "scripts/public-release-check.sh"
  "scripts/secret-scan.sh"
  "scripts/workflow-pin-audit.sh"
  "scripts/dockerfile-pin-audit.sh"
  "scripts/github-protection-status.sh"
  "scripts/apply-main-branch-protection.sh"
  "scripts/wait-for-services.sh"
  "scripts/sandbox-profiles.sh"
  ".clusterfuzzlite/Dockerfile"
  "go.mod"
  "fuzz/agent_ready_json_fuzz_test.go"
  ".cursor/rules/agent.mdc"
  "docs/agent-safety.md"
  "docs/threat-model.md"
  "docs/sandbox-profiles.md"
  "docs/sandbox-footguns.md"
  "docs/sandbox-adoption-checklist.md"
  "docs/network-dns-audit-boundaries.md"
  "docs/cloud-sandbox-adapters.md"
  "docs/ci-runner-hardening.md"
  "docs/architecture.md"
  "docs/openssf-best-practices.md"
  "docs/release-process.md"
  "docs/release-signing.md"
  "docs/security-workflows.md"
  "docs/github-protection-policy.md"
  "docs/troubleshooting.md"
  "docs/spec/07-github-template-guide.md"
  "profiles/README.md"
  "profiles/os-sandbox/ai-jail/README.md"
  "profiles/os-sandbox/ai-jail/.ai-jail.example"
  "profiles/microvm-dev/michael-style/README.md"
  "profiles/microvm-dev/michael-style/microvm.nix.example"
  "profiles/microvm-dev/brood-box-style/README.md"
  "profiles/microvm-dev/nixcage-style/README.md"
  "profiles/microvm-dev/nixbox-style/README.md"
  "profiles/docker-sandbox/docker-sandboxes/README.md"
  "profiles/openclaw-runtime/ryoooo-style/README.md"
  "profiles/openclaw-runtime/policy/README.md"
  "profiles/openclaw-runtime/threat-boundary-checklist.md"
  "profiles/cloud-sandbox/firecracker/e2b/README.md"
  "profiles/cloud-sandbox/firecracker/vercel/README.md"
  "profiles/cloud-sandbox/dedicated-computer/daytona/README.md"
  "profiles/cloud-sandbox/container-based/cloudflare/README.md"
  "profiles/embedded-runtime/boxlite/README.md"
  "profiles/embedded-runtime/microsandbox/README.md"
)

required_tasks=(
  "doctor"
  "doctor-static"
  "install"
  "services"
  "dev"
  "lint"
  "typecheck"
  "test"
  "check"
  "reset"
  "workflow-lint"
  "workflow-pin-audit"
  "dockerfile-pin-audit"
  "dockerfile-lint"
  "shellcheck"
  "fuzz"
  "go-coverage"
  "sandbox-profiles"
  "agent-ready"
  "agent-ready-json"
  "agent-ready-static-json"
  "public-release-check"
  "secret-scan"
  "release-check"
  "github-protection-status"
  "github-main-protection-apply"
)

if [ "$json" -eq 0 ]; then
  echo "Checking agent-ready contract..."
fi

for file in "${required_files[@]}"; do
  if [ -f "$file" ]; then
    add_finding "ok" "file:$file" "present"
  else
    add_finding "fail" "file:$file" "missing"
  fi
done

for task in "${required_tasks[@]}"; do
  if grep -Fq "[tasks.${task}]" mise.toml; then
    add_finding "ok" "task:$task" "defined"
  else
    add_finding "fail" "task:$task" "missing from mise.toml"
  fi
done

for script in scripts/*.sh; do
  if [ -x "$script" ]; then
    add_finding "ok" "executable:$script" "set"
  else
    add_finding "fail" "executable:$script" "missing executable bit"
  fi
  run_check "shell-syntax:$script" bash -n "$script"
done

if [ "$static" -eq 1 ]; then
  add_finding "skipped" "compose-config" "static mode; Docker Compose config not checked"
else
  run_check "compose-config" compose_config
fi
run_check "workflow-lint" workflow_lint
run_check "workflow-pin-audit" workflow_pin_audit
run_check "dockerfile-pin-audit" dockerfile_pin_audit

# shellcheck disable=SC2016
while read -r task; do
  [ -n "$task" ] || continue
  if grep -Fq "[tasks.${task}]" mise.toml; then
    add_finding "ok" "agents-command:$task" "documented and defined"
  else
    add_finding "fail" "agents-command:$task" "documented in AGENTS.md but missing from mise.toml"
  fi
done < <(grep -oE '`mise run [a-z0-9-]+`' AGENTS.md | tr -d '`' | awk '{print $3}' | sort -u)

if [ "$json" -eq 1 ]; then
  emit_json
fi

if [ "$status" -ne 0 ]; then
  if [ "$json" -eq 0 ]; then
    echo "Agent readiness check failed."
  fi
  exit 1
fi

if [ "$json" -eq 0 ]; then
  echo "Agent readiness check passed."
fi
