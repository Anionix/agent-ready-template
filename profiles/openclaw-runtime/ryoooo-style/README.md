# ryoooo-style OpenClaw Runtime Profile Note

This is a future optional hardened profile note for always-on assistant isolation. It sketches the kind of OpenClaw-specific boundary a ryoooo-style setup may need, without copying personal machine configs or requiring OpenClaw, NixOS, gogcli, Unbound, nftables, auditd, or microVM tooling in default CI.

Checked on 2026-05-16 against the public `ryoooo/microvm-openclaw.nix` README: <https://github.com/ryoooo/microvm-openclaw.nix>.

## Fit

Use this profile direction when an assistant is long-running, can inspect local state, and can also communicate externally. That shape needs more than a normal repo contract because filesystem access, network egress, secrets, browser/OAuth state, and auditability all interact.

## Boundary sketch

- Keep the OpenClaw assistant runtime and Google Workspace / gogcli tooling in separate VMs when OAuth or browser-derived tokens are involved.
- Allow OpenClaw-to-gogcli calls only through a narrow command surface owned by the operator; do not allow the tool VM to become a general shell.
- Keep OAuth tokens and Google API state inside the gogcli side of the boundary instead of mounting them broadly into the assistant runtime.
- Mount only the task workspace into the assistant runtime by default. Keep OAuth, SSH, cloud, API, and browser-derived credentials in the tool VM or another scoped credential boundary unless a reviewed runbook explicitly requires otherwise.
- Route DNS and outbound traffic through explicit policy when private data is nearby. Treat Unbound DNS logs, nftables egress logs, and auditd as separate visibility/control layers.
- Position an OpenClaw defender pipeline as an additional review/filtering layer for prompt/tool content, not as proof of containment by itself.
- Review `docs/network-dns-audit-boundaries.md` and `profiles/openclaw-runtime/threat-boundary-checklist.md` before adoption.

## Future hardened profile posture

This template can learn the architecture vocabulary without shipping the runtime:

- `OpenClaw VM`: assistant gateway, chat/tool bridge, and defender integration.
- `gogcli VM`: Google Workspace CLI and OAuth-token handling.
- `DNS / egress / audit`: operator-observable boundaries that need exact host validation.
- `defender pipeline`: layered prompt/tool-content checks that should be versioned and tested before being described as enforcement.

Downstream adopters should validate the exact upstream release, Nix inputs, VM networking, secret mounts, OAuth token path, defender model versions, and audit rules before using stronger hardening language.

## Non-goals

- No OpenClaw runtime is required by CI.
- No NixOS host configuration, personal desktop configuration, private host path, OAuth token, or machine secret is copied into this template.
- This note is not a production containment claim for any specific machine or OpenClaw version.

## 日本語

これはalways-on assistant isolation向けの将来の任意profile noteです。個人machine configをコピーせず、OpenClaw、NixOS、gogcli、Unbound、nftables、auditd、microVM toolingをdefault CIに要求しません。

- assistantが長時間動作し、local stateを読み、外部communicationも可能な場合に検討します。
- filesystem access、network egress、secret、browser/OAuth state、auditabilityを一緒に扱います。
- OAuth-backed Google Workspace toolingが必要な場合は、OpenClaw runtimeとgogcli/OAuth toolingを別VMまたは同等のcompartmentに分ける設計を検討します。
- mountはtaskに必要なworkspaceだけに絞り、home directory全体やsecretを持ち込まないでください。
- defender pipelineは追加review/filtering layerとして扱い、containment証明としては扱いません。
- 採用前に `docs/network-dns-audit-boundaries.md` と `profiles/openclaw-runtime/threat-boundary-checklist.md` を確認します。
