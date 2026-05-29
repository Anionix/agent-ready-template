# Security Workflows

This template keeps security automation small by default. It is a public repository contract, not an application codebase, so the baseline favors low-noise checks that fit a stack-agnostic repo.

## Adopted now

- CodeQL advanced setup is committed in `.github/workflows/codeql.yml`, SHA-pinned, and scans GitHub Actions workflows plus the Go fuzz harness.
- OpenSSF Scorecard runs weekly and by manual dispatch to report supply-chain posture.
- Workflow pin auditing requires external GitHub Actions to use full commit SHA pins.
- Dockerfile pin auditing requires optional Dockerfiles to pin base images by digest and avoid download-to-shell pipelines.
- Hadolint runs through `mise run dockerfile-lint` and is included in `mise run check` for optional Dockerfiles under `optional/`.
- ShellCheck runs through `mise run shellcheck` and is included in `mise run check` for repository scripts.
- The optional fuzz harness under `fuzz/` and the `.clusterfuzzlite/Dockerfile` marker give Scorecard a lightweight fuzzing integration without turning this template into an application starter.
- Secret scanning remains `mise run secret-scan`, which wraps the public release checks plus gitleaks and TruffleHog.

## Boundaries

- Scorecard is an observation workflow. Do not require it in branch protection until it has proven stable for this repository.
- The Scorecard workflow uses the default `GITHUB_TOKEN`; do not add a personal access token only to improve branch-protection scoring.
- Local actions using `uses: ./...` are allowed by the pin audit; external actions must not use mutable tags.
- Optional Dockerfiles may remain examples, but their base images must stay digest-pinned and downloaded tools must be checksum-verified before installation.
- Hadolint uses `failure-threshold: error` so template Dockerfile warnings stay visible without turning optional example images into a production image policy.
- The ClusterFuzzLite Dockerfile is optional and only runs the repository fuzz harness; it must not become a required service or release dependency for downstream template users.
- GitHub's automatic CodeQL setup must stay disabled while the committed advanced workflow is active; GitHub rejects CodeQL SARIF uploads when automatic setup is enabled for the repository.
- The Code Review Scorecard signal is historical. Solo-owner admin merges are an accepted operational exception when checks are green and live review threads are resolved; do not enable `enforce_admins` only to improve this score.
- The Maintained Scorecard signal is time-gated for a newly created repository. Do not fake activity; rerun Scorecard after the repository is old enough to be evaluated normally.
- The CII Best Practices Scorecard signal requires a real OpenSSF Best Practices project and badge. A dynamic status badge may point at the project URL; do not claim Passing, Silver, or Gold until the site reports that level.
- OpenSSF Best Practices evidence lives in `docs/openssf-best-practices.md`. Do not mark solo-blocked Gold criteria as met unless the maintainer and review model actually changes.

## Deferred

- Add OSV Scanner or Dependency Review when real package manifests and lockfiles appear.
- Add Syft SBOM when releases, generated artifacts, or app-template variants are published.
- Add Trivy or Grype when container images are built or dependency manifests become meaningful.

Commercial, account-based, mobile, API, DAST, and language-specific scanners stay out of the default template until a downstream project has a concrete stack and credential model that justifies them.

## References

- https://docs.github.com/en/code-security/code-scanning/creating-an-advanced-setup-for-code-scanning/configuring-code-scanning-with-codeql
- https://github.com/ossf/scorecard-action
- https://github.com/hadolint/hadolint
- https://docs.github.com/en/code-security/code-scanning/integrating-with-code-scanning/uploading-a-sarif-file-to-github
