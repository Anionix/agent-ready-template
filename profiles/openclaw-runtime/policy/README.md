# OpenShell / NemoClaw Policy Reference Notes

OpenShell and NemoClaw are future policy and runtime references for OpenClaw-style assistants. They stay outside the MVP and are not required dependencies for this repository.

## Policy ideas to evaluate

- Declarative file access boundaries for mounted workspaces and private paths.
- Network policy that distinguishes default-deny, allowlist, and audit-only modes.
- Exfiltration controls around prompts, tool output, model calls, and outbound APIs.
- Audit records that let operators review what an always-on assistant touched or attempted.

## Maturity posture

Treat these as early reference directions unless the downstream project has verified the exact upstream version, host setup, policy language, and failure behavior. Do not describe them as complete containment or production hardening from this template alone.

## Checklist

Before adopting a policy runtime, read:

- `docs/threat-model.md`
- `docs/sandbox-footguns.md`
- `docs/network-dns-audit-boundaries.md`
- `profiles/openclaw-runtime/threat-boundary-checklist.md`

## References

- https://github.com/NVIDIA/OpenShell
- https://github.com/NVIDIA/NemoClaw

## 日本語

OpenShellとNemoClawは、OpenClaw-style assistant向けの将来のpolicy/runtime referenceです。MVPの外側に置き、このrepositoryの必須dependencyにはしません。

- mounted workspaceやsensitive pathに対するdeclarative file access boundaryを評価します。
- network policyではdefault-deny、allowlist、audit-onlyの違いを明確にします。
- prompt、tool output、model call、outbound APIを含むexfiltration controlを検討します。
- operatorがassistantのaccessや試行をreviewできるaudit recordを重視します。
- upstream version、host setup、policy language、failure behaviorを検証するまで、complete containmentとは表現しません。
