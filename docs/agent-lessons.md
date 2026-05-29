# Agent lessons / Agent学習メモ

## English

Use this file to record repeated failures and fixes.

## 日本語

このファイルには、繰り返し起きる失敗と修正方法を記録します。

## Lesson format / 記録形式

```md
## YYYY-MM-DD: Title

Failure:
- ...

Root cause:
- ...

Fix:
- ...

Related files:
- ...
```

## Lessons / 記録

### Example: tests failed because services were not running

Failure:
- Tests failed with connection refused.

Root cause:
- Postgres was not running.

Fix:
- Run `mise run services` before service-dependent tests.
