FROM mcr.microsoft.com/devcontainers/base:ubuntu@sha256:7ee7da33a68d997971660d91ecc8372e55a38a777c3c6bd6808daf91928052db

RUN apt-get update   && apt-get install -y --no-install-recommends curl git ca-certificates   && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG MISE_VERSION=v2026.5.9
ARG MISE_SHA256=66783e315538db21dcc117384dd31662c29ab8b45f0e6d24e8bc174cd419f212
RUN curl -fsSL "https://github.com/jdx/mise/releases/download/${MISE_VERSION}/mise-${MISE_VERSION}-linux-x64.tar.gz" -o /tmp/mise.tar.gz \
  && echo "${MISE_SHA256}  /tmp/mise.tar.gz" | sha256sum -c - \
  && tar -xzf /tmp/mise.tar.gz -C /tmp \
  && mkdir -p /root/.local/bin \
  && install -m 0755 /tmp/mise/bin/mise /root/.local/bin/mise \
  && rm -rf /tmp/mise /tmp/mise.tar.gz
ENV PATH="/root/.local/bin:${PATH}"

WORKDIR /workspace
