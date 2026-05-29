# nixcage-style Nix microVM Profile Note / nixcage-style Nix microVM profile note

## English

This is an optional profile note for teams studying nixcage-style project-directory Nix microVM workflows. It does not vendor nixcage, copy host configuration, or make nixcage, NixOS, Cloud Hypervisor, QEMU, Apple HVF, or a Linux builder part of this template's default workflow.

Checked on 2026-05-16 against the public `hamidr/nixcage` README: <https://github.com/hamidr/nixcage>.

nixcage is useful to study because it makes the project directory the runtime boundary:

- a shell hook can detect project-local nixcage configuration and enter a NixOS VM for that directory;
- the project is driven by Nix flake-managed VM configuration, with project packages and resources described as NixOS module data;
- the workspace is mounted into the guest as `/workspace`, while the host `/nix/store` is shared read-only so built packages can be reused;
- Linux uses Cloud Hypervisor, while macOS uses QEMU with Apple HVF, so host support is not identical across platforms;
- macOS builds require a Linux builder for NixOS VM images because the guest remains Linux/NixOS;
- preinstalled coding-agent tools are a runtime convenience, not a repo-template requirement.

## Fit for this template

Use this note as design guidance when a downstream project wants Nix-managed VM entry around a project directory:

- keep the default repo contract independent of Nix, nixcage, hypervisors, and host builders;
- treat project-directory auto-entry as operator UX, not as a universal safety guarantee;
- document the Linux/macOS runtime split explicitly before promising portability;
- keep host path sharing narrow and review `docs/sandbox-footguns.md` before adding extra mounts;
- keep secrets and builder configuration out of repository templates unless a downstream project owns that policy.

This profile is documentation only. A project that adopts nixcage should review the current upstream release, host platform support, Linux builder setup, mount policy, secret injection behavior, and Nix flake/build cache requirements before running sensitive workloads.

## 日本語

これはnixcage-styleのproject-directory Nix microVM workflowを調査するteam向けの任意profile noteです。このtemplateにnixcageをvendorしたり、host設定をコピーしたり、nixcage、NixOS、Cloud Hypervisor、QEMU、Apple HVF、Linux builderをdefault workflowへ入れたりしません。

2026-05-16 に公開 `hamidr/nixcage` README を確認しました: <https://github.com/hamidr/nixcage>。

nixcageから学ぶ点は、project directoryをruntime境界として扱うところです。

- shell hookがproject-localなnixcage設定を検出し、そのdirectory向けのNixOS VMへ入る設計です。
- project packageやresourceは、Nix flake管理のVM設定とNixOS module dataとして記述されます。
- workspaceはguest内の `/workspace` としてmountされ、hostの `/nix/store` はread-only共有されるため、build済みpackageを再利用できます。
- LinuxではCloud Hypervisor、macOSではApple HVF付きQEMUを使うため、host supportは同一ではありません。
- guestはLinux/NixOSのままなので、macOSでNixOS VM imageをbuildするにはLinux builderが必要です。
- pre-installed coding-agent toolsはruntime convenienceであり、このrepo templateの要件ではありません。

## このtemplateでの位置づけ

downstream projectがproject directory単位でNix-managed VM entryを足したい時、このnoteを設計参考として使います。

- default repo contractはNix、nixcage、hypervisor、host builderから独立させる。
- project-directory auto-entryはoperator UXとして扱い、普遍的な安全保証として扱わない。
- portabilityを約束する前に、Linux/macOS runtime splitを明示する。
- host path sharingは狭く保ち、extra mountを足す前に `docs/sandbox-footguns.md` を確認する。
- downstream projectがpolicyを所有しない限り、secretやbuilder設定をrepository templateに入れない。

このprofileはdocumentation onlyです。nixcageを採用するprojectは、sensitive workloadを実行する前に、最新upstream release、host platform support、Linux builder setup、mount policy、secret injection、Nix flake/build cache要件を確認してください。
