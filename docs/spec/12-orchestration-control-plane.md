# 12. Orchestration Control Plane / オーケストレーション制御面

Checked on 2026-05-16.

## English

This repository treats agent orchestration as a repository contract, not as a
bundled orchestrator product. GitHub Issues, GitHub Projects, Linear, or a
similar tracker can act as the optional control plane. The repo stays usable
without Symphony, Claude Code Action, LangGraph, Google ADK, OpenHands, or any
other runtime dependency.

The control plane should answer six questions:

- What work item is eligible for an agent run?
- Which isolated workspace owns the run?
- Which worker runtime may act on the workspace?
- Which checks prove the change is ready for review?
- Which verifier or reviewer accepts the handoff?
- Which human approval is required before merge, rollback, or release?

## Work item contract

Each agent-eligible issue should define:

- `Goal`: the user-visible or operator-visible outcome.
- `Owned files`: paths the agent may edit.
- `Out of scope`: paths, systems, or policies the agent must not change.
- `Acceptance criteria`: observable checks for completion.
- `Verification`: commands, CI jobs, or static review steps.
- `Approval boundary`: who may merge, close, release, or change production-like
  policy.

For this template, a work item is not ready for autonomous execution unless its
scope is narrow enough that an agent can explain the diff, run the relevant
checks, and hand the result to a reviewer without changing unrelated policy.

## State model

The control plane may use different product names, but it should preserve these
state meanings:

| Control-plane state | Meaning | Agent action |
|---|---|---|
| `Backlog` | Captured but not ready for execution. | Do not start. |
| `Ready` | Scoped, accepted, and eligible for work. | May be claimed. |
| `In Progress` | One workspace owns the active attempt. | Implement, test, and report. |
| `Blocked` or `Stalled` | Waiting on external input, review, failed setup, or unclear scope. | Stop broad edits and report the blocker. |
| `In Review` | A PR, patch, or review artifact exists. | Respond to review and keep checks green. |
| `Done` | Merged or explicitly accepted by a human. | No further action. |

Projects without a `Blocked` state can represent it with a label or comment, but
the blocked reason should still be visible from the issue.

## Eligibility gate

An issue is eligible for an agent run when:

- It has a clear goal and acceptance criteria.
- It names the likely files, docs, scripts, or policies involved.
- It does not require hidden credentials, unpublished private context, or
  production access.
- It has an expected verification path, such as `mise run doctor-static`,
  `mise run agent-ready-json`, `mise run release-check`, or CI.
- It has a human approval boundary for merge, release, and policy changes.

An issue should stay in `Backlog` when the next safe action is research,
permission design, secret handling, or a product decision.

## Handoff protocol

When a run starts, the operator or orchestrator should record:

- Issue number and intended outcome.
- Base branch and working branch.
- Workspace identity, such as worktree, sandbox, VM, or hosted runner.
- Worker runtime, if any.
- Files expected to change.
- Verification commands to run before review.

When the run ends, the handoff should include:

- PR or patch link.
- Summary of changed behavior or docs.
- Commands run and their results.
- Remaining risks or review questions.
- Confirmation that unrelated open PRs, issues, and project boards were not
  mutated.

This is enough for a human reviewer or verifier agent to reconstruct what
happened without trusting the worker runtime's memory.

## Stalled and crashed runs

A run is stalled when it cannot make bounded progress without new input. Common
causes include missing credentials, failing dependency installation, unclear
acceptance criteria, conflicting open PRs, or tests that fail outside the
claimed scope.

The required posture is:

- Stop expanding the diff.
- Leave a short status note in the issue or PR.
- Preserve useful logs and verification output.
- Mark the item blocked or return it to `Backlog`.
- Start a fresh workspace for the next attempt if the old workspace state is no
  longer trustworthy.

A crashed run should be resumable from the issue, branch, and verification
notes. If that is not possible, the control-plane contract was too weak.

## Review gate

Agent output is not accepted merely because it produced a diff. Before merge,
the reviewer should check:

- The work matches the issue goal and acceptance criteria.
- The diff stays inside the declared scope.
- Required checks passed or failures are explained.
- Security, release, and secret-handling policies were not weakened.
- The PR body links the issue and names the verification performed.

