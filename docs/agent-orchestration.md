# Agent Orchestration / Agent orchestration

Checked on 2026-05-16.

## English

Agent orchestration in this template means coordinating work, state,
validation, permissions, and review. It does not mean adding more agents or
shipping a bundled orchestrator runtime.

The default repository contract remains small:

```sh
mise run doctor
mise run install
mise run check
mise run agent-ready
```

Orchestration readiness adds vocabulary for teams that want to move from
interactive coding-agent sessions to issue-driven work:

```text
Issue / Project board / Linear
  -> triage and eligibility
  -> isolated workspace or worktree
  -> replaceable worker agent
  -> tests, lint, static analysis, CI
  -> verifier or reviewer agent
  -> human approval
  -> merge, rollback, and audit log
```

## Positioning

| Reference | What to learn | Template boundary |
|---|---|---|
| OpenAI Symphony | Treat the issue tracker as the control plane. Map each eligible task to an isolated agent workspace, recover stalled or crashed runs, and hand work back for human review. | This repository does not ship Symphony or an orchestrator daemon. It captures the contract a downstream orchestrator should rely on. |
| Claude Code / Claude Agent SDK | Use specialized worker roles, MCP tool access, permissions, hooks, and reviewable handoffs. | Claude-specific setup remains optional. No Claude workflow, API key, or SDK dependency is required by default. |
| LangGraph | Use durable execution and human-in-the-loop checkpoints for long-running workflows. | LangGraph is a design reference, not a required dependency. |
| Google ADK | Keep build, evaluate, debug, and deploy concerns explicit for agent systems. | ADK is an optional framework reference, not part of this template contract. |
| SWE-Cycle | Evaluate environment reconstruction, implementation, and verification test generation as one lifecycle. | Use it to shape eval language, not to replace local checks. |
| MCP-Atlas | Evaluate realistic tool discovery, multi-step tool use, error recovery, and claim-level scoring. | Use it to shape MCP/tool-use evaluation notes, not as a CI dependency. |

## Contract Shape

An orchestration-ready repo should make the following explicit:

- **Work item**: the issue, ticket, or task is the unit of work.
- **Eligibility**: only issues in approved states are eligible for agent runs.
- **Workspace**: each run gets a separate worktree, sandbox, or other isolated workspace.
- **Worker**: Claude, Codex, OpenHands, SWE-agent, or another coding agent can be swapped in.
- **Verification**: local checks, CI, reviewer agents, and humans are separate gates.
- **Handoff**: CI success is not approval; required review remains a policy boundary.
- **Recovery**: stalled, crashed, or low-confidence work is stopped, retried, or returned to humans.
- **Audit**: the run should leave links to issues, branches, PRs, checks, review notes, and rollback notes.

## Worker Runtime Notes

Workers are replaceable execution choices behind the same repo contract:

- **Claude Code Action**: optional GitHub issue or PR worker. Keep repository
  permissions scoped, avoid broad secret exposure, and require a PR handoff for
  human approval.
- **Claude Agent SDK**: optional custom worker loop for MCP tools, hooks,
  telemetry, and app integration. Keep tool access explicit and log commands and
  MCP/tool use in the handoff.
- **Codex**: optional interactive or CLI worker for local repo changes. It
  should read `AGENTS.md`, keep edits inside the issue scope, run declared
  checks, and summarize residual risks.
- **OpenHands**: optional sandbox-oriented software engineering runtime. Treat
  the sandbox as the workspace boundary and still require PR, CI, verifier, and
  human review gates.

The worker choice must not change the approval boundary. CI success, tool-loop
completion, or sandbox completion is evidence for review, not approval itself.

## Metrics

Do not judge orchestration by PR count alone. Track:

- Review time.
- CI failure rate.
- Merge-after-bug rate.
- Rollback rate.
- Human intervention count.
- Cost per merged PR.
- Unnecessary PR rate.

## Non-goals

- Do not require Symphony, Claude Code Action, Claude Agent SDK, LangGraph, Google ADK, OpenHands, or SWE-agent.
- Do not add API keys, provider accounts, background daemons, workflow files, npm dependencies, or pip dependencies by default.
- Do not treat subjective orchestration maturity as the machine-readable `agent-ready-json` score.
- Do not bypass required human review just because CI is green.

## 日本語

このtemplateでのagent orchestrationは、仕事、状態、検証、権限、reviewを束ねることです。agentを増やすことや、orchestrator runtimeを同梱することではありません。

