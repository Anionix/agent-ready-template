# OpenSSF Best Practices Evidence

Checked on 2026-05-17 for the original `Anionix/agent-ready-repo-template-spec`
project 12855. This repository is a clean canonical snapshot derived from that
`v0.1.1` Silver baseline.

Project page:

- https://www.bestpractices.dev/en/projects/12855/passing
- https://www.bestpractices.dev/en/projects/12855/silver
- https://www.bestpractices.dev/en/projects/12855/gold

This document is the repository-backed evidence map for filling or revalidating
the OpenSSF Best Practices project for `Anionix/agent-ready-template`. It is not
a badge claim by itself. The live badge is intentionally kept out of the
template README until the Best Practices site reports the achieved level for
this repository.

## Current target

- Revalidate the clean `agent-ready-template` repository against the Silver
  baseline before adding a live badge.
- Keep project 12855 links as provenance for the original
  `agent-ready-repo-template-spec` `v0.1.1` release.
- Do not fake independent review, bus factor, signed version-control tags, or contributor diversity.
- `access_continuity` is handled through a private emergency recovery procedure; the secret recovery material is not public.
- Full Gold remains blocked until the project has an independent maintainer or reviewer and a real two-person review history.

## Passing entries to update

Use these entries after this documentation PR is merged.

