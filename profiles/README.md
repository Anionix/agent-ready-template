# Sandbox Profiles / Sandbox profiles

## English

Profiles are optional add-ons for risky agent work. The default repository loop remains:

```sh
mise run doctor
mise run install
mise run check
mise run agent-ready
```

Use a profile only when the threat model calls for more isolation than the host development environment provides.

MVP profiles:

- `profiles/os-sandbox/ai-jail`: lightweight OS/process sandbox wrapper for daily agent work.
- `profiles/microvm-dev/michael-style`: NixOS `microvm.nix` starter pattern for stronger VM isolation.

Documented optional profile notes:

- `profiles/microvm-dev/brood-box-style`: external Brood Box-style runtime UX note for teams evaluating snapshot, review, rollback, egress, and MCP proxy patterns.
- `profiles/microvm-dev/nixcage-style`: external nixcage-style Nix microVM note for teams evaluating project-directory VM entry and Linux/macOS host tradeoffs.
- `profiles/microvm-dev/nixbox-style`: external nixbox comparison note for teams evaluating CLI-driven microVM agent sandboxes.
- `profiles/docker-sandbox/docker-sandboxes`: Docker-native sandbox direction for teams evaluating agent sandboxes without changing default CI.
- `profiles/openclaw-runtime/ryoooo-style`: always-on assistant isolation profile direction.
- `profiles/openclaw-runtime/policy`: OpenShell / NemoClaw policy reference notes.
- `profiles/cloud-sandbox/firecracker/e2b`: E2B cloud sandbox adapter note.
- `profiles/cloud-sandbox/firecracker/vercel`: Vercel Sandbox adapter note.
- `profiles/cloud-sandbox/dedicated-computer/daytona`: Daytona dedicated-computer adapter note.
- `profiles/cloud-sandbox/container-based/cloudflare`: Cloudflare container-based sandbox adapter note.
- `profiles/embedded-runtime/boxlite`: BoxLite embedded runtime reference.
- `profiles/embedded-runtime/microsandbox`: Microsandbox embedded runtime reference.

These examples are starter artifacts. Review and adapt them before using them for sensitive or hostile workloads.

## 日本語

Profileは危険なagent作業向けの任意追加層です。repositoryの標準loopは次のままです。

```sh
mise run doctor
mise run install
mise run check
mise run agent-ready
```

host development environmentより強い隔離がthreat model上必要な時だけprofileを使います。

MVP profile:

- `profiles/os-sandbox/ai-jail`: 日常的なagent作業向けの軽量OS/process sandbox wrapper。
- `profiles/microvm-dev/michael-style`: より強いVM隔離に向けたNixOS `microvm.nix` starter pattern。

Documented optional profile notes:

- `profiles/microvm-dev/brood-box-style`: snapshot、review、rollback、egress、MCP proxy patternを評価するteam向けの外部Brood Box-style runtime UX note。
- `profiles/microvm-dev/nixcage-style`: project-directory VM entryとLinux/macOS host tradeoffを評価するteam向けの外部nixcage-style Nix microVM note。
- `profiles/microvm-dev/nixbox-style`: CLI-driven microVM agent sandboxを評価するteam向けの外部nixbox比較note。
- `profiles/docker-sandbox/docker-sandboxes`: default CIを変えずにagent sandboxを評価するteam向けのDocker-native sandbox direction。
- `profiles/openclaw-runtime/ryoooo-style`: always-on assistant isolation向けprofile direction。
- `profiles/openclaw-runtime/policy`: OpenShell / NemoClaw policy reference notes。
- `profiles/cloud-sandbox/firecracker/e2b`: E2B cloud sandbox adapter note。
- `profiles/cloud-sandbox/firecracker/vercel`: Vercel Sandbox adapter note。
- `profiles/cloud-sandbox/dedicated-computer/daytona`: Daytona dedicated-computer adapter note。
- `profiles/cloud-sandbox/container-based/cloudflare`: Cloudflare container-based sandbox adapter note。
- `profiles/embedded-runtime/boxlite`: BoxLite embedded runtime reference。
- `profiles/embedded-runtime/microsandbox`: Microsandbox embedded runtime reference。

これらはstarter artifactです。sensitiveまたはhostileなworkloadに使う前に、必ずreviewして調整してください。
