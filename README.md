# Clarify — clarify any task with multiple-choice questions, get a brief

**Clarify** is a skill for AI agents (Claude Code, Codex, Hermes on Telegram, ChatGPT) that, **before any work starts**,
assesses the task and asks **multiple-choice questions only** — no "describe your…" prompts — until the task is
unambiguous. It then writes a structured **Markdown brief** that someone else can execute without coming back with
questions.

Built for marketing campaigns and ads (Meta/Google/TikTok), content and SEO, promotions, e-commerce, strategy and any
other non-coding task. Inspired by `flow-next interview`, but adaptive and domain-agnostic.

```
/clarify launch a Black Friday campaign for the online store

📋 Marketing · complex · ~20 questions
Goal 🟡  Audience ❌  Scope ❌  Constraints ❌  KPI ❌  Context 🟡

❓ Main goal of the campaign?
1. Sales (Recommended)
2. New customers
3. Clear excess stock
4. Awareness
[1] [2] [3] [4] [✏️ Other]
```

The agent asks and writes in the user's language — ask in Bulgarian, get Bulgarian questions and a Bulgarian brief.

## How it works

1. **Assess** — task domain (marketing · content/SEO · product/e-commerce/strategy · general) and complexity; six
   dimensions scored ✅/🟡/❌: goal, audience, deliverable & scope, constraints (budget, deadline, brand, legal),
   success criteria, context.
2. **Interview** — choice questions only, 2–4 concrete options (real budgets, channels, dates), the recommended one
   first. Adaptive: simple task 5–8 questions, medium 10–20, complex 20–40. Never asks what is already known.
   "Other" stays available only as an escape hatch.
3. **Stop** — when everything is ✅, or the user picks "Enough — write the brief".
4. **Confirm** — short summary → "Yes, write the brief / Fix something / Add more detail".
5. **Brief** — goal, audience, deliverables & scope, channels, constraints, KPIs, decisions, assumptions, risks, open
   questions, acceptance checklist, next steps.

| Platform | Questions | Brief |
|---|---|---|
| **Claude Code** | `AskUserQuestion` — 1–4 questions at a time, with buttons | `.md` file in the working directory |
| **Codex CLI / App** | `request_user_input` (Plan mode); otherwise numbered options `1A 2C` | `.md` file in the working directory |
| **Hermes (Telegram)** | built-in `clarify` tool — one question per message, buttons `1 2 3 4 ✏️ Other` | summary + `.md` document in the chat |
| **ChatGPT (Custom GPT / Project)** | numbered questions, answer with `1A 2B` | Markdown block to copy |

## Install (one command)

```bash
# Claude Code  →  ~/.claude/skills/clarify      (usage: /clarify <task>)
curl -fsSL https://raw.githubusercontent.com/mixaildev/clarify-skill/main/get.sh | bash -s -- claude

# Codex        →  ~/.codex/skills/clarify       (usage: $clarify <task>)
curl -fsSL https://raw.githubusercontent.com/mixaildev/clarify-skill/main/get.sh | bash -s -- codex

# Hermes — into the profile that runs the Telegram bot (profiles do NOT inherit root skills)
curl -fsSL https://raw.githubusercontent.com/mixaildev/clarify-skill/main/get.sh | bash -s -- hermes <profile>
# …or the root install: bash -s -- hermes

# Everything at once (Claude + Codex + Hermes if ~/.hermes exists)
curl -fsSL https://raw.githubusercontent.com/mixaildev/clarify-skill/main/get.sh | bash -s -- all
```

Or manually:

```bash
git clone https://github.com/mixaildev/clarify-skill.git
cd clarify-skill && ./install.sh hermes <profile>     # claude | codex | hermes [profile] | all
```

To update, run the same command again (the skill folder is replaced as a whole).

### Hermes / Telegram

After installing, restart that profile's gateway (or send `/reset` in the chat). Then in Telegram:
`/clarify <task>` or just "clarify this task: …".

- The `clarify` toolset must be enabled (it is by default). If it is in `disabled_toolsets`, the skill falls back to
  numbered options in plain text.
- Telegram has no multi-select (one tap = one answer), so the skill offers combinations as single options.
- The brief is saved to `$HERMES_HOME/briefs/` and sent as a document in the chat.

### Codex — buttons outside Plan mode (optional)

`request_user_input` is available in **Plan mode** (Shift+Tab). For Default mode:

```toml
# ~/.codex/config.toml
[features]
default_mode_request_user_input = true   # experimental — remove it if it causes problems
```

### ChatGPT

1. ChatGPT → GPTs → **Create** → Configure.
2. **Instructions:** paste [`dist/chatgpt/instructions.md`](dist/chatgpt/instructions.md).
3. **Knowledge:** upload [`question-banks.md`](dist/chatgpt/question-banks.md) and
   [`brief-template.md`](dist/chatgpt/brief-template.md).
4. Optional: enable Code Interpreter to get the brief as a downloadable file.

Also works in a **Project** — instructions in Project instructions, the two files in Project files.

## Layout & editing

```
src/core.md               the method (shared by all platforms)
src/platforms/*.md        frontmatter + "how to ask" per platform
src/question-banks.md     question topics: general · marketing/ads · content/SEO · product/e-commerce · edge cases
src/brief-template.md     brief template
chatgpt/instructions.md   Custom GPT instructions (≤ 8,000 chars)
build.sh                  assembles dist/ (the ready-to-install skills)
install.sh                local install
get.sh                    install from GitHub (curl | bash)
```

Edit only `src/` and `chatgpt/`, run `./build.sh`, and commit together with `dist/`.

## License

MIT
