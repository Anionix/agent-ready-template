# ai-jail Profile / ai-jail profile

## English

This profile is a lightweight sandbox option for everyday agent work. `ai-jail` uses OS-level sandbox primitives such as `bwrap` on Linux and `sandbox-exec` on macOS.

Use it when:

- generated commands or unknown scripts need a safer wrapper
- the agent should avoid normal host home-directory state
- secrets such as `.env` should be masked from the agent process
- a VM would be too heavy for the task

Do not treat this as a hardware isolation boundary. It shares the host kernel. For hostile code, strong secret isolation, or high-risk autonomy, use a disposable VM or microVM profile.

Starter flow:

```sh
cp profiles/os-sandbox/ai-jail/.ai-jail.example .ai-jail
ai-jail --dry-run claude
ai-jail --private-home --mask .env --mask .env.local claude
```

For Codex or another agent, replace `claude` with the command you normally run.

## 日本語

このprofileは、日常的なagent作業向けの軽量sandbox optionです。`ai-jail` はLinuxでは `bwrap`、macOSでは `sandbox-exec` などのOS-level sandbox primitiveを使います。

使う場面:

- 生成commandや未知のscriptをより安全なwrapper内で実行したい
- agentから通常のhost home-directory状態を避けたい
- `.env` などのsecretをagent processからmaskしたい
- VMを使うほど重くしたくない

これはhardware isolation boundaryではありません。host kernelを共有します。hostile code、強いsecret isolation、高リスクの自律実行には、disposable VMまたはmicroVM profileを使ってください。

Starter flow:

```sh
cp profiles/os-sandbox/ai-jail/.ai-jail.example .ai-jail
ai-jail --dry-run claude
ai-jail --private-home --mask .env --mask .env.local claude
```

Codexなど別agentでは、`claude` を普段使うagent commandに置き換えます。
