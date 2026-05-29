# Security Policy / セキュリティポリシー

## English

This repository is designed to be safe to prepare for public release.

Before changing repository visibility or publishing a clean-history release, run:

```sh
mise run release-check
mise run github-protection-status
```

Do not commit real secrets, local machine paths, `.env` files, SSH keys, cloud credentials, production credentials, or private key material. Use `.env.example` and `.env.test.example` only for documented placeholders.

AI coding agents should work with repository-scoped access by default. Full filesystem or full account access is an exception for tightly bounded maintenance work, and any such work must be followed by the public release readiness check.

After public release, protect `main` with pull requests, the `check` required status check, up-to-date branches, linear history, and blocked force pushes and deletion. When GitHub rulesets are available, prefer rulesets for long-term branch and push protection.

Report security issues through a private GitHub security advisory:

https://github.com/Anionix/agent-ready-template/security/advisories/new

Do not disclose exploitable details in public issues, discussions, pull requests, or social channels before the owner has acknowledged the report.

Expected response posture:

- Initial acknowledgement target: within 7 calendar days.
- Status update target: within 30 calendar days for confirmed reports.
- Coordinated disclosure target: after a fix is available, or after 90 calendar days if no fix is possible.

These timelines are targets for a public template repository, not a guarantee of a production incident response SLA.

## 日本語

このリポジトリは、公開準備を安全に行えることを目的にしています。

repository visibility の変更や clean history release の公開前には、次を実行します。

```sh
mise run release-check
mise run github-protection-status
```

本物のsecret、ローカルマシンのpath、`.env` 実体、SSH鍵、cloud credentials、本番credential、private key materialをcommitしてはいけません。`.env.example` と `.env.test.example` は、placeholderを文書化する用途だけに使います。

AI coding agent は、通常 repository-scoped access で作業します。full filesystem access や full account access は、範囲を限定した保守作業だけの例外です。その場合も、作業後に public release readiness check を通します。

公開後は、pull request必須、`check` required status check、branch最新化、linear history、force push禁止、deletion禁止で `main` を保護します。GitHub rulesetsが使える場合は、長期的なbranch/push protectionとしてrulesetsを優先します。

security issue は private GitHub security advisory で報告してください。

https://github.com/Anionix/agent-ready-template/security/advisories/new

owner が確認する前に、悪用可能な詳細を public issue、discussion、pull request、social channel に書かないでください。

応答目安は次です。

- 初回確認: 7 calendar days 以内を目標にします。
- 確認済み報告の進捗更新: 30 calendar days 以内を目標にします。
- coordinated disclosure: fix公開後、またはfixできない場合は90 calendar days後を目標にします。

これらは public template repository 向けの目安であり、本番incident response SLAではありません。
