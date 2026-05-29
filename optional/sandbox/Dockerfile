FROM ubuntu:24.04@sha256:c4a8d5503dfb2a3eb8ab5f807da5bc69a85730fb49b5cfca2330194ebcc41c7b

RUN apt-get update   && apt-get install -y --no-install-recommends     ca-certificates curl git bash jq   && rm -rf /var/lib/apt/lists/*

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

# This image is intentionally minimal.
# このimageは意図的に最小構成です。
