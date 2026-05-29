# Sandbox Footguns / Sandbox footguns

## English

Sandbox profiles reduce risk only when their boundary stays narrow. A profile is not a license to bring the host home directory, real credentials, browser sessions, or the host Docker daemon into the agent environment.

Use this guide before running a high-risk agent task, especially when the work matches the lethal-trifecta pattern in `docs/threat-model.md`. Then use `docs/sandbox-adoption-checklist.md` to map the risk to a candidate profile family.

## Boundary quick reference

| Boundary | Useful for | Main footgun |
|---|---|---|
| Native-agent sandbox | Agent-specific filesystem or network guardrails | Treating one agent's guardrail as a cross-agent repo policy |
| Process sandbox | Daily risky work with limited file access | Forgetting it shares the host kernel |
| Container | Reproducible tools and service dependencies | Mounting the Docker socket or broad host paths |
| MicroVM | Higher-risk local agent work with a separate guest kernel | Reintroducing host secrets through mounts, agents, or network |
| Cloud sandbox | Provider-managed remote execution | Assuming all providers have the same isolation boundary |

## Avoid / prefer rules

| Area | Avoid | Prefer |
|---|---|---|
| Secrets | Real `.env` files, SSH keys, cloud credentials, production tokens, broad `GITHUB_TOKEN` scopes | `.env.example`, test credentials, short-lived scoped tokens, and no inherited shell secrets |
| Mounts | `~`, browser profiles, `~/.ssh`, cloud config directories, package manager auth files, or the whole repository parent | A single task workspace, read-only docs when possible, and explicit writable paths |
| Docker socket | Mounting `/var/run/docker.sock` or a host Docker context into untrusted agent work | A separate daemon inside a VM/sandbox, a disposable builder, or no Docker access |
| Network | Broad outbound internet near private data or untrusted content | Disabled egress, allowlisted domains, or an audited proxy |
| Worktrees | Multiple agents writing the same branch, worktree, cache, or generated files | One branch/worktree per agent and PR-based integration |
| Unknown scripts | <code>curl &#124; sh</code>, unreviewed generated shell, dependency lifecycle hooks near secrets | Review first, pin inputs, run in a disposable profile, then promote only the needed diff |
| Browser state | Mounting a real browser profile, keychain-backed sessions, or OAuth state | Throwaway browser profiles, test accounts, or no browser profile mount |

## Docker socket rule

Treat a mounted Docker socket as host-level control. A container with access to the host Docker socket can usually start privileged containers, mount host paths, and bypass the container boundary. For this template, Docker socket mounting is a high-risk footgun and should be avoided by default.

If Docker access is necessary, move the task into a stronger disposable boundary first, then give the agent access only to the Docker daemon that belongs to that boundary.

## Agent coordination rule

Parallel agents need separate workspaces. A sandbox boundary does not prevent two agents from overwriting each other's files, sharing a poisoned cache, or merging incompatible changes. Use one branch or worktree per agent and treat the PR as the integration point.

## Pre-flight checklist

- The agent cannot read real secrets, browser profiles, SSH keys, or cloud credentials.
- The mounted workspace is the smallest path that can complete the task.
- The Docker socket is not mounted by default.
- Network egress is disabled, allowlisted, or audited for lethal-trifecta tasks.
- Unknown scripts and dependency upgrades run in a disposable profile before promotion.
- Parallel agents have separate branches or worktrees.
- The selected profile's boundary is described without stronger claims than the implementation supports.

## Related notes

- `docs/sandbox-adoption-checklist.md`
- `docs/network-dns-audit-boundaries.md`
- `docs/cloud-sandbox-adapters.md`

## 日本語

Sandbox profileは、境界を狭く保つ時だけriskを下げます。profileを使っていても、hostのhome directory、本物のcredential、browser session、host Docker daemonをagent環境へ持ち込むと効果が崩れます。

