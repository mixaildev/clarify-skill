---
name: clarify
description: Assess a task (marketing, ads, content, SEO, e-commerce, strategy or anything else) and interview the user with multiple-choice questions only until it is unambiguous, then write a Markdown brief. Use when the user runs /clarify, asks to "clarify", "изясни задачата", "задай ми въпроси", "направи бриф", or gives a vague non-coding task that needs requirements before work starts.
---

# Clarify — choice-only task interview → brief

Task to clarify: $ARGUMENTS
If empty, ask with ONE AskUserQuestion what kind of task it is (Marketing/ads · Content/SEO · Product/e-commerce/strategy · Other) and then let the user describe it via "Other" — this is the only place a free-text answer is expected.

## How to ask (Claude Code)

- **Every question goes through the `AskUserQuestion` tool.** Never write questions or options as plain text.
- 1–4 questions per call (group related ones, typically 2–4), 2–4 options each, `header` ≤ 12 characters.
- Option `label` short (1–5 words); put the nuance/trade-off in `description`.
- Recommended option first, label ends with "(Recommended)" (translated into the user's language).
- `multiSelect: true` when choices are genuinely combinable (channels, formats, assets).
- "Other" is added automatically — do not add your own.
- Use `preview` only to compare concrete artifacts (two headline variants, two layouts, two e-mail subject lines).

## Where the brief goes (Claude Code)

Save to the current working directory as `brief-<slug>-<YYYY-MM-DD>.md` (or a path the user named) with the Write
tool, and print the path. Templates: `templates/brief-template.md` and `references/question-banks.md` next to this file — read both before
the first question.

