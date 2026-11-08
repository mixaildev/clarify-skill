# Clarify — изясни задачата с въпроси с избор, получи бриф

**Clarify** е скил за AI агенти (Claude Code, Codex, Hermes в Telegram, ChatGPT), който **преди да се започне работа**
оценява задачата и задава **само въпроси с избор** — никакви „опиши ми…“ — докато не стане ясна. Накрая пише
структуриран **бриф в Markdown**, по който някой друг може да изпълни задачата, без да пита отново.

Подходящ за маркетинг кампании и реклама (Meta/Google/TikTok), съдържание и SEO, промоции, е-комерс, стратегия и
всякакви други нетехнически задачи. Вдъхновен от `flow-next interview`, но адаптивен и за всички.

```
/clarify пусни Black Friday кампания за онлайн магазина

📋 Маркетинг · сложна · ~20 въпроса
Цел 🟡  Аудитория ❌  Обхват ❌  Ограничения ❌  KPI ❌  Контекст 🟡

❓ Основна цел на кампанията?
1. Продажби (Препоръчано)
2. Нови клиенти
3. Разчистване на наличности
4. Разпознаваемост
[1] [2] [3] [4] [✏️ Other]
```

## Как работи

1. **Оценка** — вид задача (маркетинг · съдържание/SEO · продукт/е-комерс/стратегия · общо) и сложност; 6 измерения
   ✅/🟡/❌: цел, аудитория, обхват, ограничения (бюджет, срок, бранд, правни), критерии за успех, контекст.
2. **Интервю** — само въпроси с избор, 2–4 конкретни опции (реални бюджети, канали, дати), препоръчаната първа.
   Адаптивно: проста задача 5–8 въпроса, средна 10–20, сложна 20–40. Не пита неща, които вече са ясни.
   „Other“ остава само като резервен изход.
3. **Стоп** — когато всичко е ✅ или избереш „Достатъчно — пиши брифа“.
4. **Потвърждение** — кратко резюме → „Да, пиши брифа / Поправи нещо / Още детайли“.
5. **Бриф** — цел, аудитория, резултат и обхват, канали, ограничения, KPI, решения, допускания, рискове, отворени
   въпроси, чеклист „Готово е, когато“, следващи стъпки. На езика, на който е зададена задачата.

| Платформа | Въпросите | Брифът |
|---|---|---|
| **Claude Code** | `AskUserQuestion` — 1–4 въпроса наведнъж с бутони | `.md` файл в текущата папка |
| **Codex CLI / App** | `request_user_input` (Plan mode); иначе номерирани опции `1A 2C` | `.md` файл в текущата папка |
| **Hermes (Telegram)** | вграденият `clarify` — по 1 въпрос, бутони `1 2 3 4 ✏️ Other` | резюме + `.md` документ в чата |
| **ChatGPT (Custom GPT / Project)** | номерирани въпроси, отговаряш с `1A 2B` | Markdown блок за копиране |

## Инсталация (една команда)

```bash
# Claude Code  →  ~/.claude/skills/clarify      (ползване: /clarify <задача>)
curl -fsSL https://raw.githubusercontent.com/mihailvaleriev-prog/clarify-skill/main/get.sh | bash -s -- claude

# Codex        →  ~/.codex/skills/clarify       (ползване: $clarify <задача>)
curl -fsSL https://raw.githubusercontent.com/mihailvaleriev-prog/clarify-skill/main/get.sh | bash -s -- codex

# Hermes — в профила, който обслужва Telegram бота (профилите НЕ наследяват общите скилове)
curl -fsSL https://raw.githubusercontent.com/mihailvaleriev-prog/clarify-skill/main/get.sh | bash -s -- hermes <профил>
# …или общо: bash -s -- hermes

# Всичко наведнъж (Claude + Codex + Hermes, ако има ~/.hermes)
curl -fsSL https://raw.githubusercontent.com/mihailvaleriev-prog/clarify-skill/main/get.sh | bash -s -- all
```

Или ръчно:

```bash
git clone https://github.com/mihailvaleriev-prog/clarify-skill.git
cd clarify-skill && ./install.sh hermes <профил>     # claude | codex | hermes [профил] | all
```

Обновяване = същата команда отново (папката на скила се подменя изцяло).

### Hermes / Telegram

След инсталацията рестартирай gateway-а на профила (или `/reset` в чата). После в Telegram:
`/clarify <задача>` или просто „изясни задачата: …“.

- Toolset-ът `clarify` трябва да е включен (по подразбиране е). Ако е в `disabled_toolsets`, скилът минава на
  номерирани опции в текст.
- В Telegram няма множествен избор (едно натискане = отговор) — скилът предлага комбинации като отделни опции.
- Брифът се записва в `$HERMES_HOME/briefs/` и се праща като документ в чата.

### Codex — бутони и извън Plan mode (по желание)

`request_user_input` е наличен в **Plan mode** (Shift+Tab). За обикновения режим:

```toml
# ~/.codex/config.toml
[features]
default_mode_request_user_input = true   # експериментално — махни го, ако създава проблеми
```

### ChatGPT

1. ChatGPT → GPTs → **Create** → Configure.
2. **Instructions:** съдържанието на [`dist/chatgpt/instructions.md`](dist/chatgpt/instructions.md).
3. **Knowledge:** качи [`question-banks.md`](dist/chatgpt/question-banks.md) и
   [`brief-template.md`](dist/chatgpt/brief-template.md).
4. По желание: Code Interpreter (за брифа като файл за сваляне).

Работи и в **Project** — инструкциите в Project instructions, двата файла в Project files.

## Структура и промени

```
src/core.md               методологията (обща за всички платформи)
src/platforms/*.md        frontmatter + „как да пита“ за всяка платформа
src/question-banks.md     въпросни блокове: общи · маркетинг/реклама · съдържание/SEO · продукт/е-комерс · edge cases
src/brief-template.md     шаблон на брифа
chatgpt/instructions.md   инструкции за Custom GPT (≤ 8000 знака)
build.sh                  сглобява dist/ (готовите скилове)
install.sh                локална инсталация
get.sh                    инсталация от GitHub (curl | bash)
```

Редактирай само `src/` и `chatgpt/`, пусни `./build.sh` и commit-ни заедно с `dist/`.

## Лиценз

MIT
