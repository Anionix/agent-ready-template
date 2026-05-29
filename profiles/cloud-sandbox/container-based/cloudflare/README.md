# Cloudflare Sandbox Container-Based Note

Cloudflare Sandbox SDK is a future container-based cloud sandbox adapter reference. Use container-based wording for this profile; do not describe it as a microVM profile.

## Fit

Evaluate Cloudflare Sandbox SDK when a downstream Workers application needs to execute commands, manage files, run processes, or expose services in provider-managed container-backed sandboxes.

## Adoption checks

- Do not require a Cloudflare account for this template.
- Keep Wrangler config, account IDs, and tokens out of the template.
- Verify container image lifecycle, filesystem persistence, network access, logs, and data-handling requirements.
- Keep provider SDK integration in downstream applications, not in the base repo contract.

## Reference

- https://developers.cloudflare.com/sandbox/

## 日本語

Cloudflare Sandbox SDKは、将来のcontainer-based cloud sandbox adapter referenceです。このprofileではcontainer-basedという表現を使い、microVM profileとは記述しません。

- downstream Workers applicationがcommand execution、file管理、process実行、service公開を必要とする場合に評価します。
- このtemplateでCloudflare accountを必須にしません。
- Wrangler config、account ID、tokenはtemplateに含めません。
- container image lifecycle、filesystem persistence、network access、logs、data handlingを検証します。
- provider SDK integrationはbase repo contractではなくdownstream application側に置きます。
