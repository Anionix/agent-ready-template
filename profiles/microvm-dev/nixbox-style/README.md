# nixbox-style microVM Profile Note / nixbox-style microVM profile note

## English

This is an optional comparison note for projects evaluating nixbox-style microVM isolation. It does not vendor nixbox, copy its configuration, or make NixOS, KVM, Cloud Hypervisor, or nixbox part of this template's default workflow.

nixbox is an external microVM sandbox for AI agents. Its public documentation describes a Cloud Hypervisor microVM, a KVM host boundary, virtiofs bind mounts for shared directories, and network modes such as `off`, `filtered`, and `open`.

Use this note when:

- the Michael-style `microvm.nix` starter is too hand-rolled for the team
- the team wants to compare an external CLI-driven microVM workflow
- workspace mounting, agent plugins, and filtered egress need a more opinionated reference
- the operator already has a Linux/KVM/Nix host where nixbox can be evaluated outside CI

Do not use this note as a hardening claim. Treat nixbox as a comparison target and optional profile direction, then validate the actual version and host setup before using it for sensitive or hostile workloads.

## Comparison with Michael-style

| Topic | Michael-style profile | nixbox-style note |
|---|---|---|
| Ownership | Repo-owned starter pattern | External comparison target |
| Shape | Hand-edited `microvm.nix` module | CLI/project workflow around `.nixbox/config.nix` |
| Boundary | NixOS microVM pattern on a KVM-capable host | Documented Cloud Hypervisor microVM with KVM boundary |
| Mounts | Explicit workspace mount chosen by the operator | virtiofs bind mounts, often workspace-oriented |
| Network | Local policy must be designed by the operator | Documented `off`, `filtered`, and `open` egress modes |
| CI impact | Documentation-grade example only | Documentation-grade comparison only |

## Safety posture

- Keep it optional; default CI must not require NixOS, KVM, Cloud Hypervisor, or nixbox.
- Mount the smallest useful workspace for the task. Avoid broad home-directory mounts.
- Pass secrets explicitly and narrowly. Do not rely on host home, browser profile, or cloud config mounts.
- Prefer `off` or `filtered` egress for lethal-trifecta work.
- Read `docs/sandbox-footguns.md` before adopting a nixbox-style setup.
- Avoid absolute escape-prevention or hardening claims unless verified for the exact deployed configuration.

## Evaluation checklist

- The host is Linux with KVM available.
- Nix and required host networking/firewall tools are installed outside this repository.
- The workspace mount does not expose unrelated private files.
- Network mode is chosen deliberately for the task.
- Credentials are short-lived, scoped, and passed intentionally.
- Agent plugins or convenience mounts do not reintroduce browser sessions, cloud credentials, or the Docker socket.

## 日本語

これは、nixbox-style microVM isolationを評価するproject向けの任意比較noteです。このtemplateにnixboxをvendorしたり、設定をコピーしたり、NixOS、KVM、Cloud Hypervisor、nixboxをdefault workflowへ入れたりしません。

nixboxはAI agent向けの外部microVM sandboxです。公開documentationでは、Cloud Hypervisor microVM、KVM host boundary、共有directory向けvirtiofs bind mount、`off`、`filtered`、`open` などのnetwork modeが説明されています。

使う場面:

- Michael-style `microvm.nix` starterがteamにとって手作り寄りすぎる
- 外部CLI駆動のmicroVM workflowと比較したい
- workspace mount、agent plugin、filtered egressについて、よりopinionatedなreferenceが必要
- operatorがLinux/KVM/Nix hostを持ち、CI外でnixboxを評価できる

このnoteをhardening claimとして使わないでください。nixboxは比較対象かつ任意profile directionとして扱い、sensitiveまたはhostileなworkloadに使う前に、実際のversionとhost setupを検証します。

## Comparison with Michael-style / Michael-styleとの比較

| 項目 | Michael-style profile | nixbox-style note |
|---|---|---|
| Ownership | repo-owned starter pattern | 外部comparison target |
| Shape | 手で編集する `microvm.nix` module | `.nixbox/config.nix` を中心にしたCLI/project workflow |
| Boundary | KVM-capable host上のNixOS microVM pattern | documented Cloud Hypervisor microVM with KVM boundary |
| Mounts | operatorが明示的に選ぶworkspace mount | virtiofs bind mount、workspace-orientedな使い方 |
| Network | operatorがlocal policyを設計する | `off`、`filtered`、`open` egress modeがdocumentationにある |
| CI impact | documentation-grade exampleのみ | documentation-grade comparisonのみ |

## Safety posture / safety姿勢

- 任意扱いのままにします。default CIでNixOS、KVM、Cloud Hypervisor、nixboxを要求しません。
- taskに必要な最小workspaceだけをmountします。広いhome-directory mountは避けます。
- secretは明示的かつ狭く渡します。host home、browser profile、cloud config mountへ依存しません。
- lethal-trifecta作業では `off` または `filtered` egressを優先します。
- nixbox-style setupを採用する前に `docs/sandbox-footguns.md` を読みます。
- 実際のdeploy構成で検証していない限り、絶対的なescape防止やhardening claimは避けます。

## Evaluation checklist / 評価checklist

- hostはLinuxでKVMが利用できる。
- Nixと必要なhost networking/firewall toolは、このrepositoryの外でinstallされている。
- workspace mountが無関係なprivate fileを露出しない。
- network modeをtaskに合わせて意図的に選んでいる。
- credentialは短命、scope限定、明示的に渡されている。
- agent pluginやconvenience mountがbrowser session、cloud credential、Docker socketを再導入しない。
