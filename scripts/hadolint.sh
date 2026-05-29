#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
version="2.14.0"

case "$(uname -s):$(uname -m)" in
  Linux:x86_64)
    filename="hadolint-linux-x86_64"
    sha256_expected="6bf226944684f56c84dd014e8b979d27425c0148f61b3bd99bcc6f39e9dc5a47"
    ;;
  Linux:aarch64 | Linux:arm64)
    filename="hadolint-linux-arm64"
    sha256_expected="331f1d3511b84a4f1e3d18d52fec284723e4019552f4f47b19322a53ce9a40ed"
    ;;
  Darwin:*)
    # Upstream hadolint release assets are Linux-only for v2.14.0. Keep macOS
    # local checks working through mise while CI and coding agents use the
    # direct Linux download path below.
    exec mise x "hadolint@${version}" -- hadolint "$@"
    ;;
  *)
    echo "unsupported hadolint platform: $(uname -s) $(uname -m)" >&2
    exit 1
    ;;
esac

url="https://github.com/hadolint/hadolint/releases/download/v${version}/${filename}"
cache_dir="${root_dir}/.cache/tools/hadolint/v${version}"
bin_path="${cache_dir}/hadolint"

if [ ! -x "${bin_path}" ]; then
  mkdir -p "${cache_dir}"
  tmp_path="$(mktemp)"
  trap 'rm -f "${tmp_path}"' EXIT

  curl -fsSL -o "${tmp_path}" -L "${url}"

  if command -v sha256sum >/dev/null 2>&1; then
    sha256_actual="$(sha256sum "${tmp_path}" | awk '{print $1}')"
  else
    sha256_actual="$(shasum -a 256 "${tmp_path}" | awk '{print $1}')"
  fi
  if [ "${sha256_actual}" != "${sha256_expected}" ]; then
    echo "hadolint sha256 mismatch: expected ${sha256_expected}, got ${sha256_actual}" >&2
    exit 1
  fi

  chmod 0755 "${tmp_path}"
  mv -f "${tmp_path}" "${bin_path}"
  trap - EXIT
fi

exec "${bin_path}" "$@"
