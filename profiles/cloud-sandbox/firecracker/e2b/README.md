# E2B Cloud Sandbox Note

E2B is a future cloud sandbox adapter reference for code execution and agent workloads. It stays outside the default repo contract and does not require API keys, SDKs, or CI integration here.

## Fit

Evaluate E2B when a downstream project wants provider-managed remote execution for agent tasks or code interpreter-style workflows. Keep local-first repo checks unchanged.

## Adoption checks

- Store API keys outside the repository.
- Verify persistence, filesystem lifetime, logging, and network behavior for the selected plan.
- Decide what private data may leave the local machine.
- Avoid describing the provider boundary as equivalent to local microVM hardening unless verified for the exact workload.

## Reference

- https://e2b.dev/

## 日本語

E2Bは、code executionやagent workload向けの将来のcloud sandbox adapter referenceです。default repo contractの外側に置き、このtemplateではAPI key、SDK、CI integrationを要求しません。

- downstream projectがprovider-managed remote executionを必要とする場合に評価します。
- API keyはrepository外で管理します。
- persistence、filesystem lifetime、logging、network behaviorをplanごとに確認します。
- local machineから出してよいdataを明確にします。
- 正確なworkloadで検証するまで、local microVM hardeningと同等とは表現しません。
