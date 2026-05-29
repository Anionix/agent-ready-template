# 07. GitHub Template Guide / GitHubテンプレート化ガイド

## English

## Create the template repository

1. Use the repository root as the template payload.
2. Add optional files from `optional/` only if needed.
3. Run `mise install`.
4. Run `mise run release-check`.
5. Commit and push.
6. Open repository settings.
7. Enable “Template repository”.
8. Protect `main` with pull requests and the `check` required status check.
9. Run `mise run github-protection-status`.
10. Use “Use this template” to create project repositories.

## Public release checklist

- Keep GitHub Actions permissions minimal, normally `contents: read`.
- Keep external GitHub Actions pinned to full commit SHAs.
- Require pull requests before merging to `main`.
- Require the `check` status check before merging.
- Disable force pushes and branch deletion on `main`.
- Publish from a checked clean-history release branch when changing visibility.
- After public release, run `scripts/apply-main-branch-protection.sh --apply --strict` when accepting outside contributions.
- For solo/private operation, `scripts/apply-main-branch-protection.sh --apply` keeps reviews optional.
- When rulesets are available, prefer rulesets for layered branch and push protection.

## Repository naming

Recommended names:

- `agent-ready-repo-template`
- `multi-agent-repo-template`
- `agentic-dev-template`
- `ai-agent-repo-template`

Recommended: `agent-ready-repo-template`

## 日本語

## テンプレートリポジトリを作る

1. repository rootをそのままtemplate payloadとして使う。
2. 必要な場合だけ `optional/` から追加する。
3. `mise install` を実行する。
4. `mise run release-check` を実行する。
5. commitしてpushする。
6. repository settingsを開く。
7. “Template repository” を有効化する。
8. `main` をpull request必須と `check` required status check で保護する。
9. `mise run github-protection-status` を実行する。
10. “Use this template” からプロジェクトrepoを作る。

## 公開前チェックリスト

- GitHub Actions permissionsは最小化し、通常は `contents: read` にする。
- 外部GitHub Actionsはfull commit SHAにpinする。
- `main` へのmerge前にpull requestを必須にする。
- merge前に `check` status checkを必須にする。
- `main` のforce pushとbranch deletionを禁止する。
- visibility変更時は、検査済みのclean-history release branchから公開する。
- 外部contributionを受ける公開後は `scripts/apply-main-branch-protection.sh --apply --strict` を実行する。
- 個人/private運用では `scripts/apply-main-branch-protection.sh --apply` でreview任意のsolo modeを使える。
- rulesetsが使える場合は、layered branch/push protectionとしてrulesetsを優先する。

## リポジトリ名

おすすめ:

- `agent-ready-repo-template`
- `multi-agent-repo-template`
- `agentic-dev-template`
- `ai-agent-repo-template`

最もおすすめ: `agent-ready-repo-template`
