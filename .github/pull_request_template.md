## Summary / 概要

- 

## Changed files / 変更ファイル

- 

## Agent handoff / Agent引き渡し

- Issue:
- Base branch:
- Working branch:
- Workspace boundary:
- Expected changed files:
- Verification commands:
- Residual risk:
- Approval boundary:
- Stacked on / depends on:

## Commands run / 実行コマンド

- [ ] `mise run doctor`
- [ ] `mise run install`
- [ ] `mise run workflow-lint`
- [ ] `mise run dockerfile-lint`
- [ ] `mise run shellcheck`
- [ ] `mise run fuzz`
- [ ] `mise run services`
- [ ] `mise run check`
- [ ] `mise run agent-ready`
- [ ] `mise run agent-ready-json`
- [ ] `mise run public-release-check`
- [ ] `mise run secret-scan`
- [ ] `mise run release-check`

## Agent safety / Agent安全性

- [ ] No secrets were read or modified.
- [ ] No destructive database commands were run outside local development.
- [ ] No local machine paths or public-incompatible markers were introduced.
- [ ] Secret scanners passed or any false positives are documented.
- [ ] Service readiness changes were checked with Docker Compose.
- [ ] Remaining risks are documented.

- [ ] secretを読んだり変更したりしていない。
- [ ] local development以外で破壊的DBコマンドを実行していない。
- [ ] ローカルマシンpathや公開非互換markerを追加していない。
- [ ] secret scannerが通った、またはfalse positiveを記載した。
- [ ] service readiness変更をDocker Composeで確認した。
- [ ] 残リスクを記載した。
