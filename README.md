# Agent-ready Repository Template / Agent-readyリポジトリテンプレート

## English

This is not an app starter. It is a minimal repository contract for humans, AI coding agents, and CI.

This repository is the clean canonical template snapshot derived from
`Anionix/agent-ready-repo-template-spec` `v0.1.1`, the release line used as
the OpenSSF Best Practices Silver baseline. A live OpenSSF badge is
intentionally withheld until the Best Practices project is updated or
revalidated for this repository.

The template keeps local development simple with `mise` and Docker Compose, uses `AGENTS.md` as the source of truth, and provides thin adapters for Claude Code, Cursor, and GitHub Copilot. It is designed for projects that want predictable agent behavior plus selectable sandbox profiles without making Dev Containers, Nix, KVM, or cloud sandboxes mandatory.

Template-instance status is tracked in `docs/openssf-best-practices.md`. Downstream repositories created from this template should register their own OpenSSF Best Practices project before adding a live badge.
The migration tracking sheet for this instance is `docs/openssf-checksheet-12855.yml`, generated with the unofficial `ossf-badge-workbench` helper.

## 日本語

これはアプリケーションスターターではありません。人間、AI coding agent、CIが同じ契約で作業するための最小リポジトリテンプレートです。

このリポジトリは、OpenSSF Best Practices Silver baseline として使われた
`Anionix/agent-ready-repo-template-spec` `v0.1.1` release line から作った、
clean な正本テンプレートsnapshotです。OpenSSF Best Practices project がこの
repository向けに更新または再検証されるまでは、live badge は意図的に表示しません。

ローカル開発は `mise` と Docker Compose で軽く保ち、`AGENTS.md` を正本にして、Claude Code / Cursor / GitHub Copilot 向けadapterを薄く追加します。Dev Container、Nix、KVM、cloud sandboxを必須にせず、予測可能なagent作業と選択式sandbox profileを両立することを目的にしています。

このtemplate instanceの状態は `docs/openssf-best-practices.md` で追跡します。このtemplateから作成したdownstream repositoryでは、live badgeを追加する前に各repository自身のOpenSSF Best Practices projectを登録してください。
このinstance向けのmigration tracking sheetは `docs/openssf-checksheet-12855.yml` で、非公式helper `ossf-badge-workbench` で生成します。

## Quickstart / クイックスタート

Use this repository as a GitHub template, then run:

```sh
mise install
mise run doctor
mise run install
mise run agent-ready
mise run check
```

GitHub templateとして新規repoを作成したら、上のコマンドで契約と検証面を確認します。

If Docker is not installed or the daemon is not running, use the static lane while you set up a Docker-compatible runtime:

```sh
mise run doctor-static
mise run agent-ready-static-json
```

`doctor-static` validates the repository contract without claiming service readiness. Public release readiness still requires the full `mise run release-check` lane.

Dockerが未導入またはdaemon未起動の場合は、Docker互換runtimeを準備する間にstatic laneを使えます。

```sh
mise run doctor-static
mise run agent-ready-static-json
```

`doctor-static` はrepository contractだけを検証し、service readinessまでは完了扱いにしません。公開準備完了には引き続きfull laneの `mise run release-check` が必要です。

If the project adds `package.json`, commit `pnpm-lock.yaml` with it. Without a lockfile, `mise run install` runs a normal `pnpm install` once so the lockfile can be created.

`package.json` を追加する場合は `pnpm-lock.yaml` もcommitします。lockfileがない初回だけ、`mise run install` は通常の `pnpm install` を実行してlockfile生成を許します。

## Standard commands / 標準コマンド

```sh
mise run doctor
mise run doctor-static
mise run install
mise run services
mise run check
mise run workflow-lint
mise run workflow-pin-audit
mise run dockerfile-pin-audit
mise run dockerfile-lint
mise run shellcheck
mise run fuzz
mise run go-coverage
mise run sandbox-profiles
mise run agent-ready
mise run agent-ready-json
mise run agent-ready-static-json
mise run public-release-check
mise run secret-scan
mise run release-check
mise run github-protection-status
```