| Criterion | Status | Evidence or justification |
| --- | --- | --- |
| `english` | Met | Public docs required for operation are in English, with Japanese as companion text where present. Evidence: `README.md`, `AGENTS.md`, `CONTRIBUTING.md`. |
| `maintained` | Met | The repository is active and pursuing the badge. Evidence: recent commits, issues, PRs, and `MAINTAINERS.md`. |
| `repo_interim` | Met | Work is stored in GitHub git history before release. Evidence: public repository history. |
| `version_unique` | Met | Public releases use unique SemVer tags. Evidence: `docs/release-process.md`, `CHANGELOG.md`. |
| `version_semver` | Met | Tags use `vMAJOR.MINOR.PATCH`. Evidence: `docs/release-process.md`. |
| `version_tags` | Met for baseline provenance; recheck after new repo release | Baseline evidence: https://github.com/Anionix/agent-ready-repo-template-spec/releases/tag/v0.1.1 |
| `release_notes` | Met | Evidence: `CHANGELOG.md`. |
| `release_notes_vulns` | Met | Security-impacting changes are noted in release notes; no known medium-or-higher public vulnerabilities exist at this snapshot. Evidence: `CHANGELOG.md`, `SECURITY.md`. |
| `report_process` | Met | Bug and vulnerability reporting routes are documented. Evidence: `SECURITY.md`, GitHub Issues. |
| `report_archive` | Met after new repository publication | GitHub Issues, Pull Requests, Releases, and Security Advisories preserve reports and responses. Evidence: https://github.com/Anionix/agent-ready-template/issues, https://github.com/Anionix/agent-ready-template/pulls, https://github.com/Anionix/agent-ready-template/releases, https://github.com/Anionix/agent-ready-template/security/advisories |
| `vulnerability_report_process` | Met | Evidence: `SECURITY.md`. |
| `vulnerability_report_private` | Met | Private vulnerability reporting uses GitHub security advisories. Evidence: `SECURITY.md`. |
| `vulnerability_report_response` | Met | Response timelines are documented. Evidence: `SECURITY.md`. |
| `build` | Met | Standard build/check entrypoints use `mise`. Evidence: `README.md`, `docs/development.md`, `mise.toml`. |
| `build_common_tools` | Met | Uses common tools: git, GitHub Actions, mise, Docker Compose, Go, ShellCheck, Hadolint, and the CodeQL advanced workflow. |
| `build_floss_tools` | Met | Required local and CI tools are FLOSS or GitHub-hosted public services. Evidence: `mise.toml`, `.github/workflows/ci.yml`. |
| `test_continuous_integration` | Met | CI runs on pull requests and pushes. Evidence: `.github/workflows/ci.yml`. |
| `test_policy` | Met | Contribution rules require checks or rationale for script, CI, release, and security changes. Evidence: `CONTRIBUTING.md`. |
| `tests_are_added` | Met | New behavior should include tests/checks or an explicit rationale. Evidence: `CONTRIBUTING.md`, PR template. |
| `tests_documented_added` | Met | PRs must list verification commands. Evidence: `.github/pull_request_template.md`. |
| `warnings` | Met | ShellCheck and Hadolint run as static warning checks. Evidence: `mise.toml`. |
| `warnings_fixed` | Met | CI gates static warnings at the configured threshold. Evidence: `mise run check`. |
| `warnings_strict` | Met | ShellCheck has zero warnings for scripts; Hadolint uses `failure-threshold: error` for optional Dockerfiles. |
| `know_secure_design` | Met | Security boundaries and threat model are documented. Evidence: `docs/threat-model.md`, `docs/architecture.md`. |
| `know_common_errors` | Met | Common footguns and sandbox risks are documented. Evidence: `docs/sandbox-footguns.md`, `docs/security-workflows.md`. |
| `crypto_published` | N/A | The template does not implement cryptographic protocols. |
| `crypto_call` | N/A | The template does not call cryptographic libraries as product functionality. |
| `crypto_floss` | N/A | The template does not implement or bundle product cryptography. |
| `crypto_keylength` | N/A | No project cryptographic key lengths are selected by this template. |
| `crypto_working` | N/A | No project cryptographic protocol is implemented. |
| `crypto_weaknesses` | N/A | No project cryptographic protocol is implemented. |
| `crypto_pfs` | N/A | No project network protocol is implemented. |
| `crypto_password_storage` | N/A | The template stores no user passwords. |
| `crypto_random` | N/A | The template does not generate security-sensitive random values. |
| `delivery_unsigned` | Met | Distribution is through HTTPS GitHub repository access; signed release artifacts are handled separately for Silver. |
| `vulnerabilities_fixed_60_days` | Met | Policy requires coordinated vulnerability handling; no known qualifying vulnerability exists at this snapshot. Evidence: `SECURITY.md`. |
| `vulnerabilities_critical_fixed` | Met | Policy requires faster handling for critical vulnerabilities; no known qualifying vulnerability exists at this snapshot. Evidence: `SECURITY.md`. |
| `no_leaked_credentials` | Met | Secret scanning and public-release checks run in CI. Evidence: `.github/workflows/ci.yml`, `scripts/secret-scan.sh`. |
| `static_analysis` | Met | The CodeQL advanced workflow, ShellCheck, actionlint, Hadolint, and custom pin audits are used. Evidence: `docs/security-workflows.md`, `mise.toml`. |
| `static_analysis_common_vulnerabilities` | Met | The CodeQL advanced workflow covers supported languages; shell and workflow checks cover template scripts and Actions. |
| `static_analysis_fixed` | Met | Static analysis findings must be fixed or documented before release. Evidence: `CONTRIBUTING.md`, PR template. |
| `static_analysis_often` | Met | CI and CodeQL run on pull requests or pushes. Evidence: `.github/workflows/ci.yml`. |
| `dynamic_analysis` | Met | Docker Compose smoke readiness and the optional Go fuzz harness provide dynamic checks. Evidence: `mise.toml`, `.clusterfuzzlite/Dockerfile`. |
| `dynamic_analysis_unsafe` | N/A | The template has no memory-unsafe application runtime. |
| `dynamic_analysis_enable_assertions` | N/A | The template has no application assertion mode. |
| `dynamic_analysis_fixed` | Met | Dynamic check failures are treated as release blockers in CI or documented residual risk. Evidence: PR template and release process. |

## Silver entries to update

