# Sandbox Profile Adoption Checklist

Use this checklist before moving agent work away from the default host workflow. It is advisory only; it does not add runtime enforcement or make any optional profile mandatory.

## Decision checklist

| Question | If yes | Candidate boundary |
|---|---|---|
| Does the task stay inside one trusted repo with no real secrets nearby? | Keep the normal `mise` loop. | Host |
| Does the task execute generated shell, unknown scripts, or dependency lifecycle hooks? | Limit files, secrets, and egress before running it. | Process sandbox or disposable workspace |
| Does the task match the lethal-trifecta pattern from `docs/threat-model.md`? | Separate private data, untrusted content, and outbound communication. | MicroVM, cloud sandbox, or OpenClaw runtime profile |
| Does the task need Docker while handling untrusted code? | Avoid passing the host Docker socket into the agent environment. | Disposable VM, Docker-native sandbox, or no Docker access |
| Does the assistant need to run for a long time with broad filesystem access? | Treat browser state, OAuth tokens, home directories, and message-posting APIs as high-risk. | OpenClaw runtime profile or microVM |
| Does the work need provider-managed remote execution? | Verify account, data-retention, persistence, logging, and network controls. | Cloud sandbox adapter |

## Profile mapping

| Profile family | Use when | Do not assume |
|---|---|---|
| Host | The task is low risk and fully reviewed. | That normal repo permissions protect nearby machine state. |
| Process sandbox | Daily risky work needs narrower file access. | Kernel-level isolation or protection from privileged host services. |
| Docker sandbox | The team wants Docker-native agent ergonomics. | That the host Docker socket or broad mounts are safe. |
| MicroVM | A stronger local boundary is needed and the host supports it. | That all mounts, secrets, and egress are safe by default. |
| OpenClaw runtime | An always-on assistant needs policy, network, secrets, and audit boundaries. | That a runtime reference is production hardening without local validation. |
| Cloud sandbox | Remote execution is acceptable for the task and data. | That every provider has the same isolation, persistence, and audit model. |
| Embedded runtime | The app wants runtime APIs inside its own control plane. | That embedding a runtime is equivalent to a full host security boundary. |

## Non-goals

- Do not use this checklist as a security certification.
- Do not require Nix, KVM, Docker Sandboxes, OpenClaw, cloud providers, BoxLite, or Microsandbox in default CI.
- Do not claim complete containment without validating the exact host, runtime version, mounts, secrets, and egress policy.

## 日本語

このchecklistは、defaultのhost workflowからagent作業を移す前の判断補助です。runtime enforcementを追加するものではなく、任意profileを必須化しません。

- 低リスクでreview済みの作業は、通常の `mise` loopで扱います。
- generated shell、未知のscript、dependency lifecycle hookを実行する場合は、file access、secret、egressを先に絞ります。
- `docs/threat-model.md` のlethal-trifectaに近い場合は、private data、untrusted content、outbound communicationを分離します。
- Dockerが必要でも、untrusted agent作業へhost Docker socketを渡さないでください。
- cloudやembedded runtimeは、downstream projectがprovider、credential、data handlingを検証してから採用する任意profileです。
- このchecklistだけで完全なcontainmentやsecurity certificationを主張しません。
