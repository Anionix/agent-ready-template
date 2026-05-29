# Development / 開発

## English

Use the standard commands:

```sh
mise run doctor
mise run doctor-static
mise run install
mise run services
mise run dev
mise run check
mise run shellcheck
mise run fuzz
mise run agent-ready
mise run release-check
```

Use `doctor-static` only when Docker is unavailable; it validates the repository contract but not service readiness.

## 日本語

標準コマンドを使います。

```sh
mise run doctor
mise run doctor-static
mise run install
mise run services
mise run dev
mise run check
mise run shellcheck
mise run fuzz
mise run agent-ready
mise run release-check
```

Dockerが使えない場合だけ `doctor-static` を使います。repository contractは検証しますが、service readinessは検証しません。

## Service profiles / サービスprofile

Default services:

```sh
docker compose up -d
scripts/wait-for-services.sh
```

Debug tools:

```sh
docker compose --profile debug up -d
WAIT_SERVICES="postgres redis mailpit" scripts/wait-for-services.sh
```

Storage tools:

```sh
docker compose --profile storage up -d
WAIT_SERVICES="postgres redis minio" scripts/wait-for-services.sh
```
