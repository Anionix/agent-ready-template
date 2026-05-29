# Governance

This repository is a public template maintained by `Anionix`.

## Roles

- **Maintainer**: owns repository settings, releases, security policy, branch protection, and final merge decisions.
- **Contributor**: proposes issues, pull requests, documentation fixes, tests, and template improvements.
- **Reviewer**: reviews pull requests or security-sensitive changes when available.

## Decision process

- Routine documentation and template-contract changes are handled through issues and pull requests.
- Security, release, branch-protection, and public-template policy changes require green CI plus explicit maintainer review of residual risk.
- The current solo operating mode permits maintainer or admin merge after required checks pass and live review threads are resolved.
- Normal changes do not require a separate human approval. This is a deliberate solo-maintainer exception, not a claim of two-person review.

## Continuity

This repository uses a private emergency recovery procedure for solo-mode
continuity. The procedure is maintained outside the public repository and is
intended to preserve the ability to triage issues, accept pull requests, and
publish source releases if the current maintainer is unavailable. Do not commit
recovery keys, private contact details, wills, or account-recovery material to
this repository.

## Continuity and Gold blocker

The current bus factor is one. That is acceptable for the selected solo
operating mode, and continuity is handled through the private recovery
procedure above, but bus factor and two-person review remain blockers for an
honest claim of full OpenSSF Best Practices Gold. If the operating model later
changes, those criteria can be revisited; until then they should be reported as
unmet or not applicable instead of enforced through routine approval gates.
