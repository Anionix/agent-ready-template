# 00. Overview / 概要

## English

This specification defines a lightweight template repository for AI coding agents.

The template is designed around four layers:

1. **Human-ready**: developers can run the project locally without a heavy container-first workflow.
2. **Agent-ready**: AI agents can set up, modify, verify, and report work using a small fixed command surface.
3. **Multi-agent-ready**: Codex, Claude Code, Cursor, Aider, GitHub Copilot coding agent, and optional Gemini can share the same repository contract.
4. **Agent-safe**: risky work can move into a selectable sandbox profile without making sandboxing the default.

The template intentionally avoids making Devbox, Flox, Nix, Dev Containers, Docker Sandboxes, KVM, or cloud sandbox providers mandatory.

## 日本語

この仕様は、AI coding agent向けの軽量テンプレートリポジトリを定義します。

テンプレートは4層で設計します。

1. **Human-ready**: 開発者が重いコンテナ前提ワークフローなしでローカル開発できる。
2. **Agent-ready**: AI agentが、固定された少数のコマンドでセットアップ・修正・検証・報告できる。
3. **Multi-agent-ready**: Codex、Claude Code、Cursor、Aider、GitHub Copilot coding agent、任意でGeminiが同じrepo契約を共有できる。
4. **Agent-safe**: 危険な作業だけを選択式sandbox profileに逃がせる。ただしsandboxを標準にはしない。

Devbox、Flox、Nix、Dev Containers、Docker Sandboxes、KVM、cloud sandbox providerは便利ですが、必須にはしません。

## Core recommendation / 核となる推奨構成

```text
Mac standard:
  OrbStack or compatible Docker runtime
  Docker Compose
  mise

Repository contract:
  AGENTS.md
  mise.toml
  compose.yaml
  .env.example
  CI

Multi-agent adapters:
  CLAUDE.md
  .cursor/rules/agent.mdc
  CONVENTIONS.md
  .github/workflows/copilot-setup-steps.yml

Optional safety layer:
  Dev Container
  ai-jail profile
  Michael-style microVM dev profile
  future Docker, cloud, OpenClaw, and embedded runtime profiles
  Gemini sandbox
```
