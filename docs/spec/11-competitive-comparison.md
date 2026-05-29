# 11. Competitive Comparison / 競合比較

## English

This repository is a lightweight repository contract for AI coding agents.
It is not a container distribution, a microVM runner, a readiness scoring product, a single-agent setup kit, a cloud sandbox SDK, or a full application starter.

The default path is:

- local-first development with `mise` and Docker Compose
- `AGENTS.md` as the shared source of truth
- thin adapters for Claude Code, Cursor, GitHub Copilot, Codex, and optional Gemini
- CI and release-readiness checks that match the documented local commands
- selectable sandbox profiles only when risk justifies them

The clearest differentiation is **agent-ready repo contract + selectable sandbox profiles**. Stronger runtimes remain references or optional profiles, not default dependencies.

## 日本語

このリポジトリは、AI coding agent向けの軽量なrepo契約です。
コンテナ配布物、microVM runner、readiness採点プロダクト、単一agent向けセットアップキット、cloud sandbox SDK、または全部入りアプリstarterではありません。

標準方針は次です。

- `mise` と Docker Compose によるlocal-first開発
- `AGENTS.md` を共有正本にする
- Claude Code / Cursor / GitHub Copilot / Codex / 任意Gemini向けadapterを薄く置く
- 文書化されたlocal commandと一致するCI / release-readiness check
- 危険な作業だけ選択式sandbox profileへ逃がす

最も明確な差別化は **agent-ready repo contract + selectable sandbox profiles** です。強いruntimeは参照または任意profileに留め、default dependencyにはしません。

## Lane 1: microVM sandbox / microVM sandbox系

