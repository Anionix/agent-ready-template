# Threat Model / Threat model

## English

This template assumes most normal development can stay lightweight: host tools, `mise`, Docker Compose, and a small shared command contract. Sandbox profiles are optional escalation paths for work that would be risky on the host.

Use a sandbox profile when any of these apply:

- an agent has broad permissions or long-running autonomy
- the task executes unknown scripts, generated shell commands, or dependency upgrades
- infrastructure, CI, release, or deployment code is being modified
- multiple agents run in parallel
- secrets, credentials, production data, browser profiles, or private home-directory state may be nearby

The strongest trigger is the lethal-trifecta pattern:

```text
private data
+ untrusted content
+ external communication
= sandbox required
```

Examples:

- reading private repository files while browsing external issue text and using network tools
- running generated code near credentials with outbound internet enabled
- allowing an always-on assistant to read local state and post messages or make API calls

Before selecting a profile, read `docs/sandbox-footguns.md` and `docs/sandbox-adoption-checklist.md` to avoid weakening the boundary with host mounts, real secrets, Docker socket access, broad network egress, or shared worktrees.

## Profile guidance

- `os-sandbox/ai-jail`: lightweight process sandbox for daily risky tasks. It shares the host kernel and is not a hardware boundary.
- `microvm-dev/michael-style`: stronger VM boundary for higher-risk agent work on NixOS hosts. It is a pattern and starter artifact, not a CI requirement.
- `microvm-dev/nixbox-style` and `docker-sandbox/docker-sandboxes`: optional comparison/profile notes. They do not make Nixbox, KVM, Docker Sandboxes, or Docker Desktop features required by CI.
- OpenClaw runtime notes are for always-on assistant threat boundaries and policy references. They do not install OpenClaw, OpenShell, or NemoClaw.
- Cloud and embedded runtime profiles are future adapter references. They should not be required by this repository's default checks.

## 日本語

このテンプレートでは、通常の開発は軽量なまま扱います。host tool、`mise`、Docker Compose、少数の共有command contractが標準です。Sandbox profileは、host上で実行すると危険な作業だけに使う任意の昇格先です。

次の場合はsandbox profileを使います。

- agentに広い権限や長時間の自律実行を与える
- 未知のscript、生成されたshell command、dependency upgradeを実行する
- infrastructure、CI、release、deployment codeを変更する
- 複数agentを並列実行する
- secret、credential、本番data、browser profile、private home-directory状態が近くにある

特に強い発動条件は lethal-trifecta pattern です。

```text
private data
+ untrusted content
+ external communication
= sandbox required
```

例:

- private repository fileを読みながら、外部issue本文を参照し、network toolも使う
- credentialの近くで生成codeを実行し、outbound internetも許可する
- always-on assistantにlocal stateを読ませ、message投稿やAPI callも許す

profileを選ぶ前に `docs/sandbox-footguns.md` と `docs/sandbox-adoption-checklist.md` を読み、host mount、本物のsecret、Docker socket access、広いnetwork egress、共有worktreeで境界を弱めないようにします。

## Profile guidance / profile指針

- `os-sandbox/ai-jail`: 日常的な危険作業向けの軽量process sandbox。host kernelを共有するため、hardware boundaryではありません。
- `microvm-dev/michael-style`: NixOS host上の高リスクagent作業向けに、より強いVM境界を使うpattern。CI要件ではありません。
- `microvm-dev/nixbox-style` と `docker-sandbox/docker-sandboxes`: 任意のcomparison/profile noteです。Nixbox、KVM、Docker Sandboxes、Docker Desktop featureをCI要件にしません。
- OpenClaw runtime noteはalways-on assistantのthreat boundaryとpolicy reference向けです。OpenClaw、OpenShell、NemoClawをinstallしません。
- cloudとembedded runtime profileは将来adapter referenceです。このrepositoryのdefault checkでは必須にしません。
