# 05. Safety and Sandbox / 安全性とsandbox

## English

## Default mode

Agents may run on the host environment for normal local development tasks.

## Sandbox required

Use a selectable sandbox profile when:

- running an agent with broad permissions
- modifying infrastructure code
- executing unknown scripts
- performing dependency upgrades
- running generated shell commands
- using multiple agents in parallel
- secrets or credentials may be nearby

See `docs/threat-model.md` for the escalation criteria and `docs/sandbox-profiles.md` for the profile taxonomy.

## Secrets policy

Agents must not read:

- `.env`
- `.env.*`
- `secrets/**`
- SSH keys
- cloud credentials
- production credentials

## Worktree strategy

Use a separate git worktree per agent session when running agents in parallel.

```sh
git worktree add ../project-agent-fix bugfix/agent-fix
git worktree add ../project-agent-refactor refactor/agent-refactor
```

## 日本語

## 標準モード

通常のローカル開発タスクでは、agentはホスト環境で実行してよいです。

## sandbox必須条件

次の場合は選択式sandbox profileを使います。

- 広い権限を与える
- インフラコードを変更する
- 未知のscriptを実行する
- 依存関係を大きく更新する
- 生成されたshell commandを実行する
- 複数agentを並列実行する
- secretやcredentialが近くにある

昇格条件は `docs/threat-model.md`、profile分類は `docs/sandbox-profiles.md` を参照します。

## secret policy

agentは次を読んではいけません。

- `.env`
- `.env.*`
- `secrets/**`
- SSH keys
- cloud credentials
- production credentials

## worktree戦略

複数agentを並列実行する場合、agentごとにgit worktreeを分けます。
