# 08. Scoring Model / 採点モデル

## English

This scoring model communicates maturity.

| Level | Description | Score |
|---|---|---:|
| Lightweight local dev | mise + Compose + AGENTS.md | 94 |
| CI-aligned | CI runs the same checks | 96 |
| Multi-agent-ready | Claude/Cursor/Aider/Copilot adapters | 100 |
| Agent-safe | Optional sandbox / Dev Container policy | 103 |
| Agent-scale | Worktrees, lessons, evals, readiness check | 106-110 |
| Public-template-ready | CI release gate, secret scanners, JSON readiness | 110 |

## 日本語

この採点モデルは成熟度を説明するためのものです。

| レベル | 内容 | 点数 |
|---|---|---:|
| 軽量ローカル開発 | mise + Compose + AGENTS.md | 94 |
| CI一致 | CIが同じcheckを実行 | 96 |
| Multi-agent-ready | Claude/Cursor/Aider/Copilot adapter | 100 |
| Agent-safe | optional sandbox / Dev Container policy | 103 |
| Agent-scale | worktree, lessons, evals, readiness check | 106-110 |
| Public-template-ready | CI release gate, secret scanner, JSON readiness | 110 |

## Why not always 110? / 常に110点にしない理由

A fully loaded environment can become slower, harder to understand, and harder for agents to navigate.

全部入り環境は、遅く、理解しにくく、agentが迷いやすくなることがあります。

## Orchestration readiness / Orchestration readinessの位置づけ

Orchestration readiness is a maturity posture, not a new machine-readable score
contract. It says whether issues, isolated workspaces, worker runtimes,
verifiers, human review, rollback, and audit notes are coordinated well enough
for agent-assisted work.

The required `agent-ready-json` fields remain:

- `status`
- `score`
- `checks`
- `failures`
- `findings`

Do not mix subjective orchestration maturity, benchmark comparisons, or
competitive positioning scores into the JSON readiness score. If this template
adds orchestration categories later, they should be optional fields and must not
break consumers that only read the required fields above.

## Readiness interoperability / Readiness互換性

Checked on 2026-05-16 against `kodustech/agent-readiness`: <https://github.com/kodustech/agent-readiness>.

Kodus-style readiness tools evaluate a repository across multiple pillars,
produce maturity levels or percentages, and can emit JSON for CI integrations.
This template is compatible at the concept level, but it does not import an
external scorer or npm package by default.

Keep `agent-ready-json` stable for local automation:

- Required fields stay `status`, `score`, `checks`, `failures`, and `findings`.
- `score` remains this template's contract score, not a Kodus maturity
  percentage, competitive ranking, or benchmark score.
- New machine-readable fields must be optional. Prefer additive fields such as
  `schema_version` or `categories` if a future consumer needs richer grouping.
- Existing consumers must be able to ignore unknown fields and keep reading the
  required fields above.

For external score interoperability, map concepts in documentation or adapter
code outside the default lane. Do not make `@kodus/agent-readiness`, Factory.ai,
or any other readiness scorer a required dependency of `mise run agent-ready-json`.

オーケストレーションreadinessは成熟度の姿勢であり、新しいmachine-readable score
contractではありません。issue、隔離workspace、worker runtime、verifier、human review、
rollback、audit noteがagent-assisted workに十分な形で束ねられているかを示します。

必須の `agent-ready-json` fields は次のままです。

- `status`
- `score`
- `checks`
- `failures`
- `findings`

主観的なorchestration maturity、benchmark比較、競合positioning scoreをJSON readiness
scoreに混ぜません。将来orchestration categoryを追加する場合もoptional fieldに留め、上記の
required fieldsだけを読むconsumerを壊してはいけません。

Kodus-style readiness toolは、複数pillar、maturity level、percentage、JSON output、CI gateを
持つrepo評価として参考になります。このtemplateは概念レベルでは互換を意識しますが、外部scorerや
npm packageをdefault dependencyにはしません。

`agent-ready-json` はlocal automation向けに安定させます。

- required fields は `status`, `score`, `checks`, `failures`, `findings` のままにする。
- `score` はこのtemplateのcontract scoreであり、Kodus maturity percentage、競合順位、
  benchmark scoreではない。
- machine-readable fieldを追加する場合はoptionalにする。将来 richer grouping が必要なら
  `schema_version` や `categories` のようなadditive fieldに限定する。
- 既存consumerはunknown fieldを無視し、上記required fieldsだけを読み続けられる必要がある。

外部scoreとのinteropは、default laneの外側にあるdocumentationまたはadapter codeで対応します。
`@kodus/agent-readiness`、Factory.ai、その他readiness scorerを `mise run agent-ready-json`
の必須依存にしません。
