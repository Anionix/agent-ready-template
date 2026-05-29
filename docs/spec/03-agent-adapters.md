# 03. Agent Adapters / Agent別adapter

## English

The repository should support multiple AI coding agents without duplicating rules.

`AGENTS.md` is the source of truth.  
Agent-specific files are adapters.

## Adapter matrix / adapter一覧

| Agent | File | Purpose |
|---|---|---|
| Codex | `AGENTS.md` | Primary instruction file |
| Claude Code | `CLAUDE.md` | Import or point to `AGENTS.md` |
| Cursor | `.cursor/rules/agent.mdc` | Apply project rule pointing to `AGENTS.md` |
| Aider | `CONVENTIONS.md` | Lightweight conventions file |
| GitHub Copilot coding agent | `.github/workflows/copilot-setup-steps.yml` | Set up cloud agent environment |
| Gemini CLI | optional `.gemini/sandbox.Dockerfile` | Optional sandbox support |

## Optional worker runtimes

Agent adapters describe how a worker reads the repo contract. They do not make
any worker runtime mandatory.

| Worker | Optional role | Contract expectation |
|---|---|---|
| Claude Code Action | Issue- or PR-triggered worker in GitHub. | Use scoped repository permissions, avoid broad secrets, and hand off through a PR that still requires human approval. |
| Claude Agent SDK | Custom worker loop for teams that need MCP tools, hooks, telemetry, or app integration. | Keep MCP/tool access explicit, run in an isolated workspace, and log the commands and tools used. |
| Codex | Interactive or CLI worker for local repository changes. | Read `AGENTS.md`, keep edits within the issue scope, run the declared checks, and summarize residual risk. |
| OpenHands | Sandbox-oriented software engineering agent runtime. | Treat the sandbox as the workspace boundary and require the same PR, CI, and human review gate as any other worker. |

Worker runtimes should be replaceable. A project can use one, several, or none
of these options while preserving the same issue scope, permissions, MCP/tool
access notes, isolated workspace expectations, verification commands, and human
approval handoff.

## 日本語

複数のAI coding agentをサポートしつつ、ルールの重複は避けます。

`AGENTS.md` を正本にします。  
agent固有ファイルはadapterです。

## Recommended policy / 推奨ポリシー

- Do not copy the full `AGENTS.md` into each adapter.
- Keep adapter files short.
- If an agent supports import syntax, import `AGENTS.md`.
- If not, explicitly instruct it to read `AGENTS.md`.
- Keep completion criteria identical across agents.

- 各adapterに `AGENTS.md` の全文をコピーしない。
- adapterは短く保つ。
- import構文があるagentでは `AGENTS.md` をimportする。
- importできない場合は `AGENTS.md` を読むよう明記する。
- 完了条件は全agentで統一する。

## Optional worker runtimes / 任意のworker runtime

Agent adapterは、workerがrepo contractをどう読むかを説明します。特定のworker runtimeは
必須化しません。

| Worker | Optional role | Contract expectation |
|---|---|---|
| Claude Code Action | GitHub上のissueまたはPRから起動するworker。 | repository permissionをscopeし、広いsecretを避け、human approvalが残るPRとしてhandoffする。 |
| Claude Agent SDK | MCP tools、hooks、telemetry、app integrationが必要なteam向けのcustom worker loop。 | MCP/tool accessを明示し、隔離workspaceで動かし、使ったcommandとtoolを記録する。 |
| Codex | local repository change向けのinteractiveまたはCLI worker。 | `AGENTS.md` を読み、issue scope内に編集を留め、宣言されたcheckを実行し、残リスクを要約する。 |
| OpenHands | sandbox-orientedなsoftware engineering agent runtime。 | sandboxをworkspace boundaryとして扱い、他workerと同じPR、CI、human review gateを要求する。 |

Worker runtimeは差し替え可能にします。projectはこれらの一つ、複数、またはどれも使わない形を
選べます。その場合も、issue scope、permissions、MCP/tool access note、isolated workspace、
verification command、human approval handoffは同じcontractとして保ちます。