Verifier agents can help with static review, test suggestions, or risk
summaries, but they do not replace the human approval boundary.

## Rollback and audit expectations

Every orchestration lane should leave enough evidence to rollback or audit:

- Issue link.
- PR link.
- Branch name and commit SHA.
- Verification commands and CI result.
- Reviewer or approver identity.
- Known residual risks.
- Rollback note when the change touches scripts, release gates, security docs,
  or operator workflows.

For documentation-only changes, rollback may simply mean reverting the PR. For
script, policy, CI, or runtime-profile changes, the issue should name the
expected rollback command or revert path before merge.

## Optional control planes

GitHub Issues and GitHub Projects are enough for this template's default
orchestration contract. Linear can be used when a team already manages delivery
there. A custom orchestrator may watch either system, but it should remain
replaceable.

The repository must not require a specific board, daemon, webhook, hosted
runtime, or vendor account to pass `mise run agent-ready-json`.

## Non-goals

- Do not add an orchestrator daemon.
- Do not add workflow files or API-key setup as part of this contract.
- Do not make Symphony, Claude, Codex, LangGraph, Google ADK, OpenHands, or
  SWE-agent mandatory.
- Do not treat subjective orchestration maturity as the machine-readable
  readiness score.
- Do not bypass branch protection, required review, or release gates.

## Related documents

- The planned `docs/agent-orchestration.md` positioning note is tracked by
  issue #51; until it lands, this spec remains self-contained.
- `docs/github-protection-policy.md` defines the human approval and branch
  protection posture.
- Reviewer checks for agent-generated changes should stay in issue or PR
  templates unless this repository adopts a dedicated evaluation document.
- `README.md` lists this spec in the specification docs index for
  discoverability.

## 日本語

このrepoでは、agent orchestrationを同梱orchestrator製品ではなく、repo
contractとして扱います。GitHub Issues、GitHub Projects、Linear、または同等の
trackerを任意のcontrol planeとして使えます。Symphony、Claude Code Action、
LangGraph、Google ADK、OpenHandsなどは必須依存にしません。

control planeは次の6点を明確にします。

- どのwork itemがagent実行可能か。
- どの隔離workspaceがそのrunを所有するか。
- どのworker runtimeがworkspaceを触れるか。
- どのcheckでreview可能と判断するか。
- どのverifierまたはreviewerにhandoffするか。
- merge、rollback、releaseの前にどのhuman approvalが必要か。

## Work item contract / 作業単位の契約

agentに渡せるissueには次を明記します。

- `Goal`: userまたはoperatorに見える成果。
- `Owned files`: agentが編集してよいpath。
- `Out of scope`: 触ってはいけないpath、system、policy。
- `Acceptance criteria`: 完了を観測できる条件。
- `Verification`: command、CI、静的review手順。
- `Approval boundary`: merge、close、release、production-like policy変更を
  誰が承認するか。

このtemplateでは、agentがdiffを説明し、関連checkを実行し、無関係なpolicyを変えずに
reviewへ渡せる粒度まで絞れていないwork itemは、自律実行可能とはみなしません。

## State model / 状態モデル

製品ごとに名前は違っても、次の意味を保ちます。

| State / 状態 | Meaning / 意味 | Agent action / agentの動作 |
|---|---|---|
| `Backlog` | 記録済みだが実行準備前。 | 開始しない。 |
| `Ready` | scopeが決まり、作業可能。 | claimしてよい。 |
| `In Progress` | 1つのworkspaceがactive attemptを所有。 | 実装、検証、報告を行う。 |
| `Blocked` or `Stalled` | 外部入力、review、setup失敗、不明scope待ち。 | 広い編集を止め、blockerを報告する。 |
| `In Review` | PR、patch、review artifactが存在。 | review対応し、checkをgreenに保つ。 |
| `Done` | merge済み、またはhumanが明示的に受理。 | 追加作業なし。 |

`Blocked` 状態がないProjectではlabelやcommentで表現してもよいですが、block理由は
issueから見える必要があります。

## Eligibility gate / 実行可能条件

issueがagent実行可能になる条件は次です。

