# 09. Mixed Repository Lessons / 既存repoからmixした設計知見

## English

This template borrows ideas from several existing repository styles.

| Source type | Good idea | How this template uses it |
|---|---|---|
| Multi-agent Dev Container repos | Support multiple agents | Use adapter files, but keep Dev Container optional |
| Claude setup repos | Claude commands and learnings | Put Claude extras in optional layer |
| Readiness scoring repos | Measurable agent readiness | Provide `mise run agent-ready` |
| Fullstack starters | `mise` as task runner | Treat `mise.toml` as agent API |
| Real product repos | `AGENTS.md`, `CLAUDE.md`, `compose.yaml`, `mise.toml` can coexist | Use this as the practical core |

## Not borrowed

- Mandatory Dev Container
- Mandatory Nix/Devbox/Flox
- Framework-specific app scaffold
- Personal dotfiles assumptions
- Real secrets

## 日本語

このテンプレートは、複数の既存repoスタイルから良い点を取り込んでいます。

| 参考タイプ | 良い点 | このテンプレートでの使い方 |
|---|---|---|
| Multi-agent Dev Container repo | 複数agent対応 | adapter filesで対応し、Dev Containerはoptional |
| Claude setup repo | Claude commands / learnings | Claude拡張はoptional層へ |
| Readiness scoring repo | agent readinessの可視化 | `mise run agent-ready` を提供 |
| Fullstack starter | `mise`をtask runnerにする | `mise.toml` をagent APIとして扱う |
| 実プロダクトrepo | `AGENTS.md`, `CLAUDE.md`, `compose.yaml`, `mise.toml` は共存可能 | 実用coreとして採用 |

## 取り込まない点

- Dev Container必須化
- Nix/Devbox/Flox必須化
- 特定framework app scaffold
- 個人dotfiles前提
- 本物のsecret
