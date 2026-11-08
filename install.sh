#!/usr/bin/env bash
# Usage:
#   ./install.sh claude                 → ~/.claude/skills/clarify
#   ./install.sh codex                  → ${CODEX_HOME:-~/.codex}/skills/clarify
#   ./install.sh hermes [profile]       → ~/.hermes/skills/productivity/clarify  (or ~/.hermes/profiles/<profile>/skills/productivity/clarify)
#   ./install.sh all                    → claude + codex (+ hermes if ~/.hermes exists)
# Hermes profiles do NOT inherit root skills — install into every profile that runs a bot.
set -euo pipefail
cd "$(dirname "$0")"
./build.sh >/dev/null

put() { # $1 platform, $2 target dir
  rm -rf "$2"; mkdir -p "$(dirname "$2")"; cp -R "dist/$1/clarify" "$2"; echo "installed $1 → $2"
}

case "${1:-}" in
  claude) put claude "$HOME/.claude/skills/clarify" ;;
  codex)  put codex "${CODEX_HOME:-$HOME/.codex}/skills/clarify" ;;
  hermes)
    base="${HERMES_HOME:-$HOME/.hermes}"
    if [ -n "${2:-}" ]; then base="$base/profiles/$2"; [ -d "$base" ] || { echo "no Hermes profile: $base" >&2; exit 1; }; fi
    put hermes "$base/skills/productivity/clarify"
    echo "restart the gateway of that profile (or /reset in the chat) so the skill is picked up" ;;
  all)
    put claude "$HOME/.claude/skills/clarify"
    put codex "${CODEX_HOME:-$HOME/.codex}/skills/clarify"
    [ -d "${HERMES_HOME:-$HOME/.hermes}" ] && put hermes "${HERMES_HOME:-$HOME/.hermes}/skills/productivity/clarify" || true ;;
  *) sed -n '2,8p' "$0"; exit 1 ;;
esac
