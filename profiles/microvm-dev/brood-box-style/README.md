# Brood Box-style Runtime UX Profile Note / Brood Box-style runtime UX profile note

## English

This is an optional profile note for teams studying Brood Box-style runtime UX. It does not vendor Brood Box, copy its configuration, or make Brood Box, libkrun, KVM, Hypervisor.framework, or any agent image part of this template's default workflow.

Checked on 2026-05-16 against the public `stacklok/brood-box` README: <https://github.com/stacklok/brood-box>.

Upstream currently describes Brood Box as experimental, so downstream adoption should pin and re-check the current release behavior before relying on it for sensitive workloads.

Brood Box is useful to study because it treats coding-agent execution as an operator workflow:

- `snapshot` is the default workspace posture: the agent works against a copy-on-write snapshot, then accepted changes are flushed back after review.
- `--review` enables an interactive per-file diff review in snapshot mode.
- rollback posture comes from keeping real workspace writes behind the snapshot/review boundary until the operator accepts files.
- `--workspace-mode=direct` is a trusted-edit mode where the VM writes directly to the workspace; it rejects snapshot-only review and exclude controls, requires explicit operator consent on first use, and does not provide the same review-before-flush rollback posture.
- egress profiles such as `permissive`, `standard`, and `locked` separate broad access from tighter policies such as standard developer infrastructure or LLM-provider-only access.
- `--allow-host` adds explicit DNS hostnames to the selected egress posture.
- MCP access is proxied through ToolHive by default, with `--mcp-group` for selecting a ToolHive group and `--no-mcp` available when MCP tools should not be exposed.

## Fit for this template

Use this note as design guidance when a downstream project wants stronger runtime UX around agent changes:

- keep the repo contract portable and keep `mise run check` independent of the runtime;
- prefer snapshot/review language over claims that the template itself provides isolation;
- document direct-write modes as an explicit trust tradeoff, not as the default;
- treat egress policy as an operator-facing profile choice;
- put MCP proxying behind a named runtime profile instead of silently exposing tools.

This profile is documentation only. A project that adopts Brood Box should review the current upstream docs, host support, release status, egress requirements, secret forwarding behavior, and workspace mount policy before running untrusted workloads.

## 日本語

これはBrood Box-style runtime UXを調査するteam向けの任意profile noteです。このtemplateにBrood Boxをvendorしたり、設定をコピーしたり、Brood Box、libkrun、KVM、Hypervisor.framework、agent imageをdefault workflowへ入れたりしません。

2026-05-16 に公開 `stacklok/brood-box` README を確認しました: <https://github.com/stacklok/brood-box>。

upstreamは現時点でBrood Boxをexperimentalと説明しているため、sensitive workloadに使う前にcurrent release behaviorをpinして再確認してください。

Brood Boxから学ぶ点は、coding-agent実行をoperator workflowとして扱うところです。

- `snapshot` はdefault workspace postureです。agentはcopy-on-write snapshot上で作業し、review後にacceptされた変更だけが戻されます。
- `--review` はsnapshot modeでinteractiveなper-file diff reviewを有効にします。
- rollback postureは、operatorがfileをacceptするまで実workspaceへのwriteをsnapshot/review境界の後ろに置くことで作られます。
- `--workspace-mode=direct` はtrusted edit向けmodeです。VMがworkspaceへ直接writeし、snapshot専用のreview/exclude controlは使えず、初回はoperatorの明示同意が必要で、同じreview-before-flush rollback postureは提供しません。
- `permissive`、`standard`、`locked` のようなegress profileは、広いnetwork access、標準的なdeveloper infrastructure、LLM providerのみのようなpolicyを分けます。
- `--allow-host` は選択中のegress postureに明示DNS hostnameを追加します。
- MCP accessはdefaultでToolHive経由でproxyされ、ToolHive group選択には `--mcp-group`、MCP toolを出したくない場合は `--no-mcp` を使えます。

## このtemplateでの位置づけ

downstream projectがagent変更に強いruntime UXを足したい時、このnoteを設計参考として使います。

- repo contractはportableに保ち、`mise run check` はruntime非依存にする。
- template自体が隔離を提供すると主張せず、snapshot/reviewの語彙として説明する。
- direct-write modeはdefaultではなく、明示的なtrust tradeoffとして文書化する。
- egress policyはoperator-facingなprofile choiceとして扱う。
- MCP proxyはtoolを暗黙公開せず、名前付きruntime profileの後ろに置く。

このprofileはdocumentation onlyです。Brood Boxを採用するprojectは、untrusted workloadを実行する前に、最新upstream docs、host support、release status、egress要件、secret forwarding、workspace mount policyを確認してください。
