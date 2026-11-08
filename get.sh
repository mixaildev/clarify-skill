#!/usr/bin/env bash
# Remote installer:
#   curl -fsSL https://raw.githubusercontent.com/mixaildev/clarify-skill/main/get.sh | bash -s -- <claude|codex|hermes [profile]|all>
set -euo pipefail
REPO="${CLARIFY_REPO:-https://github.com/mixaildev/clarify-skill.git}"
REF="${CLARIFY_REF:-main}"
[ $# -ge 1 ] || { echo "usage: ... | bash -s -- <claude|codex|hermes [profile]|all>" >&2; exit 1; }
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
git clone --quiet --depth 1 --branch "$REF" "$REPO" "$tmp/clarify-skill"
"$tmp/clarify-skill/install.sh" "$@"
