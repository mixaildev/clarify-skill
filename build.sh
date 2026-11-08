#!/usr/bin/env bash
# Builds dist/<platform>/clarify/ from src/. Single source of truth = src/core.md + src/platforms/<platform>.md.
set -euo pipefail
cd "$(dirname "$0")"
rm -rf dist
for p in claude codex hermes; do
  d="dist/$p/clarify"
  mkdir -p "$d/references" "$d/templates"
  { cat "src/platforms/$p.md"; cat src/core.md; } > "$d/SKILL.md"
  cp src/question-banks.md "$d/references/"
  cp src/brief-template.md "$d/templates/"
done
# ChatGPT: instructions are hand-written (8 000-char limit); knowledge files are copied.
mkdir -p dist/chatgpt
cp chatgpt/instructions.md src/question-banks.md src/brief-template.md dist/chatgpt/
chars=$(wc -m < chatgpt/instructions.md | tr -d ' ')
[ "$chars" -le 8000 ] || { echo "chatgpt/instructions.md is $chars chars (> 8000)" >&2; exit 1; }
echo "built: dist/{claude,codex,hermes}/clarify, dist/chatgpt (instructions $chars/8000 chars)"
