# Sandbox Profiles / Sandbox profiles

## English

Sandbox profiles are selectable add-ons. They let a project keep the default loop small while offering stronger boundaries when the threat model requires them.

Read `docs/sandbox-footguns.md` before adopting or extending a profile. Most sandbox failures come from reintroducing host state through mounts, secrets, Docker socket access, broad egress, or shared worktrees.

MVP profiles:

```text
profiles/
  os-sandbox/
    ai-jail/
  microvm-dev/
    michael-style/
```

Documented optional profile notes:

```text
profiles/
  microvm-dev/
    brood-box-style/
    nixcage-style/
    nixbox-style/
  docker-sandbox/
    docker-sandboxes/
  openclaw-runtime/
    ryoooo-style/
    policy/
    threat-boundary-checklist.md
  cloud-sandbox/
    firecracker/
      e2b/
      vercel/
    dedicated-computer/
      daytona/
    container-based/
      cloudflare/
  embedded-runtime/
    boxlite/
    microsandbox/
```

Future profile taxonomy:

```text
profiles/
  native-sandbox/
    claude/
    codex/

  os-sandbox/
    ai-jail/
    jail-nix/

  microvm-dev/
    michael-style/
    brood-box-style/
    nixcage-style/
    nixbox-style/

  cloud-sandbox/
    firecracker/
      fly-sprites/
```

## Adoption phases

| Phase | Add | Do not add yet |
|---|---|---|
| 1 | Agent-ready repo contract, `ai-jail` profile, Michael-style `microvm.nix` profile | Cloud adapters, OpenClaw runtime, embedded runtime SDKs |
| 2 | Brood Box-style runtime UX note, nixcage-style Nix microVM note, Nixbox comparison, Docker Sandboxes profile notes, sandbox footguns docs, adoption checklist | Brood Box, libkrun, KVM, Hypervisor.framework, nixcage, NixOS, Cloud Hypervisor, QEMU, Linux builders, Nixbox, Docker Sandboxes, or agent images as required dependencies |
| 3 | OpenClaw runtime profile, policy notes, nftables / Unbound / auditd references, threat-boundary checklist | Mandatory adoption of OpenShell or NemoClaw |
| 4 | Cloud sandbox adapter docs for E2B, Vercel, Daytona, Cloudflare, and Fly Sprites taxonomy | Cloud providers as default checks |
| 5 | OpenShell / NemoClaw-style policy layer notes, BoxLite / Microsandbox embedded runtime notes | Runtime SDKs as template dependencies or strong security claims without current verification |

## Classification notes

- Cloudflare belongs under `cloud-sandbox/container-based/cloudflare`. Use container-based profile wording.
- Docker Sandboxes belongs under `docker-sandbox/docker-sandboxes`. Treat it as future optional because availability and product shape may change.
- Brood Box belongs under `microvm-dev/brood-box-style`. Treat it as an external runtime UX reference for snapshot/review/egress/MCP patterns, not a vendored microVM distribution.
- nixcage belongs under `microvm-dev/nixcage-style`. Treat it as an external project-directory Nix microVM workflow reference, not a required NixOS or host-builder setup.
- Nixbox belongs under `microvm-dev/nixbox-style`. Treat it as an external comparison target and optional profile note, not a vendored runtime.
- OpenShell and NemoClaw are policy and runtime references for future OpenClaw work. They stay outside the MVP.
- E2B and Vercel belong under `cloud-sandbox/firecracker/`; Daytona belongs under `cloud-sandbox/dedicated-computer/`; Cloudflare belongs under `cloud-sandbox/container-based/`.
- Fly Sprites is taxonomy-only until a downstream project decides to evaluate it directly.
- BoxLite and Microsandbox are future embedded runtime references. Describe them cautiously as promising runtime directions, not as proven default isolation for this template.
- Native Claude and Codex sandboxes are useful agent-specific guardrails, but they are not cross-agent repo profiles.
- Sandbox footguns should be documented before adding stronger runtime adapters, so later profiles reuse the same safety vocabulary.

## 日本語

Sandbox profileは選択式の追加層です。標準loopを小さく保ちながら、threat modelが必要とする時だけ強い境界を使えるようにします。

