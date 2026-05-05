# smyslokod-starter

Стартовый шаблон для **смысло-кодинга** — методологии, при которой смысл проекта живёт в репозитории отдельно от кода. Бизнес-контекст, цели и правила лежат в markdown-файлах, которые читает Claude Code, прежде чем что-либо менять.

Скачайте, откройте в VS Code, вставьте промпт из [START_HERE.md](./START_HERE.md) — Claude Code сам адаптирует шаблон под вашу идею.

---

## Что это и для кого

**Это:** заготовка `Next.js 15 + TypeScript + Tailwind + shadcn/ui` плюс полная файловая структура «мозга» проекта для работы с Claude Code.

**Для кого:**

- Основатель / соло-разработчик, который хочет, чтобы AI-агент не «кодил вслепую», а действовал в рамках бизнес-контекста.
- Команда, которая хочет фиксировать бизнес-знания в Git, а не в Notion.
- Тот, кто пробовал Cursor / Claude Code и устал объяснять одно и то же в каждой сессии.

**Это НЕ:**

- Готовая SaaS-платформа.
- Аналог create-next-app — здесь почти нет кода, основная ценность в файлах `business/`, `plans/`, `.claude/`.

---

## Быстрый старт

```bash
pnpm install
bash scripts/install-hooks.sh   # один раз: включает защиту main от force-push
pnpm dev                        # http://localhost:3000
```

> Windows: вместо `bash scripts/install-hooks.sh` используйте `pwsh scripts/install-hooks.ps1`.

Затем:

1. Откройте проект в VS Code.
2. Откройте [START_HERE.md](./START_HERE.md).
3. Скопируйте промпт целиком и вставьте в Claude Code.
4. Ответьте на вопросы агента — шаблон адаптируется.

---

## Структура проекта

```
smyslokod-starter/
├── README.md                    # вы здесь
├── START_HERE.md                # главный промпт для запуска
├── CLAUDE.md                    # карта проекта для Claude Code
├── AGENTS.md                    # то же для Codex / других агентов
├── package.json                 # Next.js + shadcn-ready
├── src/                         # код приложения
│   ├── app/                     # App Router
│   └── lib/utils.ts             # cn() для shadcn/ui
├── business/                    # «мозг» проекта
│   ├── INDEX.md                 # карта бизнес-контекста
│   ├── company/                 # о компании, команде, ценностях
│   ├── products/                # продукты, цены
│   ├── audience/                # ЦА, сегменты, возражения, путь
│   ├── goals/                   # цели — год / квартал / месяц / KPI
│   ├── economics/               # юнит-экономика, выручка, расходы
│   ├── marketing/               # каналы, воронка, конкуренты, контент
│   └── assets/                  # бренд-гайдлайны, отзывы, копи-банк
├── plans/                       # один план = одна функция
├── retrospectives/              # итоги после каждой сессии
├── docs/
│   ├── architecture/            # архитектура и решения
│   ├── decisions/               # ADR
│   ├── deployment/              # Vercel / Railway / Amvera
│   ├── prompts/                 # готовые промпты на типовые задачи
│   └── visual-map.md            # три Mermaid-диаграммы
├── .claude/
│   ├── settings.json            # permissions deny
│   ├── rules/                   # правила безопасности, git, UI и т.д.
│   ├── agents/                  # researcher / architect / critic / qa / ux
│   └── skills/                  # навыки, например project-bootstrap
├── .vscode/                     # настройки IDE
├── .devcontainer/               # безопасная контейнерная среда
└── scripts/                     # doctor / preflight (sh + ps1)
```

---

## Workflow смысло-кодинга

```mermaid
flowchart LR
    User[👤 Пользователь]
    VSCode[VS Code]
    Claude[🧠 Claude Code]
    Business[business/]
    Plans[plans/]
    Code[Код src/]
    GH[GitHub]
    Deploy[Vercel / Railway / Amvera]

    User -->|идея| VSCode
    VSCode --> Claude
    Claude -->|читает| Business
    Claude -->|создаёт| Plans
    Plans -->|после критики| Code
    Code -->|commit| GH
    GH --> Deploy
```

1. Идея → промпт в Claude Code.
2. Claude читает `CLAUDE.md` и нужные файлы из `business/`.
3. Создаёт план в `plans/YYYY-MM-DD-название.md`.
4. Запускается субагент `critic` — ищет 10 причин провала.
5. После подтверждения — пишется код.
6. После сессии — запись в `retrospectives/`.

---

## Команды

| Команда                | Что делает                              |
| ---------------------- | --------------------------------------- |
| `pnpm dev`             | dev-сервер на :3000                     |
| `pnpm build`           | прод-сборка                             |
| `pnpm start`           | запуск прод-сборки                      |
| `pnpm lint`            | next lint                               |
| `pnpm typecheck`       | tsc --noEmit                            |
| `pnpm format`          | Prettier write                          |
| `pnpm preflight`       | lint + build (используйте перед push)  |
| `scripts/doctor.ps1`   | диагностика окружения (Windows)         |
| `scripts/doctor.sh`    | диагностика окружения (macOS / Linux)   |

---

## Как адаптировать под свой проект

Способ 1 (рекомендуется):

1. Откройте [START_HERE.md](./START_HERE.md).
2. Вставьте промпт в Claude Code.
3. Ответьте на 5–10 коротких вопросов.
4. Claude обновит `business/`, `CLAUDE.md` и создаст первый план.

Способ 2 (вручную):

1. Перепишите [business/INDEX.md](./business/INDEX.md) и файлы внутри.
2. Перепишите раздел «Что это за проект» в [CLAUDE.md](./CLAUDE.md).
3. Создайте план: `plans/2026-05-03-первая-фича.md` по `plans/TEMPLATE.md`.

---

## Деплой

| Куда        | Когда выбирать                                  | Инструкция                                  |
| ----------- | ----------------------------------------------- | ------------------------------------------- |
| **Vercel**  | простой сайт / лендинг / SaaS без RU-данных     | [docs/deployment/vercel.md](./docs/deployment/vercel.md) |
| **Railway** | международный продукт с бэком и БД              | [docs/deployment/railway.md](./docs/deployment/railway.md) |
| **Amvera**  | российские пользователи, ПДн, ФЗ-152            | [docs/deployment/amvera.md](./docs/deployment/amvera.md) |

Все секреты — только через Environment Variables хостинга, не в репо.

---

## Откат изменений

```bash
git status                    # что изменилось
git restore <файл>            # откатить файл
git reset --soft HEAD~1       # отменить последний коммит, оставить изменения
git revert <hash>             # безопасный откат уже запушенного коммита
```

Подробнее — в [.claude/rules/git.md](./.claude/rules/git.md).

---

## Что дальше

- Прочитайте [CLAUDE.md](./CLAUDE.md) — это карта для агента и для вас.
- Изучите [business/INDEX.md](./business/INDEX.md) — мозг проекта.
- Запустите `pnpm dev` и откройте [START_HERE.md](./START_HERE.md).
