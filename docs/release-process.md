# Release Process

This repository uses Semantic Versioning for public tags.

## Version identifiers

- Tags use `vMAJOR.MINOR.PATCH`, for example `v0.1.0`.
- Release notes are recorded in `CHANGELOG.md`.
- GitHub Releases may repeat the changelog entry and link back to the tagged commit.
- Release artifacts for `v0.1.1` and later are signed with Sigstore keyless
  signing as described in `docs/release-signing.md`.

## Release checklist

Before creating a release:

```sh
git diff --check
MISE_CACHE_DIR=/private/tmp/mise-cache mise run doctor-static
MISE_CACHE_DIR=/private/tmp/mise-cache mise run agent-ready-json
MISE_CACHE_DIR=/private/tmp/mise-cache mise run workflow-pin-audit
MISE_CACHE_DIR=/private/tmp/mise-cache mise run dockerfile-pin-audit
MISE_CACHE_DIR=/private/tmp/mise-cache mise run shellcheck
MISE_CACHE_DIR=/private/tmp/mise-cache mise run fuzz
MISE_CACHE_DIR=/private/tmp/mise-cache mise run check
MISE_CACHE_DIR=/private/tmp/mise-cache mise run public-release-check
```

Run the full release gate when a Docker-compatible runtime is available:

```sh
MISE_CACHE_DIR=/private/tmp/mise-cache mise run release-check
```

## Signing status

`v0.1.0` is the pre-Silver bootstrap release. For `v0.1.1` and later, the
release workflow publishes a source archive, SHA256 checksum, and Sigstore
bundle. Do not mark OpenSSF signed-release criteria as met for a release until
the release artifacts are published and verified with the documented
`cosign verify-blob` command.