標準のrepository contractは小さく保ちます。

```sh
mise run doctor
mise run install
mise run check
mise run agent-ready
```

Orchestration readinessは、interactiveなcoding-agent sessionから、issue-drivenな仕事管理へ移るteam向けの語彙です。

```text
Issue / Project board / Linear
  -> triage and eligibility
  -> isolated workspace or worktree
  -> replaceable worker agent
  -> tests, lint, static analysis, CI
  -> verifier or reviewer agent
  -> human approval
  -> merge, rollback, and audit log
```

## Positioning / 位置づけ

| Reference | 学ぶこと | template上の境界 |
|---|---|---|
| OpenAI Symphony | issue trackerをcontrol planeとして扱い、eligibleなtaskを隔離workspaceのagent runへ対応づけ、stalled/crashed runを復旧し、人間reviewへ渡す。 | このrepositoryはSymphonyやorchestrator daemonを同梱しません。downstream orchestratorが頼れるcontractを文書化します。 |
| Claude Code / Claude Agent SDK | 専門worker role、MCP tool access、permissions、hooks、review可能なhandoffを使う。 | Claude固有setupはoptionalです。Claude workflow、API key、SDK dependencyはdefaultでは不要です。 |
| LangGraph | long-running workflow向けにdurable executionとhuman-in-the-loop checkpointを使う。 | LangGraphは設計referenceであり、必須dependencyではありません。 |
| Google ADK | agent systemのbuild、evaluate、debug、deployを明示する。 | ADKはoptional framework referenceであり、このtemplate contractには含めません。 |
| SWE-Cycle | environment reconstruction、implementation、verification test generationを一つのlifecycleとして評価する。 | local checksを置き換えず、eval vocabularyの参考にします。 |
| MCP-Atlas | tool discovery、multi-step tool use、error recovery、claim-level scoringを現実的に評価する。 | MCP/tool-use evaluation noteの参考にし、CI dependencyにはしません。 |

## Contract Shape / 契約の形

Orchestration-ready repoでは、次を明示します。

- **Work item**: issue、ticket、taskを仕事単位にする。
- **Eligibility**: 承認された状態のissueだけをagent run対象にする。
- **Workspace**: runごとに別worktree、sandbox、または隔離workspaceを使う。
- **Worker**: Claude、Codex、OpenHands、SWE-agent、その他coding agentを差し替え可能にする。
- **Verification**: local checks、CI、reviewer agent、人間reviewを別gateとして扱う。
- **Handoff**: CI成功はapprovalではない。required reviewはpolicy boundaryとして残す。
- **Recovery**: stalled、crashed、低信頼のworkは停止、retry、または人間へ戻す。
- **Audit**: issue、branch、PR、check、review note、rollback noteへのlinkを残す。

## Worker Runtime Notes / worker runtimeの位置づけ

Workerは、同じrepo contractの背後にある差し替え可能な実行選択肢です。

- **Claude Code Action**: optionalなGitHub issue / PR worker。repository permissionを
  scopeし、広いsecret露出を避け、human approvalのためにPR handoffを必須にします。
- **Claude Agent SDK**: MCP tools、hooks、telemetry、app integration向けのoptionalな
  custom worker loop。tool accessを明示し、commandとMCP/tool useをhandoffに記録します。
- **Codex**: local repo change向けのoptionalなinteractive / CLI worker。`AGENTS.md` を読み、
  issue scope内に編集を留め、宣言されたcheckを実行し、残リスクを要約します。
- **OpenHands**: optionalなsandbox-oriented software engineering runtime。sandboxを
  workspace boundaryとして扱い、それでもPR、CI、verifier、human review gateを必須にします。

worker choiceはapproval boundaryを変えません。CI success、tool-loop completion、
sandbox completionはreview材料であり、approvalそのものではありません。

## Metrics / 指標

PR数だけでorchestrationを評価しません。次を追います。

- review time
- CI failure rate
- merge-after-bug rate
- rollback rate
- human intervention count
- cost per merged PR
- unnecessary PR rate

## Non-goals / 非目標

- Symphony、Claude Code Action、Claude Agent SDK、LangGraph、Google ADK、OpenHands、SWE-agentを必須化しません。
- API key、provider account、background daemon、workflow file、npm dependency、pip dependencyをdefaultで追加しません。
- 主観的なorchestration maturityをmachine-readableな `agent-ready-json` scoreと混ぜません。
- CIがgreenでも、required human reviewを迂回しません。
