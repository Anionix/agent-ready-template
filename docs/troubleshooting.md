# Troubleshooting / トラブルシューティング

## English

## First command

```sh
mise run doctor
```

## Docker daemon is not running

`mise run doctor` is the full service lane. It checks Docker and Docker Compose. If it cannot connect to the Docker socket, start Docker Desktop, OrbStack, Colima, or another Docker-compatible runtime, then rerun:

```sh
mise run doctor
docker compose config
```

For Docker-free static validation while setting up the runtime, run:

```sh
mise run doctor-static
mise run agent-ready-static-json
```

Static validation does not prove service readiness and is not enough for public release readiness.

## Ports already in use

Postgres uses `5432` and Redis uses `6379` by default. If `docker compose up -d` fails, stop the conflicting local service or change the published port in `compose.yaml`.

## Dependencies missing

```sh
mise run install
```

If `package.json` exists and `pnpm-lock.yaml` does not, the first install runs normal `pnpm install` so the lockfile can be created. Commit the lockfile with the app changes.

## Services unhealthy

```sh
mise run reset
scripts/wait-for-services.sh
```

`WAIT_SERVICES` can narrow or expand service waiting:

```sh
WAIT_SERVICES="postgres redis" scripts/wait-for-services.sh
```

## Compose config invalid

```sh
docker compose config
```

## Secret scanner failures

Run the custom public gate first to separate repository-policy failures from scanner findings:

```sh
mise run public-release-check
mise run secret-scan
```

If a scanner reports a false positive, remove realistic token shapes from docs or examples where possible. Otherwise document the false positive in the PR and add a narrowly scoped scanner allowlist only when necessary.

## Workflow lint failures

```sh
mise run workflow-lint
```

Fix invalid GitHub Actions syntax before checking runtime behavior. CI uses the same workflow lint gate.

## Workflow pin audit failures

```sh
mise run workflow-pin-audit
```

External GitHub Actions must be pinned to full 40-character commit SHAs. Local actions using `uses: ./...` are allowed.

## GitHub protection API fails

Private repositories may not support all branch protection or ruleset features on every GitHub plan. Keep using the local release gates while private, then apply protection after public release:

```sh
scripts/apply-main-branch-protection.sh --apply --strict
mise run github-protection-status
```

## Copilot setup workflow fails

Run the same setup path locally:

```sh
mise install
mise run install
mise run doctor
```

The setup workflow should stay small; project-specific app bootstrap belongs in `mise.toml`.

## 日本語

## 最初に実行するコマンド

```sh
mise run doctor
```

## Docker daemonが起動していない

`mise run doctor` はfull service laneです。DockerとDocker Composeを確認します。Docker socketへ接続できない場合は、Docker Desktop、OrbStack、Colima、または別のDocker互換runtimeを起動してから再実行します。

```sh
mise run doctor
docker compose config
```

runtime準備中にDockerなしの静的検証だけ行う場合は、次を実行します。

```sh
mise run doctor-static
mise run agent-ready-static-json
```

静的検証はservice readinessを証明しないため、公開準備完了には不足します。

## portが既に使用されている

Postgresは標準で `5432`、Redisは `6379` を使います。`docker compose up -d` が失敗する場合は、競合しているlocal serviceを止めるか、`compose.yaml` の公開portを変更します。

## 依存関係が不足している

```sh
mise run install
```

`package.json` があり `pnpm-lock.yaml` がない場合、初回だけ通常の `pnpm install` を実行してlockfile生成を許します。app変更と一緒にlockfileをcommitします。

## サービスが不健全

```sh
mise run reset
scripts/wait-for-services.sh
```

`WAIT_SERVICES` で待機対象を指定できます。

```sh
WAIT_SERVICES="postgres redis" scripts/wait-for-services.sh
```

## Compose設定が不正

```sh
docker compose config
```

## secret scannerが失敗する

まず独自の公開前gateを実行し、repository policy違反とscanner検出を切り分けます。

```sh
mise run public-release-check
mise run secret-scan
```

false positiveの場合でも、可能ならdocsやexampleから本物に見えるtoken形状を避けます。必要な場合だけ、PRに理由を書いて狭いallowlistを追加します。

## workflow lintが失敗する

```sh
mise run workflow-lint
```

GitHub Actionsの構文を先に直します。CIも同じworkflow lint gateを使います。

## workflow pin auditが失敗する

```sh
mise run workflow-pin-audit
```

外部GitHub Actionsは40文字のfull commit SHAにpinします。`uses: ./...` のlocal actionは許可します。

## GitHub protection APIが失敗する

private repositoryでは、GitHub planによってbranch protectionやrulesetsが使えない場合があります。privateの間はlocal release gateで守り、公開後に保護を適用します。

```sh
scripts/apply-main-branch-protection.sh --apply --strict
mise run github-protection-status
```

## Copilot setup workflowが失敗する

同じsetup経路をlocalで確認します。

```sh
mise install
mise run install
mise run doctor
```

setup workflowは小さく保ちます。project固有のbootstrapは `mise.toml` に置きます。