profileを採用または拡張する前に `docs/sandbox-footguns.md` を読みます。多くのsandbox failureは、mount、secret、Docker socket access、広いegress、共有worktreeを通じてhost stateを再導入することで起きます。

MVP profile:

```text
profiles/
  os-sandbox/
    ai-jail/
  microvm-dev/
    michael-style/
```

Documented optional profile notes:

```text
profiles/
  microvm-dev/
    brood-box-style/
    nixcage-style/
    nixbox-style/
  docker-sandbox/
    docker-sandboxes/
  openclaw-runtime/
    ryoooo-style/
    policy/
    threat-boundary-checklist.md
  cloud-sandbox/
    firecracker/
      e2b/
      vercel/
    dedicated-computer/
      daytona/
    container-based/
      cloudflare/
  embedded-runtime/
    boxlite/
    microsandbox/
```

将来のprofile分類:

```text
profiles/
  native-sandbox/
    claude/
    codex/

  os-sandbox/
    ai-jail/
    jail-nix/

  microvm-dev/
    michael-style/
    brood-box-style/
    nixcage-style/
    nixbox-style/

  cloud-sandbox/
    firecracker/
      fly-sprites/
```

## Adoption phases / 採用段階

| Phase | 追加するもの | まだ追加しないもの |
|---|---|---|
| 1 | Agent-ready repo contract、`ai-jail` profile、Michael-style `microvm.nix` profile | Cloud adapter、OpenClaw runtime、embedded runtime SDK |
| 2 | Brood Box-style runtime UX note、nixcage-style Nix microVM note、Nixbox比較、Docker Sandboxes profile notes、sandbox footguns docs、adoption checklist | Brood Box、libkrun、KVM、Hypervisor.framework、nixcage、NixOS、Cloud Hypervisor、QEMU、Linux builders、Nixbox、Docker Sandboxes、agent imageの必須依存化 |
| 3 | OpenClaw runtime profile、policy notes、nftables / Unbound / auditd references、threat-boundary checklist | OpenShellやNemoClawの必須採用 |
| 4 | E2B、Vercel、Daytona、Cloudflare向けcloud sandbox adapter docs、Fly Sprites taxonomy | cloud providerをdefault checkにすること |
| 5 | OpenShell / NemoClaw風policy layer notes、BoxLite / Microsandbox embedded runtime notes | runtime SDKのtemplate依存化、または現時点確認なしの強いsecurity claim |

## Classification notes / 分類メモ

- Cloudflareは `cloud-sandbox/container-based/cloudflare` に置きます。container-based profileとして説明します。
- Docker Sandboxesは `docker-sandbox/docker-sandboxes` に置きます。availabilityやproduct shapeが変わる可能性があるため、将来optionalとして扱います。
- Brood Boxは `microvm-dev/brood-box-style` に置きます。vendored microVM distributionではなく、snapshot/review/egress/MCP pattern向けの外部runtime UX referenceとして扱います。
- nixcageは `microvm-dev/nixcage-style` に置きます。必須のNixOSまたはhost-builder setupではなく、project-directory Nix microVM workflow向けの外部referenceとして扱います。
- Nixboxは `microvm-dev/nixbox-style` に置きます。vendored runtimeではなく、外部comparison targetかつ任意profile noteとして扱います。
- OpenShellとNemoClawは将来のOpenClaw work向けpolicy/runtime referenceです。MVPの外に置きます。
- E2BとVercelは `cloud-sandbox/firecracker/`、Daytonaは `cloud-sandbox/dedicated-computer/`、Cloudflareは `cloud-sandbox/container-based/` に置きます。
- Fly Spritesは、downstream projectが直接評価すると決めるまでtaxonomy-onlyにします。
- BoxLiteとMicrosandboxは将来のembedded runtime referenceです。default isolationとして断定せず、慎重に説明します。
- Claude / Codex native sandboxはagent固有のguardrailとして有用ですが、agent横断repo profileではありません。
- 強いruntime adapterを足す前にsandbox footgunを文書化し、後続profileが同じ安全語彙を使えるようにします。
