# Microsandbox Embedded Runtime Note

Microsandbox is a future embedded runtime reference. This template does not vendor it, install it, or add it to CI.

## Fit

Evaluate Microsandbox when a downstream project wants programmatic sandbox lifecycle control for agent or generated-code workflows inside its own application architecture.

## Adoption checks

- Verify runtime maturity, supported SDKs, image behavior, metrics, persistence, and network controls.
- Keep secrets, API keys, and host credentials out of the embedded runtime by default.
- Treat embedded runtime isolation as a design surface that must be validated, not as a generic security guarantee.
- Keep the base template dependency-free.

## Reference

- https://github.com/zerocore-ai/microsandbox

## 日本語

Microsandboxは、将来のembedded runtime referenceです。このtemplateはvendorせず、installせず、CIにも追加しません。

- downstream projectがagentやgenerated-code workflowのsandbox lifecycleをapplication内で制御したい場合に評価します。
- runtime maturity、supported SDK、image behavior、metrics、persistence、network controlを確認します。
- secret、API key、host credentialはembedded runtimeへdefaultで持ち込まないでください。
- embedded runtime isolationは検証すべきdesign surfaceであり、generic security guaranteeではありません。
- base templateはdependency-freeのまま維持します。