| Criterion | Status | Evidence or justification |
| --- | --- | --- |
| `achieve_passing` | Recheck for new repository | Complete or update the Best Practices project for `Anionix/agent-ready-template` first. |
| `dco` | Met | `CONTRIBUTING.md` requires a DCO-style `Signed-off-by` trailer for contributions. |
| `governance` | Met | Evidence: `GOVERNANCE.md`, `MAINTAINERS.md`. |
| `code_of_conduct` | Met | Evidence: `CODE_OF_CONDUCT.md`. |
| `roles_responsibilities` | Met | Evidence: `GOVERNANCE.md`, `MAINTAINERS.md`. |
| `access_continuity` | Met | Solo-mode continuity is handled through a private emergency recovery procedure. Evidence: `MAINTAINERS.md`, `GOVERNANCE.md`. |
| `bus_factor` | Unmet with justification | Bus factor is currently one. Continuity is handled separately through private recovery; do not claim bus factor of two. Evidence: `MAINTAINERS.md`, `GOVERNANCE.md`. |
| `documentation_roadmap` | Met | Evidence: `docs/roadmap.md`. |
| `documentation_architecture` | Met | Evidence: `docs/architecture.md`. |
| `documentation_security` | Met | Evidence: `SECURITY.md`, `docs/threat-model.md`, `docs/security-workflows.md`. |
| `documentation_quick_start` | Met | Evidence: `README.md`. |
| `documentation_current` | Met | Best Practices evidence is versioned with the repository. Evidence: this file and `CHANGELOG.md`. |
| `documentation_achievements` | Met | Badge status, proposal URLs, and blockers are documented here and linked from the README. |
| `accessibility_best_practices` | Met | Documentation is plain Markdown and avoids requiring non-text UI to operate the project. |
| `internationalization` | Met | English is sufficient; Japanese companion text is included where helpful. |
| `sites_password_security` | N/A | The project does not operate a password-based website. |
| `maintenance_or_update` | Met | Dependabot and release processes are documented. Evidence: `.github/dependabot.yml`, `docs/release-process.md`. |
| `vulnerability_report_credit` | Met | Credit can be handled in security advisories or release notes when appropriate. Evidence: `SECURITY.md`. |
| `vulnerability_response_process` | Met | Evidence: `SECURITY.md`. |
| `coding_standards` | Met | Evidence: `CONVENTIONS.md`, `AGENTS.md`, `CONTRIBUTING.md`. |
| `coding_standards_enforced` | Met | Evidence: CI, ShellCheck, actionlint, Hadolint, pin audits, public-release checks. |
| `build_standard_variables` | Met | Standard command environment is documented; `MISE_CACHE_DIR` can be set externally. |
| `build_preserve_debug` | N/A | The template does not publish compiled product binaries with debug symbols to preserve. |
| `build_non_recursive` | Met | Build/check commands are direct `mise` tasks. |
| `build_repeatable` | Met | Tools are declared in `mise.toml`; Dockerfile bases and Actions are pinned. |
| `installation_common` | Met | Evidence: `README.md`, `docs/development.md`. |
| `installation_standard_variables` | Met | Environment-driven cache examples are in release process commands. |
| `installation_development_quick` | Met | Evidence: Quickstart in `README.md`. |
| `external_dependencies` | Met | External tools are declared in `mise.toml` or GitHub workflows. |
| `dependency_monitoring` | Met | Dependabot is configured. |
| `updateable_reused_components` | Met | Dependencies are pinned and updateable through Dependabot or explicit version changes. |
| `interfaces_current` | Met | Public commands are listed in `README.md`, `AGENTS.md`, and `mise.toml`. |
| `automated_integration_testing` | Met | Docker Compose smoke checks run in the full CI lane. |
| `regression_tests_added50` | Met with process evidence | Contribution policy requires tests/checks or rationale for behavior changes. |
| `test_statement_coverage80` | N/A | The repository is primarily a documentation/template contract; there is no product library with meaningful statement coverage. |
| `test_policy_mandated` | Met | Evidence: `CONTRIBUTING.md`, PR template. |
| `tests_documented_added` | Met | Evidence: PR template. |
| `warnings_strict` | Met | Evidence: ShellCheck, actionlint, Hadolint, pin audits. |
| `implement_secure_design` | Met | Evidence: `docs/threat-model.md`, `docs/security-workflows.md`, `docs/architecture.md`. |
| `crypto_*` | N/A unless HTTPS distribution | The template does not implement product cryptography; HTTPS distribution is provided by GitHub. |
| `signed_releases` | Met for baseline provenance; recheck after new repo release | Original `v0.1.1` release artifacts were signed with Sigstore keyless Cosign bundles. New `agent-ready-template` releases use `docs/release-signing.md` and `.github/workflows/release.yml`. |
| `version_tags_signed` | Unmet with justification | Release artifacts are signed, but version-control tags themselves are not yet claimed as signed. |
| `input_validation` | N/A | No network-facing application input parser is shipped. |
| `hardening` | N/A | The template does not publish a compiled product binary or hosted application requiring runtime hardening. CI and repository hardening are documented separately. |
| `assurance_case` | Met | Security assumptions, threat boundaries, and mitigations are documented. Evidence: `docs/threat-model.md`, `docs/security-workflows.md`, `docs/architecture.md`, this file. |
| `static_analysis_common_vulnerabilities` | Met | Evidence: CodeQL advanced workflow plus shell/workflow/static checks. |
| `dynamic_analysis_unsafe` | N/A | No memory-unsafe application runtime is shipped. |

