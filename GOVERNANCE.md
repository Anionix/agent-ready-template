# Governance

This repository is a public template maintained by `Anionix`.

## Roles

- **Maintainer**: owns repository settings, releases, security policy, branch protection, and final merge decisions.
- **Contributor**: proposes issues, pull requests, documentation fixes, tests, and template improvements.
- **Reviewer**: reviews pull requests or security-sensitive changes when available.

## Decision process

- Routine documentation and template-contract changes are handled through issues and pull requests.
- Security, release, branch-protection, and public-template policy changes require green CI plus explicit maintainer review of residual risk.
- The current solo operating mode permits admin squash merge after required checks pass and live review threads are resolved.

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
procedure above, but bus factor remains a separate blocker for an honest claim
of full OpenSSF Best Practices Gold. To remove that blocker, the project must
add at least one independent maintainer or reviewer and require independent
human review for a meaningful share of proposed modifications.
