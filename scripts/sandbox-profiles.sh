#!/usr/bin/env bash
set -euo pipefail

cat <<'TEXT'
Sandbox profiles are optional add-ons. Default CI does not require Nix, NixOS, KVM, libkrun, Hypervisor.framework, Cloud Hypervisor, QEMU, Linux builders, ai-jail, Brood Box, nixcage, Docker Sandboxes, OpenClaw, cloud providers, BoxLite, or Microsandbox.

MVP profiles:
- profiles/os-sandbox/ai-jail
  Lightweight OS/process sandbox for daily agent work. Host kernel is shared.
- profiles/microvm-dev/michael-style
  NixOS microVM development pattern for stronger VM isolation. Documentation-grade starter only.

Phase 2 documented optional profile notes:
- profiles/microvm-dev/brood-box-style
  External Brood Box-style runtime UX note for snapshot, per-file review, rollback, egress, allow-host, and MCP proxy patterns. Not a CI dependency.
- profiles/microvm-dev/nixcage-style
  External nixcage-style Nix microVM note for project-directory VM entry and Linux/macOS host tradeoffs. Not a CI dependency.
- profiles/microvm-dev/nixbox-style
  External nixbox comparison note for CLI-driven microVM agent sandboxes. Not a CI dependency.
- profiles/docker-sandbox/docker-sandboxes
  Docker-native sandbox direction for agent work. Not a CI dependency.
- docs/sandbox-adoption-checklist.md
  Risk-to-profile checklist for host, process sandbox, microVM, OpenClaw, cloud, and embedded choices.

Phase 3 documented optional profile notes:
- profiles/openclaw-runtime/ryoooo-style
  Always-on assistant runtime boundary note. Not an OpenClaw dependency.
- profiles/openclaw-runtime/policy
  OpenShell / NemoClaw policy reference notes. Not a required runtime.
- profiles/openclaw-runtime/threat-boundary-checklist.md
  Threat-boundary checklist for always-on assistants.
- docs/network-dns-audit-boundaries.md
  Plain-language nftables, Unbound, and auditd boundary concepts.

Phase 4 documented optional profile notes:
- docs/cloud-sandbox-adapters.md
  Cloud sandbox taxonomy for Firecracker-style, dedicated-computer, and container-based providers.
- profiles/cloud-sandbox/firecracker/e2b
- profiles/cloud-sandbox/firecracker/vercel
- profiles/cloud-sandbox/dedicated-computer/daytona
- profiles/cloud-sandbox/container-based/cloudflare

Phase 5 documented optional profile notes:
- profiles/embedded-runtime/boxlite
- profiles/embedded-runtime/microsandbox

Future categories:
- native-sandbox/claude
- native-sandbox/codex
- os-sandbox/jail-nix
- cloud-sandbox/firecracker/fly-sprites

Read:
- docs/threat-model.md
- docs/sandbox-profiles.md
- docs/sandbox-footguns.md
- docs/sandbox-adoption-checklist.md
- docs/cloud-sandbox-adapters.md
- docs/ci-runner-hardening.md
- profiles/README.md
TEXT
