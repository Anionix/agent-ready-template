# OpenSSF Best Practices Evidence

Checked on 2026-05-29 for OpenSSF Best Practices project 12855.

Project 12855 migrated from old baseline: the project was originally completed
for `Anionix/agent-ready-repo-template-spec@v0.1.1`, which was the Silver
baseline release. It is now the migrated project record for
`Anionix/agent-ready-template`.

Live readback at migration time:

- Project id: `12855`
- Project name: `agent-ready-template`
- Homepage URL: `https://github.com/Anionix/agent-ready-template`
- Repository URL: `https://github.com/Anionix/agent-ready-template`
- Badge level reported before proposal cleanup: `silver`

The OpenSSF project identity already points to this repository, but many
criterion justifications still reference the old private baseline repository.
Those old links are provenance only. Active criterion evidence must point at
`Anionix/agent-ready-template` unless the criterion is explicitly documenting
the migration source.

Do not add a live README badge until the proposal updates have been saved in
the OpenSSF UI and `https://www.bestpractices.dev/projects/12855.json` confirms
both:

- `badge_level` still reports `silver`.
- No active criterion justification depends on `agent-ready-repo-template-spec`.

## Project Links

- Passing: https://www.bestpractices.dev/en/projects/12855/passing
- Silver: https://www.bestpractices.dev/en/projects/12855/silver
- Gold: https://www.bestpractices.dev/en/projects/12855/gold
- Baseline 3: https://www.bestpractices.dev/en/projects/12855/baseline-3
- JSON readback: https://www.bestpractices.dev/projects/12855.json

## Migration Policy

- Keep project `12855`; do not create a second OpenSSF project for this repo.
- Use reviewable automation proposal URLs from
  `docs/openssf-best-practices-proposals.md`; do not commit
  `.bestpractices.json` yet.
- Treat `agent-ready-repo-template-spec@v0.1.1` as historical Silver
  provenance, not current criterion evidence.
- Keep unmet or blocked criteria honest instead of preserving old-repo evidence.
- Keep the README badge withheld until a clean OpenSSF readback confirms the
  migrated state.

## Evidence Map

| Area | Status for this repository | Current evidence |
| --- | --- | --- |
| Project identity | Met after saved proposal | `name`, `homepage_url`, and `repo_url` should identify `Anionix/agent-ready-template`. |
| Public source repository | Met | `https://github.com/Anionix/agent-ready-template` is public, normal, and uses `main` as the default branch. |
| Contribution requirements | Met | `CONTRIBUTING.md`, `CONVENTIONS.md`, `AGENTS.md`, and the PR template document the contribution and verification flow. |
| License | Met | `LICENSE` declares MIT for the repository. |
| Issue/report archive | Met | GitHub Issues, Pull Requests, Releases, and Security Advisories are the archive surfaces for reports and responses. |
| Vulnerability reporting | Met | `SECURITY.md` documents public and private vulnerability reporting and response expectations. |
| CI and checks | Met | `.github/workflows/ci.yml`, `mise.toml`, and the repository scripts define required validation. |
| Static analysis | Met | CodeQL, ShellCheck, actionlint, Hadolint, workflow pin audits, Dockerfile pin audits, and secret scanning are documented in `docs/security-workflows.md` and `mise.toml`. |
| Governance | Met with solo-maintainer caveat | `GOVERNANCE.md` and `MAINTAINERS.md` document roles and emergency continuity. |
| Documentation | Met | `README.md`, `docs/architecture.md`, `docs/roadmap.md`, `docs/threat-model.md`, and `docs/development.md` are current for the clean template. |
| Release process | Partially met | `docs/release-process.md`, `docs/release-signing.md`, `.github/workflows/release.yml`, and `CHANGELOG.md` define the intended release process. |
| Signed releases | Unmet for the new repo until a signed SemVer release exists | The old `v0.1.1` signed release proves baseline provenance only. It must not be used as active evidence for `Anionix/agent-ready-template`. |
| Version-control tag signatures | Unmet with justification | Release artifacts can be signed, but git tags themselves are not claimed as signed. |
| Product cryptography | N/A | The template does not implement product cryptography or a network protocol. |
| Product hardening | N/A | The template does not publish a compiled product binary or hosted application requiring runtime hardening. |

## Gold Blockers

Gold must remain blocked until the project state changes:

| Criterion | Honest status | Reason |
| --- | --- | --- |
| `bus_factor` | Unmet | Current bus factor is one. Private continuity is not the same as a bus factor of two. |
| `contributors_unassociated` | Blocked | The project does not yet have two significant unaffiliated contributors. |
| `two_person_review` | Blocked | Solo admin merge remains allowed. Do not claim 50% independent review. |
| `require_2FA` / `secure_2FA` | Manual verification required | Do not claim until the GitHub account or organization 2FA posture is verified. |
| `copyright_per_file` / `license_per_file` | Not claimed | The repository has a root MIT license, but per-file copyright/SPDX coverage is not complete. |

## Save And Readback Flow

1. Open each proposal URL in `docs/openssf-best-practices-proposals.md`.
2. Review the highlighted OpenSSF UI changes and save only the values that are
   true for `Anionix/agent-ready-template`.
3. Before saving `signed_releases=Met`, publish and verify a signed SemVer
   release for this repository. Otherwise leave it `Unmet`.
4. Read back `https://www.bestpractices.dev/projects/12855.json`.
5. Add a live README badge only after the readback confirms migrated Silver and
   old private repository links are gone from active criterion justifications.
