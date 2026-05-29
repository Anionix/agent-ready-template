# 06. Readiness Check / Readiness検証

## English

The template should include an agent readiness check.

The check should verify:

- required instruction files exist
- standard tasks exist
- CI exists
- `.env.example` exists
- safety docs exist
- public release readiness check exists
- optional adapters are present when configured
- shell scripts parse and are executable
- Compose config is valid
- static mode can skip Compose config without claiming service readiness
- GitHub Actions workflows lint
- external GitHub Actions are pinned to full commit SHAs
- commands documented in `AGENTS.md` exist in `mise.toml`

Command:

```sh
mise run agent-ready
mise run agent-ready-json
scripts/agent-ready-check.sh --static --json
mise run public-release-check
mise run secret-scan
```

## 日本語

テンプレートにはagent readiness checkを含めます。

検証対象は次です。

- 必須instruction fileが存在する
- 標準taskが存在する
- CIが存在する
- `.env.example` が存在する
- safety docsが存在する
- 公開準備checkが存在する
- 設定されているoptional adapterが存在する
- shell scriptがparseでき、実行権限を持つ
- Compose configが有効である
- static modeではservice readinessを主張せずにCompose configだけをskipできる
- GitHub Actions workflowがlintを通る
- 外部GitHub Actionsがfull commit SHAにpinされている
- `AGENTS.md` に書かれたcommandが `mise.toml` に存在する

コマンド:

```sh
mise run agent-ready
mise run agent-ready-json
scripts/agent-ready-check.sh --static --json
mise run public-release-check
mise run secret-scan
```

## Suggested scoring / 推奨スコア

| Area | Points |
|---|---:|
| `AGENTS.md` source of truth | 20 |
| `mise` standard commands | 20 |
| Docker Compose service layer | 10 |
| CI uses same checks | 15 |
| Claude/Cursor/Aider/Copilot adapters | 15 |
| Safety and public release policy | 10 |
| Troubleshooting and lessons | 10 |
| Total | 100 |
