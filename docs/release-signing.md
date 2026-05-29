# Release Signing

This repository signs public source release artifacts with Sigstore keyless
signing starting with `v0.1.2`. The `v0.1.1-baseline` tag records migrated
baseline provenance and is not used as active signed-release evidence for this
repository.

## Published artifacts

For each `vMAJOR.MINOR.PATCH` tag starting with `v0.1.2`, the release workflow
publishes these files to the GitHub Release:

- `agent-ready-template-vMAJOR.MINOR.PATCH.tar.gz`
- `agent-ready-template-vMAJOR.MINOR.PATCH.tar.gz.sha256`
- `agent-ready-template-vMAJOR.MINOR.PATCH.tar.gz.sigstore.json`

The archive is created from the tagged commit with `git archive`. The
`.sigstore.json` file is a Cosign bundle that contains the keyless signature,
certificate, and transparency-log verification material.

## Verification

Install Cosign, download the three release artifacts, and verify both the
checksum and Sigstore bundle:

```sh
version=v0.1.2
artifact="agent-ready-template-${version}.tar.gz"

sha256sum -c "${artifact}.sha256"

cosign verify-blob "${artifact}" \
  --bundle "${artifact}.sigstore.json" \
  --certificate-oidc-issuer="https://token.actions.githubusercontent.com" \
  --certificate-identity-regexp="^https://github\\.com/Anionix/agent-ready-template/\\.github/workflows/release\\.yml@refs/tags/v[0-9]+\\.[0-9]+\\.[0-9]+$"
```

Verification succeeds only when the artifact was signed by the repository's
release workflow running for a SemVer tag.

## Boundary

This process signs release artifacts, not every git tag. The OpenSSF
`version_tags_signed` criterion is not claimed until the project also adopts
cryptographically signed version-control tags.
