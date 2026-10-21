# CLAUDE.md - карта проекта

> Claude Code читает этот файл первым в каждой сессии. Здесь только карта: что за проект, на чём он сделан, где что лежит. Процесс работы подключается строкой ниже - её не удаляй: без неё Claude Code не загрузит процесс. Правила по темам Claude Code сам подгружает из `.claude/rules/`.

@docs/workflow.md

## 1. Что это за проект

`smyslokod-starter` - стартовый шаблон для смысло-кодинга: смысл проекта живёт в файлах репозитория, а код вырастает из него.

Пока этот раздел описывает шаблон, проект только что развёрнут. На первое сообщение пользователя выбери вход по разделу 1 процесса («Старт: от того, что уже есть») и предложи ближайший полезный шаг. После адаптации здесь один абзац: что за проект и для кого. Подробности - в `business/INDEX.md`.

## 2. Стек и команды

Шаблон стек-агностичный: язык и фреймворк выбираются на старте. После выбора здесь записаны:

- стек одной строкой; обоснования - в `docs/architecture/overview.md`;
- команды: установка, запуск, lint, typecheck, тесты, сборка;
- куда деплоится (инструкции для Vercel, Railway, Amvera - в `docs/deployment/`).

## 3. Структура репозитория

```
business/INDEX.md       # ядро бизнес-контекста; разделы появляются по мере данных
templates/business/     # формы: ядро INDEX.md и 26 разделов в 7 блоках
CONTEXT.md              # словарь терминов предметной области
plans/                  # планы результатов с checkpoint
retrospectives/         # ретроспективы
docs/workflow.md        # процесс работы для Claude Code и Codex
docs/architecture/      # архитектура проекта; решения - в docs/decisions/
docs/prompts/           # готовые промпты, карта - INDEX.md
docs/deployment/        # инструкции по платформам деплоя
.claude/rules/          # правила по темам
.claude/agents/         # роли: researcher, architect, critic, judge, qa-tester, ux-designer
.claude/skills/         # скиллы: project-bootstrap, diagnose, tdd, grill-me
.githooks/              # pre-push (защита main), pre-commit (блок секретов)
scripts/                # doctor, install-hooks (sh + ps1)
```

Код приложения (`src/`, `package.json` и т.п.) появляется после выбора стека.

## 4. Правила

| Файл | О чём |
|---|---|
| `.claude/rules/security.md` | секреты и `.env`, опасные команды, скиллы и MCP, приватность `business/` |
| `.claude/rules/git.md` | коммиты, push, откат, хуки |
| `.claude/rules/coding-principles.md` | 4 принципа кодинга и Anti-Rationalization |
| `.claude/rules/business-context.md` | какие файлы `business/` под какую задачу, когда создавать раздел |
| `.claude/rules/ui-design.md` | интерфейс и вёрстка; подгружается при работе с файлами интерфейса |
| `.claude/rules/deployment.md` | платформы и порядок деплоя; подгружается при работе с файлами деплоя |

## 5. Язык

Все ответы пользователю - на русском. Имена файлов - латиницей, kebab-case.
