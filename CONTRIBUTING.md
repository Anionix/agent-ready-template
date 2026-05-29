# Contributing

Thanks for helping improve this repository contract template.

## Process

- Open an issue for behavior, policy, or public-release changes before starting a large change.
- Use pull requests for all changes to `main`.
- Keep pull requests focused and include the verification commands you ran.
- Use the repository command contract from `AGENTS.md`.
- For security-sensitive changes, include `mise run public-release-check` and `mise run secret-scan` results.

## Acceptable contributions

Contributions should:

- preserve this repository as a template, not an application starter;
- avoid mandatory runtime dependencies unless the change explicitly updates the template contract;
- avoid secrets, local machine paths, private infrastructure details, and personal credentials;
- keep English documentation sufficient for public users, even when Japanese companion text is included;
- include tests, static checks, or an explicit rationale when changing scripts, CI, release gates, or security documentation.

## Developer Certificate of Origin

By contributing, you certify that you have the right to submit the contribution under this repository's MIT license. Commit messages should include a `Signed-off-by` trailer using the Developer Certificate of Origin convention:

```text
Signed-off-by: Your Name <your.email@example.com>
```

## Review and merge

This repository currently allows solo maintainer admin merges when CI is green and live review threads are resolved. That is an explicit operational exception, not a claim of two-person review. If the repository later targets full OpenSSF Best Practices Gold, the review policy must change to require independent human review.
