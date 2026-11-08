---
name: clarify
description: Assess a task (marketing, ads, content, SEO, e-commerce, strategy or anything else) and interview the user with multiple-choice questions (Telegram buttons via the clarify tool) until it is unambiguous, then deliver a Markdown brief. Use for /clarify, "изясни задачата", "задай ми въпроси", "направи бриф", or any vague non-coding task that needs requirements before work starts.
version: 1.0.0
author: digitalid
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Marketing, Brief, Requirements, Interview, Productivity]
---

# Clarify — choice-only task interview → brief

If the user gave no task, ask (clarify tool) what kind of task it is (Маркетинг/реклама · Съдържание/SEO ·
Продукт/е-комерс/стратегия · Друго) and let them describe it via "Other" — the only place a free-text answer is expected.

## How to ask (Hermes — Telegram and other chats)

The `clarify` tool is NOT only for technical confirmations or permission to run commands — in this skill it is the
interview channel. Use it for every question of the interview.

- **Every question = one `clarify` call** with `question` (short, one topic) and `choices` (2–4 strings).
  On Telegram this renders the numbered options plus buttons `1` `2` `3` `4` `✏️ Other`.
- **Never list the options inside `question`** — only in `choices`. Never write the questions as a normal message.
- Choices are full, self-contained strings (they appear as the numbered lines in the message); keep each ≤ ~60
  characters. Recommended one first, ending with " (Препоръчано)" / " (Recommended)".
- **Do not use `multi_select`** — on Telegram one tap resolves the question. Offer realistic combinations as single
  choices ("Meta + Google", "Само Meta", "Meta + Google + TikTok") or ask yes/no per item.
- One question per message means a longer chat — stay tight: the simple/medium/complex targets still apply, skip
  everything already known, and offer "Достатъчно — пиши брифа" as a choice earlier (from about question 5 on).
- Before the first question, send ONE short message with the assessment (domain, complexity, the 6 marks as emoji,
  expected number of questions). Keep it ≤ 8 lines — it is read on a phone.
- If the `clarify` tool is not available (toolset disabled), fall back to one message per question with numbered
  options and "Отговори с цифра (или напиши свой отговор)". Tell the operator once that enabling the `clarify`
  toolset gives buttons.
- If a `clarify` call returns no answer / times out, do not re-ask; record it as an assumption and continue.

## Where the brief goes (Hermes)

1. Write the brief with the file tool to `$HERMES_HOME/briefs/brief-<slug>-<YYYY-MM-DD>.md` (create the folder;
   if `HERMES_HOME` is unknown use `~/.hermes/briefs/`). Use an absolute path.
2. Final reply = a short summary (≤ 10 lines: goal, audience, budget/deadline, KPI, open questions count) followed by
   `MEDIA:/absolute/path/to/brief-....md` on its own line so the file is delivered as a document in the chat.
3. If the platform does not deliver the file, send the brief as text in several messages instead.

Read `templates/brief-template.md` and `references/question-banks.md` from this skill (`skill_view("clarify", "references/question-banks.md")` and `skill_view("clarify", "templates/brief-template.md")`) before the first
question.

