# OpenClaw Runtime Threat-Boundary Checklist

Use this checklist before running an always-on assistant with broad local access. It maps risk answers to host, process sandbox, microVM, or OpenClaw runtime profile choices.

| Question | Risk signal | Boundary response |
|---|---|---|
| Can the assistant read private data or local home-directory state? | Private data is in scope. | Avoid host mode; use a narrow mount or stronger boundary. |
| Can the assistant process untrusted content? | Prompt injection or generated tool use can steer behavior. | Use disposable workspace and reviewed tool permissions. |
| Can the assistant communicate externally? | The lethal-trifecta path may be complete. | Disable, allowlist, or audit egress; consider microVM/OpenClaw runtime. |
| Does it have browser, OAuth, SSH, package-registry, or cloud state nearby? | Credentials may be ambient rather than explicit. | Use throwaway profiles and scoped test credentials. |
| Does it need Google Workspace or OAuth-backed CLI access? | OAuth tokens and browser-derived state can cross into the assistant runtime. | Split OpenClaw runtime and gogcli/OAuth tooling into separate VMs or equivalent compartments. |
| Are file mounts broad or writable? | Host state can leak into the runtime. | Mount the smallest task workspace; prefer read-only references. |
| Are outbound APIs or message-posting tools available? | The assistant can exfiltrate or act externally. | Add review, egress policy, and audit logging before autonomy. |
| Is a defender or classifier pipeline present? | Prompt/tool filtering may reduce risk but can fail open or drift. | Treat it as an additional review layer; version, test, and log it before claiming enforcement. |
| Are DNS, nftables, or auditd configured? | Operators may confuse visibility with prevention. | Separate logging, filtering, and enforcement expectations in the runbook. |

## Output mapping

- Mostly no: host workflow is acceptable.
- Generated commands or unknown scripts only: process sandbox or disposable workspace.
- Private data plus untrusted content: microVM or equivalent stronger boundary.
- Private data plus untrusted content plus external communication: OpenClaw runtime profile or microVM with explicit network and audit policy.
- OAuth-backed Google Workspace access: keep tokens in a gogcli/tool VM or equivalent compartment and expose only a narrow approved command surface to the assistant runtime.
- Defender pipeline enabled: keep human review and egress/audit boundaries in place; do not treat classifier output as complete containment.

This checklist is advisory. It does not store credentials, enforce runtime policy, or prove containment.

## 日本語

このchecklistは、broad local accessを持つalways-on assistantを動かす前の判断補助です。risk answerをhost、process sandbox、microVM、OpenClaw runtime profileの候補へ対応づけます。

- private dataやhome-directory stateを読める場合は、host modeを避け、narrow mountやより強い境界を検討します。
- untrusted contentやgenerated tool useがある場合は、disposable workspaceとreview済みpermissionを使います。
- external communicationがある場合は、egressをdisable、allowlist、auditし、microVM/OpenClaw profileを検討します。
- browser、OAuth、SSH、package registry、cloud stateが近くにある場合は、throwaway profileとscoped test credentialを使います。
- このchecklistはcredential保存、runtime policy enforcement、containment証明を行いません。