| Repository | What it is strong at | Positioning for this template |
|---|---|---|
| [`stacklok/brood-box`](https://github.com/stacklok/brood-box) | Runs coding agents in hardware-isolated microVMs. Its current README describes copy-on-write workspace snapshots, per-file diff review, direct versus snapshot workspace modes, DNS-aware egress profiles, `--allow-host`, MCP proxying, and multi-agent support for Claude Code, Codex, OpenCode, Hermes, and Gemini CLI. | Treat as the strongest runtime UX benchmark. This template should learn its snapshot, rollback, review, and egress vocabulary, but should not vendor Brood Box or require libkrun, KVM, Hypervisor.framework, or Brood Box in default CI. |
| [`razvanz/nixbox`](https://github.com/razvanz/nixbox) | Cloud Hypervisor microVM sandbox for AI agents with KVM host boundary, egress filtering, virtiofs bind mounts, and concurrent VM support. | Keep as a comparison target for CLI-driven NixOS microVM operation. The existing `profiles/microvm-dev/nixbox-style` note should remain optional and documentation-grade. |
| [`hamidr/nixcage`](https://github.com/hamidr/nixcage) | Project-directory NixOS microVM workflow. Its docs describe shell-hook entry into a VM, Cloud Hypervisor on Linux, QEMU/HVF on macOS, read-only host `/nix/store`, live `/workspace` mount, and Linux builder needs on macOS. | Add as a future optional profile note for teams that want a project-local Nix microVM development loop. Do not treat macOS and Linux host guarantees as identical. |
| [`diggerhq/oc-openclaw-template`](https://github.com/diggerhq/oc-openclaw-template) and OpenClaw-adjacent runtime references | Managed per-employee OpenClaw agents on OpenComputer sandboxes, KVM-backed isolation, chat access, auto-hibernate, fleet management, and checkpoint/restore. | Useful for OpenClaw deployment positioning. This template's OpenClaw lane should stay a future optional hardened profile and avoid copying personal machine configs or provider-specific assumptions into the core repo contract. |

## Lane 2: agent-ready repo contract / agent-ready repo契約系

| Repository or standard | What it is strong at | Positioning for this template |
|---|---|---|
| [`AGENTS.md`](https://agents.md/) | A simple open format for agent instructions. The site describes it as a predictable README-like place for coding-agent context and says it is used by 60k+ open-source projects. | This template uses `AGENTS.md` as the source of truth, then adds command parity, adapters, CI checks, release gates, and optional sandbox profiles around it. |
| [`kodustech/agent-readiness`](https://github.com/kodustech/agent-readiness) | Agent-readiness scoring across documented pillars. Its current README describes 39 automated checks, 7 pillars, maturity levels, local execution, CI gates, and JSON output. | Complementary auditor model. This template should keep `mise run agent-ready-json` stable and lightweight, and can document interoperability later without replacing the repo-local shell contract. |
| [`agent-next/agent-ready`](https://github.com/agent-next/agent-ready) | Measurable agent readiness, `AGENTS.md`, CI, Copilot setup, and repository quality criteria. | Treat as a standards/scoring reference rather than a direct replacement. This template provides the repo shape and command contract that external auditors can evaluate. |
| [`rmurphey/claude-setup`](https://github.com/rmurphey/claude-setup) and [`jimeh/agentic`](https://github.com/jimeh/agentic) | Shared agent configuration, Claude-focused command kits, `AGENTS.md`, `CLAUDE.md`, plugins, and `mise.toml` patterns. | Useful inspiration for agent-specific config management. This template stays agent-neutral by default and keeps agent-specific adapters thin. |

## Lane 3: container and devcontainer workflow / container・devcontainer workflow系

| Repository | What it is strong at | Positioning for this template |
|---|---|---|
| [`branchbox/branchbox`](https://github.com/branchbox/branchbox) | Parallel feature environments with dedicated Git worktrees, devcontainers, Docker networks, databases, ports, `.env` files, tunnels, and shared credential mounts. | Strong reference for day-to-day multi-agent workflow ergonomics. Keep separate from microVM isolation claims: this is about reducing collisions and making parallel development easier. |
| [`agent-infra/sandbox`](https://github.com/agent-infra/sandbox) | All-in-one Docker sandbox with browser, terminal, file operations, VSCode Server, Jupyter, and MCP in a single container. | Strong convenience reference for unified tool surfaces. Keep it optional and avoid presenting a single Docker container as equivalent to KVM or Hypervisor-backed microVM isolation. |
| [`dirien/devcontainer-coding-agents`](https://github.com/dirien/devcontainer-coding-agents) | Multi-agent files such as `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, plus Dev Container and Docker sandbox material. | Use this template when the normal loop should stay light on local machines, while sandboxing remains selectable rather than the primary operating model. |
| [`centminmod/claude-code-devcontainers`](https://github.com/centminmod/claude-code-devcontainers) | Claude Code, Codex, Gemini, hooks, config templates, and sandbox/firewall-oriented Dev Container setup. | Treat as a hardening reference. This template keeps the base repo understandable and moves high-risk work into optional layers. |
| [`first-fluke/fullstack-starter`](https://github.com/first-fluke/fullstack-starter) and [`openworkflowdev/openworkflow`](https://github.com/openworkflowdev/openworkflow) | Real application repositories or templates with `mise`, app stacks, multi-agent files, Compose, CI, and broad workflow automation. | Good proof that repo-contract patterns work in real projects. This template remains stack-agnostic so it can be layered onto application starters rather than competing with them. |

### BranchBox vs AIO container workflow

Checked on 2026-05-16 against [`branchbox/branchbox`](https://github.com/branchbox/branchbox) and [`agent-infra/sandbox`](https://github.com/agent-infra/sandbox).

This lane is about daily-development ergonomics, not kernel-level isolation.
Kernel-level isolation belongs in the microVM/runtime lanes. Container workflow
tools can still teach useful operator habits: make workspaces disposable, keep
ports and networks from colliding, make databases explicit, and keep tool
surfaces easy to review.

| Axis | BranchBox-style workflow | AIO Sandbox-style workflow | Template lesson |
|---|---|---|---|
| Workspace boundary | One feature becomes its own Git worktree and devcontainer. | One container exposes a combined agent workspace. | Declare the workspace boundary before assigning agent work. |
| Docker network and ports | Per-feature Compose project, Docker network, ports, and environment. | Single container surface; network policy depends on how the container is run. | Treat network/port isolation as workflow collision control unless backed by stronger runtime policy. |
| Database state | Per-feature database isolation is part of the workflow. | Database state is not the core advertised boundary; the emphasis is tool access. | Keep stateful services tied to the branch/worktree so agents do not collide. |
| Environment and credentials | `.env` files and shared credential mounts are first-class concerns. | Browser, shell, files, VSCode Server, Jupyter, and MCP live together in one container. | Document which credentials are shared, scoped, or excluded from agent work. |
| Tool UX surface | Strong for parallel feature work and devcontainer handoff. | Strong for a unified browser/terminal/file/MCP/VSCode operator surface. | Learn the UX, but keep it optional and separate from the repo contract core. |

BranchBox-style tools are strongest when several humans or agents need parallel,
realistic dev environments without worktree, Compose, network, database, port,
or `.env` collisions. AIO-style tools are strongest when the operator wants one
convenient surface with browser, terminal, file, MCP, and editor access. Neither
should be described as equivalent to KVM, Hypervisor.framework, or
Cloud-Hypervisor-backed microVM isolation.

## What to learn next / 次に取り込む学び

- **Snapshot and rollback UX**: Learn from Brood Box's copy-on-write snapshot mode and per-file review flow. Translate that into optional profile guidance before building any local runtime integration.
- **Egress policy vocabulary**: Use clear terms such as permissive, standard, locked, allow-host, logging, filtering, and enforcement. Avoid implying DNS logs or firewall rules are complete data-loss prevention.
- **Simple Nix microVM UX**: Compare nixbox's CLI-driven VM workflow with nixcage's project-directory shell hook before expanding local Nix profile docs.
- **Readiness interoperability**: Keep this template's `agent-ready-json` stable, and treat Kodus-style scoring as a complementary auditor lane.
- **Container workflow ergonomics**: Learn from BranchBox and AIO Sandbox where they reduce collisions and unify tools, while preserving the distinction between container convenience and hardware-backed microVM isolation.

## Strategic takeaways / 戦略的示唆

- The strongest runtime competitors are microVM-first tools. Competing with them directly would make this template too heavy.
- The strongest repo-contract competitors are standards and scoring tools. This template should stay compatible with them instead of trying to become a full scoring product.
- The strongest adoption competitors are container/devcontainer workflows and real app starters. This template should remain small, predictable, and stack-agnostic.
- The core claim should stay narrow: a shared repository contract with clear commands, CI parity, release gates, and optional profiles for stronger isolation.
- Do not claim to be the safest sandbox. Claim to make sandbox selection explicit and repeatable.

## Source snapshot / 情報源

Checked on 2026-05-16.
