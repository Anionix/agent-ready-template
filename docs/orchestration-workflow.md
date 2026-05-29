# Orchestration Workflow / Orchestration workflow

## English

This repository uses GitHub Issues, GitHub Projects, labels, and pull requests
as a lightweight control plane for agent-assisted work. A downstream project may
choose its own canonical roadmap board; this template does not import the
source repository's project board.

`Status=In Review` is a broad project state. Use labels to show the more exact
review condition:

| Label | Meaning |
|---|---|
| `state:review-gated` | Checks are green, but required review or approval still blocks merge. |
| `state:stacked` | The PR is intentionally based on another feature branch instead of `main`. |
| `state:parent-pr-pending` | The PR should wait for its parent PR or base branch to land first. |

CI success is not approval. Agent-loop completion, verifier summaries, and
sandbox completion are evidence for review, not permission to merge.

Stacked PRs must name their parent PR in the PR body and should use a base
branch that makes the dependency visible. The PR body should also record the
issue, base branch, working branch, workspace boundary, expected changed files,
verification commands, residual risk, approval boundary, and any dependency on
another PR.

Do not change project fields just to express these finer states. Keep `Status`
broad and use labels for orchestration hygiene.

## 日本語

このrepositoryでは、GitHub Issues、GitHub Projects、labels、pull requestsを
agent-assisted work向けの軽量control planeとして使います。downstream projectは自身の
canonical roadmap boardを選べます。このtemplateはsource repositoryのproject boardを取り込みません。

`Status=In Review` は広いproject stateです。より細かいreview状態はlabelで表します。

| Label | Meaning |
|---|---|
| `state:review-gated` | checkはgreenだが、required reviewまたはapprovalがmergeをblockしている。 |
| `state:stacked` | PRが `main` ではなく別feature branchをbaseにしている。 |
| `state:parent-pr-pending` | 親PRまたはbase branchが先にlandするのを待つべきPR。 |

CI successはapprovalではありません。agent-loop completion、verifier summary、sandbox completionは
review材料であり、merge許可そのものではありません。

stacked PRはPR bodyで親PRを明記し、dependencyが見えるbase branchを使います。PR bodyには
issue、base branch、working branch、workspace boundary、expected changed files、
verification commands、residual risk、approval boundary、他PRへのdependencyも記録します。

細かい状態を表すためだけにproject fieldを変更しません。`Status` は広く保ち、
orchestration hygieneはlabelで表します。
