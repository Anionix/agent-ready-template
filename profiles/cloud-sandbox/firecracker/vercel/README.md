# Vercel Sandbox Cloud Note

Vercel Sandbox is a future cloud sandbox adapter reference. This repository does not add `@vercel/sandbox`, Vercel credentials, or provider-specific CI.

## Fit

Evaluate Vercel Sandbox when a downstream application wants TypeScript-accessible remote task environments for coding agents or generated-code workflows.

## Adoption checks

- Keep Vercel tokens and project configuration outside this template.
- Verify filesystem persistence, command execution lifecycle, networking, logs, and billing before use.
- Treat the provider environment as remote execution, not as a default local development path.
- Avoid strong hardening claims unless the exact account, region, runtime, and policy are reviewed.

## Reference

- https://vercel.com/docs/vercel-sandbox/

## 日本語

Vercel Sandboxは、将来のcloud sandbox adapter referenceです。このrepositoryは `@vercel/sandbox`、Vercel credential、provider-specific CIを追加しません。

- downstream applicationがTypeScriptからremote task environmentを扱いたい場合に評価します。
- Vercel tokenやproject configurationはこのtemplateに含めません。
- filesystem persistence、command lifecycle、networking、logs、billingを採用前に確認します。
- provider環境はremote executionとして扱い、default local development pathにはしません。
- account、region、runtime、policyを確認するまで強いhardening claimは避けます。
