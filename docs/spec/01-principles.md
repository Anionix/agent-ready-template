# 01. Principles / 設計原則

## English

### 1. One command surface

Every actor should use the same command surface:

```sh
mise run doctor
mise run install
mise run services
mise run check
mise run agent-ready
```

Humans, AI agents, and CI should not need different commands.

### 2. `AGENTS.md` is the source of truth

All AI agent instructions should live in `AGENTS.md`.

Agent-specific files should be thin adapters:

- `CLAUDE.md` imports or points to `AGENTS.md`.
- `.cursor/rules/agent.mdc` points to `AGENTS.md`.
- `CONVENTIONS.md` summarizes only what Aider needs.
- Copilot setup workflow installs the same tools and runs the same checks.

### 3. Keep the default local workflow light

```text
host tools via mise
services via Docker Compose
instructions via AGENTS.md
```

### 4. Sandbox only when useful

Use Dev Container or sandbox when broad permissions, unknown scripts, dependency upgrades, multiple agents, or nearby secrets make host execution risky.

## 日本語

### 1. コマンド面を一本化する

すべての実行者が同じコマンドを使います。

```sh
mise run doctor
mise run install
mise run services
mise run check
mise run agent-ready
```

人間・AI agent・CIで別々のコマンド体系にしません。

### 2. `AGENTS.md` を正本にする

AI agent向けの共通指示は `AGENTS.md` に集約します。

agent固有ファイルは薄いadapterにします。

- `CLAUDE.md` は `AGENTS.md` をimportまたは参照する。
- `.cursor/rules/agent.mdc` は `AGENTS.md` を参照する。
- `CONVENTIONS.md` はAider向けに必要な要約だけを書く。
- Copilot setup workflowは同じtool installとcheckを実行する。

### 3. 標準ローカル開発は軽く保つ

```text
ホスト側tool管理: mise
サービス: Docker Compose
agent指示: AGENTS.md
```

### 4. sandboxは必要時だけ使う

広い権限、不明なscript、依存更新、複数agent、secret近傍の作業ではDev Containerやsandboxを使います。
