# 04. Runtime and Containers / ランタイムとコンテナ

## English

## Recommended default

```text
macOS:
  OrbStack recommended
  Colima fallback
  Docker Desktop acceptable if team policy requires it

Repository:
  depend only on docker and docker compose
```

The repository must not rely on runtime-specific behavior.

## Required interface

The repository may assume these commands exist:

```sh
docker
docker compose
mise
```

## Do not depend on

- OrbStack-specific networking behavior
- OrbStack-only volume paths
- Docker Desktop-only features
- Colima-specific VM paths

## 日本語

## 標準推奨

```text
macOS:
  OrbStack推奨
  Colima fallback
  チームポリシー上必要ならDocker Desktopも可

Repository:
  docker と docker compose のinterfaceにだけ依存する
```

repoは特定ランタイム固有の挙動に依存しません。

## 必須interface

repoが前提にしてよいコマンドは次です。

```sh
docker
docker compose
mise
```

## 依存しないもの

- OrbStack固有のネットワーク挙動
- OrbStack専用volume path
- Docker Desktop専用機能
- Colima固有VM path
