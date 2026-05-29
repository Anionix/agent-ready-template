# Architecture

This repository is a template contract, not an application starter.

## Layers

1. **Repository contract**: `AGENTS.md`, `CONVENTIONS.md`, `README.md`, `mise.toml`, and CI define the shared commands for humans and AI coding agents.
2. **Validation gates**: `mise run check`, `mise run agent-ready-json`, `mise run public-release-check`, secret scanning, pin auditing, CodeQL advanced workflow, and OpenSSF Scorecard provide release and safety evidence.
3. **Optional profiles**: `profiles/` documents sandbox, microVM, cloud, embedded-runtime, and OpenClaw-adjacent profiles without making them default dependencies.
4. **Governance and release process**: contribution, conduct, maintainer, release, and OpenSSF evidence docs explain how changes are reviewed and released.

## Data and runtime model

The template stores only repository files and documentation. It does not run a production service, store user data, or require a bundled worker runtime. Downstream projects decide whether to adopt Docker Compose, Dev Containers, microVMs, cloud sandboxes, OpenClaw, or agent orchestration runtimes.

## Security boundaries

Security evidence is split by purpose:

- CI and local checks verify the template contract.
- Secret scanning and public-release checks protect publication safety.
- Sandbox profiles document selectable isolation patterns.
- CodeQL and ShellCheck provide static analysis for supported code surfaces.
- Fuzzing is optional and scoped to the compatibility harness.

No single profile, scanner, or agent runtime is described as a complete security boundary.
