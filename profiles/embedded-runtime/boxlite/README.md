# BoxLite Embedded Runtime Note

BoxLite is a future embedded runtime reference. This note is for cautious evaluation only and does not make BoxLite a dependency of the template.

## Fit

Evaluate BoxLite when an application wants an embedded runtime or SDK-shaped sandbox control plane rather than a separate local profile or cloud provider adapter.

## Adoption checks

- Verify SDK maturity, supported languages, persistence model, and process isolation before use.
- Keep runtime credentials and application secrets outside this repository.
- Distinguish embedded runtime control from host-level containment.
- Avoid absolute escape-prevention or production-hardening claims from this note alone.

## Reference

- https://docs.boxlite.ai/

## 日本語

BoxLiteは、将来のembedded runtime referenceです。このnoteは慎重な評価のためだけにあり、BoxLiteをtemplate dependencyにはしません。

- applicationがseparate local profileやcloud provider adapterではなく、embedded runtimeやSDK-shaped control planeを求める場合に評価します。
- SDK maturity、supported language、persistence model、process isolationを確認します。
- runtime credentialやapplication secretはrepository外で管理します。
- embedded runtime controlとhost-level containmentを区別します。
- このnoteだけでescape preventionやproduction hardeningを主張しません。
