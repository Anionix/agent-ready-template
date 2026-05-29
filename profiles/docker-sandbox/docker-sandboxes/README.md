# Docker Sandboxes Optional Profile Note

Docker Sandboxes is a future optional Docker-native profile direction for agent work. This repository does not install Docker Sandboxes, require Docker Desktop features, or replace the existing Compose-based checks.

## Fit

Use this note when a team wants Docker-native agent ergonomics with a stronger boundary than a normal host Docker workflow. Validate the current Docker documentation before adoption, especially product availability, host prerequisites, filesystem behavior, network defaults, and how the agent accesses Docker tooling inside the sandbox.

## Safety posture

- Do not require Docker Sandboxes in CI.
- Do not mount the host Docker socket into untrusted agent work.
- Keep workspace mounts narrow and task-specific.
- Treat daemon, filesystem, and network separation as implementation details that must be checked against the current Docker release.
- Avoid claiming complete escape prevention or production hardening without validating the exact setup.

## Reference

- https://docs.docker.com/ai/sandboxes/

## 日本語

Docker Sandboxesは、agent作業向けの将来の任意Docker-native profile候補です。このrepositoryはDocker Sandboxesをinstallせず、Docker Desktop固有機能を必須化せず、既存のCompose-based checkを置き換えません。

- Docker-nativeな操作感が必要で、通常のhost Docker workflowより強い境界を検討したい場合に評価します。
- CIでDocker Sandboxesを必須にしません。
- untrusted agent作業へhost Docker socketをmountしません。
- workspace mountはtaskに必要な最小範囲にします。
- daemon、filesystem、network separationの実態は、その時点のDocker releaseとhost setupで確認します。