- goalとacceptance criteriaが明確である。
- 触る可能性の高いfile、docs、scripts、policyが示されている。
- hidden credential、未公開private context、production accessを要求しない。
- `mise run doctor-static`、`mise run agent-ready-json`、`mise run release-check`、
  CIなどの検証経路がある。
- merge、release、policy変更のhuman approval境界がある。

次の安全な行動がresearch、permission設計、secret handling、product decisionである場合、
issueは `Backlog` に残します。

## Handoff protocol / 引き渡し

run開始時にoperatorまたはorchestratorは次を記録します。

- issue番号と期待成果。
- base branchとworking branch。
- worktree、sandbox、VM、hosted runnerなどのworkspace identity。
- worker runtimeを使う場合はその名前。
- 変更予定file。
- review前に実行するverification command。

run終了時のhandoffには次を含めます。

- PRまたはpatch link。
- 変更された挙動またはdocsの要約。
- 実行したcommandと結果。
- 残リスクまたはreview質問。
- 無関係なopen PR、issue、project boardを変更していないこと。

これにより、human reviewerやverifier agentはworker runtimeの記憶を信頼せずに
作業内容を再構成できます。

## Stalled and crashed runs / 停滞とcrash

新しい入力なしにbounded progressできないrunはstalledです。典型例は、credential不足、
dependency install失敗、acceptance criteria不明、open PR conflict、scope外のtest failureです。

必要な姿勢は次です。

- diffを広げない。
- issueまたはPRに短いstatusを残す。
- 有用なlogとverification outputを残す。
- itemをblockedにするか `Backlog` に戻す。
- 古いworkspace状態が信頼できない場合はfresh workspaceで再開する。

crashしたrunは、issue、branch、verification noteから再開できるべきです。それが無理なら
control-plane contractが弱すぎます。

## Review gate / Review境界

agent outputはdiffを作っただけでは受理されません。merge前にreviewerは次を確認します。

- issue goalとacceptance criteriaに合っている。
- diffが宣言scope内に収まっている。
- 必須checkが通っているか、失敗理由が説明されている。
- security、release、secret-handling policyを弱めていない。
- PR bodyがissueをlinkし、verificationを明記している。

verifier agentは静的review、test提案、risk summaryを補助できますが、human approval境界は
置き換えません。

## Rollback and audit expectations / Rollbackと監査

orchestration laneはrollbackまたはauditに足る証跡を残します。

- issue link。
- PR link。
- branch名とcommit SHA。
- verification commandとCI結果。
- reviewerまたはapprover identity。
- 既知の残リスク。
- scripts、release gate、security docs、operator workflowに触る場合のrollback note。

docs-only変更ではPR revertで十分なことがあります。script、policy、CI、runtime profileに
触る場合は、merge前にrollback commandまたはrevert pathをissueに書きます。

## Optional control planes / 任意のcontrol plane

このtemplateのdefault orchestration contractにはGitHub IssuesとGitHub Projectsで十分です。
既にLinearでdelivery管理しているteamはLinearを使えます。custom orchestratorがそれらを監視しても
よいですが、replaceableである必要があります。

repositoryは、特定のboard、daemon、webhook、hosted runtime、vendor accountがないと
`mise run agent-ready-json` に通らない設計にしません。

## Non-goals / 非目標

- orchestrator daemonを追加しない。
- このcontractの一部としてworkflow fileやAPI-key setupを追加しない。
- Symphony、Claude、Codex、LangGraph、Google ADK、OpenHands、SWE-agentを必須化しない。
- 主観的なorchestration maturityをmachine-readableなreadiness scoreと混ぜない。
- branch protection、required review、release gateをbypassしない。

## Related documents / 関連文書

- 予定されている `docs/agent-orchestration.md` positioning noteはissue #51で扱います。
  それが入るまで、このspecは単独で読めるようにします。
- `docs/github-protection-policy.md` はhuman approvalとbranch protectionの姿勢を定義します。
- agent生成変更を受け入れる前のreview項目は、このrepositoryが専用evaluation
  documentを採用するまではissueまたはPR templateに置きます。
- `README.md` の仕様ドキュメント一覧にもこのspecを載せ、見つけやすくします。
