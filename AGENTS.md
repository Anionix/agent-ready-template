# AGENTS.md

## Source of truth / 正本

This file is the source of truth for all AI coding agents working in this repository.

このファイルは、このリポジトリで作業するすべてのAI coding agent向けの正本です。

## Project goal / プロジェクト目的

This repository defines a lightweight template for repositories that must be safe and predictable for human developers, AI coding agents, and CI.

このリポジトリは、人間の開発者、AI coding agent、CIが安全かつ予測可能に扱える軽量リポジトリテンプレートを定義します。

## Standard workflow for agents / agent標準ワークフロー

1. Run `mise run doctor`.
2. If Docker is unavailable, run `mise run doctor-static` and report that the full service lane is unverified.
3. Run `mise run install` if dependencies are missing.
4. Run `mise run services` before tests requiring local services.
5. Make the smallest focused change.
6. Run `mise run check`.
7. Run `mise run release-check` for public-template, CI, safety, or release-readiness changes.
8. Report changed files, commands run, and remaining risks.

1. `mise run doctor` を実行する。
2. Dockerが使えない場合は `mise run doctor-static` を実行し、full service lane未検証を報告する。
3. 依存関係が不足している場合は `mise run install` を実行する。
4. ローカルサービスが必要なテストの前に `mise run services` を実行する。
5. 最小で焦点の定まった変更を行う。
6. `mise run check` を実行する。
7. 公開テンプレート、CI、安全性、release readinessの変更では `mise run release-check` を実行する。
8. 変更ファイル、実行コマンド、残リスクを報告する。

## Required commands / 必須コマンド

- Check environment / 環境確認: `mise run doctor`
- Static environment check / 静的環境確認: `mise run doctor-static`
- Install dependencies / 依存インストール: `mise run install`
- Start services / サービス起動: `mise run services`
- Start app / アプリ起動: `mise run dev`
- Run final checks / 最終確認: `mise run check`
- Lint workflows / workflow lint: `mise run workflow-lint`
- Audit workflow pins / workflow pin audit: `mise run workflow-pin-audit`
- Audit Dockerfile pins / Dockerfile pin audit: `mise run dockerfile-pin-audit`
- Lint optional Dockerfiles / 任意Dockerfile lint: `mise run dockerfile-lint`
- Lint shell scripts / shell script lint: `mise run shellcheck`
- Run optional fuzz harness / 任意fuzz harness実行: `mise run fuzz`
- Generate Go coverage evidence / Go coverage evidence生成: `mise run go-coverage`
- List optional sandbox profiles / 任意sandbox profile表示: `mise run sandbox-profiles`
- Check agent readiness / agent readiness確認: `mise run agent-ready`
- Emit agent readiness JSON / agent readiness JSON出力: `mise run agent-ready-json`
- Emit static agent readiness JSON / 静的agent readiness JSON出力: `mise run agent-ready-static-json`
- Check public release readiness / 公開準備確認: `mise run public-release-check`
- Run dedicated secret scanners / 専用secret scanner実行: `mise run secret-scan`
- Run full release gate / release gate実行: `mise run release-check`
- Reset local services / ローカルサービス初期化: `mise run reset`

## Completion criteria / 完了条件

A coding task is complete only when:

- `mise run check` passes
- public-template release changes pass `mise run release-check`
- changed files are listed
- commands run are reported
- remaining risks are reported

コーディングタスクは、次を満たした時だけ完了です。

- `mise run check` が通る
- 公開テンプレートrelease変更では `mise run release-check` が通る
- 変更ファイルを列挙する
- 実行コマンドを報告する
- 残リスクを報告する

## Safety rules / 安全ルール

- Do not read or modify `.env`, `.env.*`, `secrets/**`, SSH keys, cloud credentials, or production credentials.
- Do not run destructive database commands outside local development.
- Do not add production dependencies without explaining why.
- Do not modify generated files unless the task requires it.
- Prefer small, focused changes.
- Use `docs/threat-model.md` and `docs/sandbox-profiles.md` when deciding whether optional sandbox profiles are needed.
- Use repository-scoped or auto-review permissions by default; full access is an exception for bounded maintenance only.
- Run `mise run release-check` before publishing, changing repository visibility, or preparing a clean-history release.
- Treat `mise run doctor-static` and `mise run agent-ready-static-json` as static validation only; they do not prove service readiness.
- If a command fails, report the exact command and error.

- `.env`、`.env.*`、`secrets/**`、SSH鍵、cloud credentials、本番credentialを読んだり変更したりしない。
- local development以外で破壊的DBコマンドを実行しない。
- production dependencyを追加する場合は理由を説明する。
- 必要がない限りgenerated fileを変更しない。
- 小さく焦点の定まった変更を優先する。
- 任意sandbox profileが必要か判断する場合は `docs/threat-model.md` と `docs/sandbox-profiles.md` を参照する。
- 通常はrepository-scopedまたはauto-review権限で作業する。full accessは範囲を限定した保守作業だけの例外とする。
- 公開、repository visibility変更、clean-history release準備の前に `mise run release-check` を実行する。
- `mise run doctor-static` と `mise run agent-ready-static-json` は静的検証だけとして扱い、service readinessの証明にはしない。
- コマンドが失敗した場合は、正確なコマンドとエラーを報告する。

## Report format / 報告フォーマット

```text
Summary:
- ...

Changed files:
- ...

Commands run:
- ...

Result:
- ...

Remaining risks:
- ...
```
