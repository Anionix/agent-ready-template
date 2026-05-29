# 02. Repository Contract / リポジトリ契約

## English

A repository contract is the set of files and commands that define how humans, agents, and CI interact with the project.

## Required files / 必須ファイル

| File | Role |
|---|---|
| `AGENTS.md` | Source of truth for AI coding agents |
| `CLAUDE.md` | Thin Claude Code adapter |
| `CONVENTIONS.md` | Aider conventions adapter |
| `mise.toml` | Tool and task API |
| `compose.yaml` | Local services |
| `.env.example` | Environment variable specification |
| `.github/workflows/ci.yml` | CI verification |
| `.github/CODEOWNERS` | Ownership for public-strict branch protection |
| `scripts/doctor.sh` | Environment diagnostics |
| `scripts/agent-ready-check.sh` | Agent readiness validation |
| `scripts/secret-scan.sh` | Dedicated secret scanner gate |
| `scripts/workflow-pin-audit.sh` | GitHub Actions pin validation |

## Standard commands / 標準コマンド

```sh
mise run doctor
mise run doctor-static
mise run install
mise run services
mise run check
mise run workflow-lint
mise run workflow-pin-audit
mise run agent-ready
mise run agent-ready-json
mise run public-release-check
mise run secret-scan
mise run release-check
```

## Completion criteria / 完了条件

A coding task is complete only when:

- `mise run check` passes
- release-readiness changes pass `mise run release-check`
- changed files are listed
- commands run are reported
- remaining risks are reported

コーディングタスクは、次を満たした時だけ完了です。

- `mise run check` が通る
- release readiness変更では `mise run release-check` が通る
- 変更ファイルが列挙されている
- 実行したコマンドが報告されている
- 残リスクが報告されている

## Required report format / 報告フォーマット

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
