# GitHub Protection Policy / GitHub保護設定方針

## English

This repository stays private until a separate public-release decision is made. While private repository protections are unavailable on the current GitHub plan, use the repository-local gates:

```sh
mise run release-check
mise run github-protection-status
```

After the repository is public, protect `main` before accepting normal contributions:

```sh
scripts/apply-main-branch-protection.sh --apply --strict
mise run github-protection-status
```

The solo branch protection settings are:

- Require pull requests before merging.
- Require the `check` status check.
- Require branches to be up to date before merging.
- Require linear history.
- Keep required reviews disabled.
- Disable force pushes.
- Disable branch deletion.

The public-strict settings add:

- Require one approving review.
- Require CODEOWNER review.
- Dismiss stale reviews after new commits.

Repository owners may still use an admin merge for solo maintenance when CI is
green, the branch is based on the intended target, and there are no live
unresolved review threads. This is an explicit operational exception; do not
turn on admin enforcement only to improve an aggregate Code Review score.

For orchestrated agent work, human review remains a process gate even when a
solo-mode repository does not enforce required reviews in GitHub. A green CI
run, successful agent loop, verifier summary, or sandbox completion is evidence
for review, not approval by itself. In solo ruleset-backed mode, preserve pull
requests, required checks, up-to-date branches, linear history, and resolved
review threads without requiring a separate approving review. Public-strict
mode may add a required approving review when the project has enough reviewers.
Merging, release decisions, rollback of policy-sensitive changes, and
branch-protection changes still require explicit maintainer risk review.

When rulesets are available, prefer rulesets over branch protection for the long-term configuration:

- `main` branch ruleset: pull request required, `check` required, up-to-date required, linear history required, force pushes blocked, deletion blocked, 0 approving reviews for solo operation, CODEOWNER review required only for public-strict operation.
- push ruleset: block `.env`, `.pem`, `.key`, `.DS_Store`, `secrets/**`, oversized files, and overly long paths.

## 日本語

このリポジトリは、別途公開判断をするまでprivateのまま維持します。現在のGitHub planでprivate repository protectionを使えない間は、repo内のgateで守ります。

```sh
mise run release-check
mise run github-protection-status
```

repositoryを公開した後は、通常のcontributionを受ける前に `main` を保護します。

```sh
scripts/apply-main-branch-protection.sh --apply --strict
mise run github-protection-status
```

solo modeのbranch protection設定は次です。

- merge前にpull requestを必須にする。
- `check` status checkを必須にする。
- merge前にbranchを最新化する。
- linear historyを必須にする。
- required reviewは無効のままにする。
- force pushを禁止する。
- branch deletionを禁止する。

public-strict modeでは次も追加します。

- approving reviewを1件必須にする。
- CODEOWNER reviewを必須にする。
- 新しいcommit後に古いreviewを無効化する。

repository owner は、solo maintenanceでCIがgreen、branchが意図したtargetに基づいている、
未解決のlive review threadがない場合にadmin mergeを使えます。これは明示的な運用例外です。
aggregateなCode Review score改善だけを目的にadmin enforcementを有効化しません。

orchestrated agent workでも、solo-mode repositoryがGitHub上のrequired reviewを
強制しない場合でも、human reviewはprocess gateとして残します。CI green、agent loop成功、
verifier summary、sandbox completionはreview材料であり、それ自体はapprovalではありません。
solo ruleset-backed modeでは、pull request、required check、up-to-date branch、
linear history、resolved review threadを維持しつつ、別のapproving reviewは必須にしません。
public-strict modeでは、十分なreviewerがいる場合にapproving review必須化を追加できます。
merge、release判断、policy-sensitive changeのrollback、branch protection変更には
明示的なmaintainer risk reviewが必要です。

rulesets が使える場合は、長期設定として branch protection より rulesets を優先します。

- `main` branch ruleset: pull request必須、`check`必須、up-to-date必須、linear history必須、force push禁止、deletion禁止、solo運用ではapproving review 0件、public-strict運用でのみCODEOWNER review必須。
- push ruleset: `.env`, `.pem`, `.key`, `.DS_Store`, `secrets/**`、過大ファイル、長すぎるpathをblockする。
