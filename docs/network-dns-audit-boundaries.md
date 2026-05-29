# Network, DNS, and Audit Boundaries

This note explains three boundary concepts used by stronger microVM and OpenClaw-style profiles. It is documentation only; the template does not ship host firewall, DNS resolver, or audit daemon configuration.

## Roles

| Tooling area | Main role | What it is not |
|---|---|---|
| `nftables` | Packet filtering and egress control on Linux hosts. | A complete data-loss-prevention system by itself. |
| Unbound | Local recursive or forwarding DNS control, often used with allowlists or controlled resolver paths. | A substitute for network egress policy. |
| `auditd` | Kernel audit logging for selected file, process, and network-related events. | Enforcement unless paired with separate policy controls. |

## Logging, filtering, and enforcement

- Logging records what happened so an operator can review it later.
- Filtering narrows allowed traffic or name resolution paths.
- Enforcement blocks or denies behavior at a boundary such as a firewall, sandbox runtime, or policy engine.

Do not blur these terms. A log entry is useful evidence, but it does not stop an exfiltration path. A DNS rule can reduce surprise destinations, but direct IP egress still needs network policy. A firewall can block traffic, but it does not explain whether mounted secrets were already exposed inside the workload.

## Adoption guidance

- Start from `docs/sandbox-footguns.md` and `docs/sandbox-adoption-checklist.md`.
- Keep default template users on the normal `mise` and Docker Compose loop.
- Use these concepts only for stronger optional profiles such as microVM or OpenClaw runtime work.
- Validate the exact Linux distribution, host network stack, resolver path, and audit rules before describing a setup as hardened.

## OpenClaw-specific composition

Checked on 2026-05-16 against the public `ryoooo/microvm-openclaw.nix` README: <https://github.com/ryoooo/microvm-openclaw.nix>.

For a future OpenClaw hardened profile, keep the boundary vocabulary explicit:

- OpenClaw VM and gogcli VM separation is an architecture pattern for keeping assistant runtime work apart from Google Workspace/OAuth tooling.
- OAuth token isolation should be described as a tool-VM boundary and command-surface decision, not as a generic property of this template.
- Unbound DNS logging, nftables egress logging/filtering, and auditd monitoring serve different roles; do not merge them into a single "network security" claim.
- A defender pipeline can be documented as layered prompt/tool-content review, but it does not replace mount minimization, egress policy, audit logs, or human review.

Any downstream project using this profile should pin and test its runtime versions before claiming hardened behavior.

## 日本語

このnoteは、強いmicroVM/OpenClaw-style profileで使うnetwork、DNS、audit境界の考え方を説明します。template本体はhost firewall、DNS resolver、audit daemon設定を配布しません。

- `nftables` はLinux host上のpacket filteringやegress controlの候補です。単体でdata-loss-prevention全体にはなりません。
- UnboundはDNS controlやallowlist設計の候補です。direct IP egressには別のnetwork policyが必要です。
- `auditd` はfile、process、network関連eventの記録に使えます。enforcementには別のpolicy controlが必要です。
- logは証拠、filterは経路の制限、enforcementは境界での拒否です。この3つを混同しないでください。
- default userは通常の `mise` と Docker Compose loopに留め、これらは任意の強化profileでだけ検討します。
