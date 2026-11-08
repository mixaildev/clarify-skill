---
name: clarify
description: Assess a task (marketing, ads, content, SEO, e-commerce, strategy or anything else) and interview the user with multiple-choice questions only until it is unambiguous, then write a Markdown brief. Use when the user says "$clarify", "clarify", "изясни задачата", "задай ми въпроси", "направи бриф", or gives a vague non-coding task that needs requirements before work starts.
---

# Clarify — choice-only task interview → brief

If the user gave no task, ask what kind of task it is (Маркетинг/реклама · Съдържание/SEO · Продукт/е-комерс/стратегия ·
Друго) and let them describe it — this is the only place a free-text answer is expected.

## How to ask (Codex)

- **If the `request_user_input` tool is available this turn, every question goes through it.** 1–3 questions per call,
  2–4 mutually exclusive options each, recommended option first with "(Recommended)" / "(Препоръчано)" in the label,
  short `header`, nuance in the option `description`. The UI adds a free-text "Other" by itself.
- It is available in **Plan mode** (Shift+Tab in the CLI / the mode picker in the app), and in Default mode only when
  the feature `default_mode_request_user_input` is on. If it is NOT available, say once:
  "За бутони с избор превключи в Plan mode (Shift+Tab)." — then continue with the fallback below rather than stopping.
- **Fallback (no tool):** one message per round with 1–3 numbered questions, lettered options, the recommended one
  marked, and the line "Отговори с напр. `1A 2C` (или напиши своя отговор)". Example:

  ```
  1. Основна цел на кампанията?
     A) Продажби (Препоръчано)  B) Лийдове  C) Разпознаваемост  D) Трафик
  2. Бюджет за целия период?
     A) до 500 €  B) 500–2 000 € (Препоръчано)  C) 2 000–5 000 €  D) над 5 000 €
  ```
- No multi-select in the tool: offer realistic combinations as single options ("Meta + Google", "Само Meta").
- If `request_user_input` returns no answer, do not re-ask the same question; record it as an assumption and move on.

## Where the brief goes (Codex)

Write `brief-<slug>-<YYYY-MM-DD>.md` in the current working directory (or a path the user named) and print the path.
Read `templates/brief-template.md` and `references/question-banks.md` next to this file before the first question.