## Gold entries and blockers

| Criterion | Status | Evidence or justification |
| --- | --- | --- |
| `achieve_silver` | Recheck for new repository | The original baseline reached Silver; add a live badge here only after the Best Practices site reports Silver for `Anionix/agent-ready-template`. |
| `bus_factor` | Blocked | Current bus factor is one; private recovery satisfies continuity, not bus factor. |
| `contributors_unassociated` | Blocked | The project does not yet have two significant unaffiliated contributors. |
| `two_person_review` | Blocked | Solo admin merge remains allowed by policy. Do not claim 50% independent review. |
| `code_review_standards` | Partially met | Review standards are in PR template, `CONTRIBUTING.md`, and optional orchestration docs. |
| `require_2FA` | Manual platform policy | Do not claim unless GitHub organization/account policy can be verified. |
| `secure_2FA` | Manual platform policy | Do not claim unless maintainer 2FA posture can be verified. |
| `copyright_per_file` | Not claimed | Root license covers the repository; per-file copyright is not complete. |
| `license_per_file` | Not claimed | Root license covers the repository; per-file SPDX coverage is not complete. |
| `small_tasks` | Met | Issue templates and contribution guidance encourage focused tasks. |
| `build_reproducible` | Partially met | Tools and container bases are pinned, but bit-for-bit release reproducibility is not claimed. |
| `test_continuous_integration` | Met | Evidence: CI workflow. |
| `test_statement_coverage90` | N/A | No product library with meaningful statement coverage. |
| `test_branch_coverage80` | N/A | No product library with meaningful branch coverage. |
| `crypto_*` | N/A | No product cryptography. |
| `hardened_site` | N/A for project-hosted site | The project uses GitHub-hosted HTTPS pages/repository, not a custom application site. |
| `security_review` | Met for template scope | Evidence: threat model, security workflows, public release checks, Scorecard, CodeQL, secret scanning. |
| `hardening` | N/A for product hardening | The template does not publish a compiled product binary or hosted application requiring runtime hardening. |
| `dynamic_analysis` | Met | Docker Compose smoke checks and fuzz harness. |
| `dynamic_analysis_enable_assertions` | N/A | No application assertion mode. |

## Manual follow-up

After this PR merges:

1. Create or update the OpenSSF Best Practices project for `Anionix/agent-ready-template`.
2. Publish and verify a signed SemVer release before saving `signed_releases=Met` for this repository.
3. Use `docs/openssf-best-practices-proposals.md` to review and save the Silver proposal.
4. Rerun OpenSSF Scorecard on `main` and confirm `CII-Best-Practices` reports Silver before adding a live badge.