## Agent kickoff prompt / agent開始プロンプト例

```text
Read AGENTS.md first. Follow the repository command contract.
Before editing, run mise run doctor and inspect the relevant files.
If Docker is unavailable, run mise run doctor-static and report that the full service lane is unverified.
After editing, run mise run check and report changed files, commands run, and remaining risks.
Do not read or modify secrets, real .env files, SSH keys, or local machine credentials.
```

## Sandbox profiles / sandbox profile

Sandbox profiles are optional add-ons for higher-risk agent work. The MVP includes a lightweight `ai-jail` profile and a Michael-style NixOS `microvm.nix` starter profile.

```sh
mise run sandbox-profiles
```

Read `docs/threat-model.md`, `docs/sandbox-profiles.md`, `docs/sandbox-footguns.md`, `docs/sandbox-adoption-checklist.md`, and `profiles/README.md` before adopting a profile. CI does not require Nix, KVM, `ai-jail`, Docker Sandboxes, OpenClaw, cloud providers, BoxLite, or Microsandbox.

Sandbox profileは高リスクなagent作業向けの任意追加層です。MVPでは軽量な `ai-jail` profileと、Michael-style NixOS `microvm.nix` starter profileを含めます。

profile採用前に `docs/threat-model.md`、`docs/sandbox-profiles.md`、`docs/sandbox-footguns.md`、`docs/sandbox-adoption-checklist.md`、`profiles/README.md` を読んでください。CIではNix、KVM、`ai-jail`、Docker Sandboxes、OpenClaw、cloud provider、BoxLite、Microsandboxを要求しません。

## Specification docs / 仕様ドキュメント

- `docs/spec/00-overview.md`
- `CONTRIBUTING.md`
- `CODE_OF_CONDUCT.md`
- `GOVERNANCE.md`
- `MAINTAINERS.md`
- `CHANGELOG.md`
- `docs/spec/07-github-template-guide.md`
- `docs/spec/08-scoring-model.md`
- `docs/spec/11-competitive-comparison.md`
- `docs/spec/12-orchestration-control-plane.md`
- `docs/agent-orchestration.md`
- `docs/orchestration-workflow.md`
- `docs/threat-model.md`
- `docs/sandbox-profiles.md`
- `docs/sandbox-footguns.md`
- `docs/sandbox-adoption-checklist.md`
- `docs/network-dns-audit-boundaries.md`
- `docs/cloud-sandbox-adapters.md`
- `docs/ci-runner-hardening.md`
- `docs/architecture.md`
- `docs/openssf-best-practices.md`
- `docs/openssf-checksheet-12855.yml`
- `docs/openssf-checksheet-template.md`
- `templates/openssf-checksheet.template.yml`
- `schemas/openssf-checksheet.schema.json`
- `examples/openssf-checksheet.example.yml`
- `docs/release-process.md`
- `docs/security-workflows.md`
- `docs/roadmap.md`
- `profiles/README.md`
- `docs/github-protection-policy.md`

## Public release readiness / 公開準備

Before publishing this template or changing repository visibility, run the release gate:

```sh
mise run release-check
```

This is the full lane: it includes Docker/service checks, static contract checks, workflow pin auditing, and secret scanning.

公開やrepository visibility変更の前に、release gateを実行します。これはfull laneであり、Docker/service確認、静的contract確認、workflow pin audit、secret scanningを含みます。

After publishing, protect `main` before accepting normal contributions:

```sh
scripts/apply-main-branch-protection.sh --apply --strict
mise run github-protection-status
```

公開後、通常のcontributionを受ける場合は `--strict` で `main` を保護します。個人運用では `scripts/apply-main-branch-protection.sh --apply` のsolo modeも使えます。
