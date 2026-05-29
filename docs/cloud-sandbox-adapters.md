# Cloud Sandbox Adapter Taxonomy

Cloud sandbox adapters are future optional references for teams that want provider-managed execution. They are not the default local development path and must not become required checks in this template.

## Taxonomy

| Bucket | Provider references | Fit | Notes |
|---|---|---|---|
| Firecracker-style cloud sandboxes | E2B, Vercel Sandbox, Fly Sprites | Remote execution for coding agents, code interpretation, or task environments. | Verify persistence, network controls, account boundaries, and data handling before use. |
| Dedicated-computer sandboxes | Daytona | Provider-managed development computers or persistent workspaces. | Treat as remote machines with credentials, storage, and lifecycle policy. |
| Container-based cloud sandboxes | Cloudflare Sandbox SDK | Container-backed execution from Workers applications. | Use container-based wording; do not describe it as a microVM profile. |

## Local-first boundary

The repo template stays local-first. Cloud adapters belong in documentation until a downstream project deliberately chooses a provider, configures credentials outside the repository, and validates data-handling requirements.

## Provider notes

- `profiles/cloud-sandbox/firecracker/e2b/README.md`
- `profiles/cloud-sandbox/firecracker/vercel/README.md`
- `profiles/cloud-sandbox/dedicated-computer/daytona/README.md`
- `profiles/cloud-sandbox/container-based/cloudflare/README.md`

Fly Sprites is tracked as a taxonomy bucket only in this sweep. Add a dedicated profile note later if the project decides to evaluate it directly.

## References

- https://e2b.dev/
- https://vercel.com/docs/vercel-sandbox/
- https://www.daytona.io/docs/
- https://developers.cloudflare.com/sandbox/
- https://fly.io/learn/agent-sandbox/

## 日本語

Cloud sandbox adapterは、provider-managed executionを選びたいteam向けの将来の任意referenceです。default local development pathではなく、このtemplateの必須checkにも入れません。

- Firecracker-style cloud sandboxは、agent taskやcode interpreter風workflowのremote execution候補です。
- Dedicated-computer sandboxは、persistent workspaceやremote machineとして扱います。
- Container-based cloud sandboxはcontainer-backed executionとして記述し、microVM profileとは呼びません。
- provider credential、account setting、data-retention、logging、network controlはrepository外で管理し、採用前にdownstream projectで検証します。
- local-firstのrepo contractは維持し、cloud provider導入をこのtemplateの前提にしません。