高リスクなagent作業、特に `docs/threat-model.md` のlethal-trifecta patternに当たる作業の前に、このguideを確認します。その後、`docs/sandbox-adoption-checklist.md` でriskを候補profile familyへ対応づけます。

## Boundary quick reference / 境界早見表

| 境界 | 向いている用途 | 主なfootgun |
|---|---|---|
| Native-agent sandbox | agent固有のfilesystem/network guardrail | 1つのagentのguardrailをagent横断repo policyだと扱う |
| Process sandbox | file accessを絞った日常的な危険作業 | host kernelを共有していることを忘れる |
| Container | 再現可能なtoolやservice dependency | Docker socketや広いhost pathをmountする |
| MicroVM | guest kernelを分けたい高リスクlocal agent作業 | mount、agent、network経由でhost secretを再導入する |
| Cloud sandbox | provider管理のremote execution | providerごとの隔離境界を同一視する |

## Avoid / prefer rules / 避けること、選ぶこと

| 領域 | 避ける | 選ぶ |
|---|---|---|
| Secrets | 本物の `.env`、SSH鍵、cloud credential、本番token、広い `GITHUB_TOKEN` scope | `.env.example`、test credential、短命でscopeを絞ったtoken、shell secretの非継承 |
| Mounts | `~`、browser profile、`~/.ssh`、cloud config directory、package manager auth file、repository親directory全体 | task用workspaceだけ、可能ならread-only docs、明示的なwritable path |
| Docker socket | `/var/run/docker.sock` やhost Docker contextをuntrusted agent作業へmountする | VM/sandbox内の別daemon、使い捨てbuilder、またはDocker accessなし |
| Network | private dataやuntrusted contentの近くで広いoutbound internetを許す | egress無効化、domain allowlist、audited proxy |
| Worktrees | 複数agentが同じbranch、worktree、cache、generated fileへ書く | agentごとにbranch/worktreeを分け、PRで統合する |
| Unknown scripts | secretの近くで <code>curl &#124; sh</code>、未reviewの生成shell、dependency lifecycle hookを実行する | 先にreviewし、inputをpinし、disposable profileで実行してから必要なdiffだけ昇格する |
| Browser state | 本物のbrowser profile、keychain-backed session、OAuth状態をmountする | 使い捨てbrowser profile、test account、またはbrowser profile mountなし |

## Docker socket rule / Docker socketの扱い

MountされたDocker socketはhost-level controlとして扱います。host Docker socketへaccessできるcontainerは、多くの場合privileged containerを起動し、host pathをmountし、container境界を迂回できます。このtemplateでは、Docker socket mountは高リスクfootgunであり、defaultでは避けます。

Docker accessが必要な場合は、先により強い使い捨て境界へtaskを移し、その境界に属するDocker daemonだけをagentへ渡します。

## Agent coordination rule / agent調整rule

並列agentには別々のworkspaceが必要です。sandbox境界は、2つのagentが互いのfileを上書きしたり、汚染されたcacheを共有したり、互換性のない変更をmergeしたりすることを防ぎません。agentごとにbranchまたはworktreeを分け、PRを統合点にします。

## Pre-flight checklist / 事前checklist

- agentが本物のsecret、browser profile、SSH鍵、cloud credentialを読めない。
- mountされるworkspaceはtask完了に必要な最小pathである。
- Docker socketはdefaultでmountしない。
- lethal-trifecta作業ではnetwork egressを無効化、allowlist化、またはauditする。
- 未知のscriptやdependency upgradeは、昇格前にdisposable profileで実行する。
- 並列agentは別々のbranchまたはworktreeを持つ。
- 選択したprofileの境界を、実装が支えられる範囲より強く表現しない。

## Related notes / 関連note

- `docs/sandbox-adoption-checklist.md`
- `docs/network-dns-audit-boundaries.md`
- `docs/cloud-sandbox-adapters.md`
