# Container runtime policy / コンテナランタイムポリシー

## English

## Recommended runtime

Use OrbStack on macOS for local development.

## Supported fallback

If OrbStack cannot be used, use Colima or another Docker-compatible runtime.

## Required interface

This repository only requires:

- `docker`
- `docker compose`

## Do not depend on

- OrbStack-specific networking behavior
- OrbStack-only volume paths
- Docker Desktop-only features
- Colima-specific VM paths

## 日本語

## 推奨ランタイム

macOSのローカル開発ではOrbStackを推奨します。

## fallback

OrbStackが使えない場合は、ColimaなどDocker互換runtimeを使います。

## 必須interface

このリポジトリが必要とするのは次だけです。

- `docker`
- `docker compose`

## 依存しないもの

- OrbStack固有のネットワーク挙動
- OrbStack専用volume path
- Docker Desktop専用機能
- Colima固有VM path
