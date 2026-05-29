# Agent safety policy / Agent安全ポリシー

## English

## Default mode

Agents may run in the host environment for normal local development tasks.

## Sandbox required

Use a selectable sandbox profile when:

- running an agent with broad permissions
- modifying infrastructure code
- running unknown scripts
- testing dependency upgrades
- executing generated shell commands
- working with multiple agents in parallel

See `docs/threat-model.md` for escalation criteria and `docs/sandbox-profiles.md` for the profile taxonomy.

## Secrets

Agents must not read:

- `.env`
- `.env.*`
- `secrets/**`
- SSH keys
- cloud credentials
- production credentials

Before public release or visibility changes, run:

```sh
mise run release-check
```

## 日本語

## 標準モード

通常のローカル開発タスクでは、agentはホスト環境で実行してよいです。

## sandbox必須条件

次の場合は選択式sandbox profileを使います。

- 広い権限を持つagentを実行する
- infrastructure codeを変更する
- 不明なscriptを実行する
- dependency upgradeを試す
- 生成されたshell commandを実行する
- 複数agentを並列実行する

昇格条件は `docs/threat-model.md`、profile分類は `docs/sandbox-profiles.md` を参照します。

## secrets

agentは次を読んではいけません。

- `.env`
- `.env.*`
- `secrets/**`
- SSH keys
- cloud credentials
- production credentials

公開やvisibility変更の前に実行します。

```sh
mise run release-check
```
