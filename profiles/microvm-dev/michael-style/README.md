# Michael-style microVM Dev Profile / Michael-style microVM dev profile

## English

This profile is a starter pattern for running coding agents inside a small NixOS microVM. It is inspired by the Michael Stapelberg `microvm.nix` development VM pattern.

Use it when:

- the task combines private data, untrusted content, and external communication
- a process sandbox is not enough
- agent work should happen in a separate kernel and filesystem boundary
- the operator is already comfortable with NixOS, flakes, and KVM-capable hosts

This repository does not require Nix, KVM, or `microvm.nix` in CI. The example file is documentation-grade scaffolding for teams that want to build a stronger local profile.

Starter flow:

```sh
cp profiles/microvm-dev/michael-style/microvm.nix.example microvm.nix
$EDITOR microvm.nix
```

Then integrate the module into the host's NixOS flake according to the local machine's existing NixOS layout.

## Security posture

- stronger than process sandboxing because the agent runs in a separate VM kernel
- still requires careful mount, secret, and network policy
- should mount only the intended workspace
- should pass credentials explicitly, not by mounting the host home directory
- should default outbound network to filtered or disabled for lethal-trifecta tasks

## 日本語

このprofileは、小さなNixOS microVM内でcoding agentを動かすためのstarter patternです。Michael Stapelberg氏の `microvm.nix` 開発VM patternを参考にしています。

使う場面:

- private data、untrusted content、external communicationが同時に出る
- process sandboxでは足りない
- agent作業を別kernelとfilesystem boundary内で行いたい
- operatorがNixOS、flakes、KVM対応hostに慣れている

このrepositoryのCIでは、Nix、KVM、`microvm.nix` を要求しません。example fileは、より強いlocal profileを作るteam向けのdocumentation-grade scaffoldingです。

Starter flow:

```sh
cp profiles/microvm-dev/michael-style/microvm.nix.example microvm.nix
$EDITOR microvm.nix
```

その後、local machineの既存NixOS layoutに合わせてhost側flakeへ統合します。

## Security posture / security姿勢

- agentが別VM kernelで動くため、process sandboxより強い
- mount、secret、network policyは慎重に設定する
- 意図したworkspaceだけをmountする
- host home directoryをmountせず、credentialは明示的に渡す
- lethal-trifecta作業ではoutbound networkをfilteredまたはdisabledに寄せる
