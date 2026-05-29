# CI Runner Hardening

The CI workflow includes StepSecurity Harden-Runner in audit mode. Audit mode observes runner behavior, especially outbound network activity, without turning the repository's CI into a runtime sandbox policy.

## Current posture

- The workflow pins `step-security/harden-runner` by full commit SHA.
- `mise run workflow-pin-audit` requires external workflow actions to stay pinned by full commit SHA.
- `egress-policy: audit` records behavior for review instead of blocking egress by default.
- Workflow permissions stay minimal with `contents: read`.

## Boundary

Harden-Runner audit mode does not replace:

- sandbox profiles for local or agent runtime isolation
- `mise run secret-scan`
- GitHub secret scanning and push protection
- branch protection and required checks
- review of generated shell, dependency lifecycle hooks, mounts, and credentials

Use Harden-Runner findings as observability for CI behavior. Move to blocking egress only after reviewing expected destinations and avoiding brittle failures in normal checks.

## Reference

- https://docs.stepsecurity.io/harden-runner

## 日本語

CI workflowはStepSecurity Harden-Runnerをaudit modeで使います。audit modeはrunner behavior、特にoutbound network activityを観測しますが、repository CIをruntime sandbox policyへ置き換えるものではありません。

- workflow actionはfull commit SHAでpinします。
- `mise run workflow-pin-audit` は外部actionのSHA pinを確認します。
- `egress-policy: audit` はegressをblockせず、review用の観測情報を残します。
- workflow permissionは `contents: read` を基本にします。
- Harden-Runnerの結果はCI挙動のobservabilityとして使い、local sandbox、secret scanning、branch protection、generated shell reviewの代替にはしません。
