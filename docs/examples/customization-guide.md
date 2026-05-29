# Customization guide / カスタマイズガイド

## English

## For Node projects

Update `mise.toml`:

```toml
[tools]
node = "22"
pnpm = "latest"
```

Update tasks:

```toml
[tasks.install]
run = "if [ -f pnpm-lock.yaml ]; then pnpm install --frozen-lockfile; else pnpm install; fi"

[tasks.test]
run = "pnpm test"
```

## For Python projects

Update `mise.toml`:

```toml
[tools]
python = "3.12"
uv = "latest"
```

Update tasks:

```toml
[tasks.install]
run = "uv sync"

[tasks.test]
run = "uv run pytest"
```

## 日本語

## Nodeプロジェクトの場合

`mise.toml` を更新します。

```toml
[tools]
node = "22"
pnpm = "latest"
```

taskを更新します。

```toml
[tasks.install]
run = "if [ -f pnpm-lock.yaml ]; then pnpm install --frozen-lockfile; else pnpm install; fi"

[tasks.test]
run = "pnpm test"
```

## Pythonプロジェクトの場合

`mise.toml` を更新します。

```toml
[tools]
python = "3.12"
uv = "latest"
```

taskを更新します。

```toml
[tasks.install]
run = "uv sync"

[tasks.test]
run = "uv run pytest"
```
