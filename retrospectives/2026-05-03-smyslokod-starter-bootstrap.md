# Ретроспектива: bootstrap шаблона smyslokod-starter

**Дата:** 2026-05-03
**Связан с планом:** [plans/2026-05-03-smyslokod-starter-bootstrap.md](../plans/2026-05-03-smyslokod-starter-bootstrap.md)
**Длительность сессии:** ~30 мин (плюс 16 мин на pnpm install из-за нестабильной сети)

---

## Задача

Собрать с нуля стартовый шаблон `smyslokod-starter`: Next.js + бизнес-мозг + планы + ретроспективы + правила и агенты Claude Code.

## Как решали

1. План реализации записан до старта в `plans/2026-05-03-smyslokod-starter-bootstrap.md` с восемью фазами и блоком «10 причин провала».
2. Next.js 15 + TS + Tailwind 3 собрал руками, без `create-next-app`, чтобы избежать интерактивного CLI на Windows.
3. shadcn/ui подключён конфигом (`components.json`, `lib/utils.ts`, CSS-переменные в `globals.css`), но компоненты не устанавливал — оставил пользователю.
4. `business/` — 22 файла с конкретными вопросами и пометкой «🔲 заполнить при адаптации проекта», без пустых заглушек.
5. `.claude/` — 6 правил, 5 агентов, 1 скилл (`project-bootstrap`), `settings.json` с deny-permissions.
6. `scripts/doctor.ps1` и `preflight.ps1` пришлось переписать на ASCII-вывод после ошибки парсинга PowerShell 5.1 на кириллице без BOM. Шапка в .ps1 на английском, `.sh` остался на русском.
7. `pnpm install` упал на сетевых ошибках при первом запуске, но второй запуск (с retry pnpm-кеша) прошёл за 15 мин 51 сек.
8. `pnpm lint` и `pnpm build` прошли с первого раза без правок.
9. `git init` сделан, но коммит **не делал** — жду явного «да» от пользователя.

## Было

Пустая папка.

## Стало

```
smyslokod-starter/
├── README.md, START_HERE.md, CLAUDE.md, AGENTS.md
├── package.json + lock + рабочий Next.js на :3000
├── business/ (22 файла)
├── plans/ (TEMPLATE + этот план), retrospectives/ (TEMPLATE + эта запись)
├── .claude/ (settings, 6 rules, 5 agents, 1 skill)
├── docs/ (architecture, decisions, deployment x3, prompts x6, visual-map)
├── scripts/ (doctor + preflight, .sh + .ps1)
├── .vscode/, .devcontainer/
└── git инициализирован, коммит не сделан
```

## Решено?

- [x] Да, цель достигнута

## Что запомнить

1. **Windows PowerShell 5.1 без BOM ломает .ps1 с кириллицей.** Решение: писать вывод латиницей или сохранять с BOM. В этом проекте — выбран ASCII-вывод.
2. **`create-next-app` интерактивен и плохо работает в неинтерактивной среде.** Лучше писать конфиги руками — быстрее и предсказуемее.
3. **pnpm install чувствителен к сетевым флапам.** При ECONNRESET — retry помогает, не нужно сразу всё перезапускать.
4. **Tailwind 3 совместимее с шаблонами shadcn/ui** в 2026 чем Tailwind 4.
5. **`next lint` помечен deprecated в Next.js 16** — в v0.2 шаблона стоит мигрировать на ESLint CLI через `npx @next/codemod next-lint-to-eslint-cli`.
6. **`AGENTS.md` совместим с Codex/Cursor** и должен явно ссылаться на `CLAUDE.md` как источник истины — иначе агенты будут расходиться в трактовках.

## Что можно было лучше

- `next-env.d.ts` дополняется самим Next при первом lint/build (добавляет ссылку на `routes.d.ts`). Лучше было сразу сгенерировать его прогоном `next build`, а не писать руками.
- `pnpm-lock.yaml` сейчас в репо — это правильно, но первая попытка `pnpm install` упала, и я мог бы закладывать это в план как отдельный риск с пометкой «retry-loop в CI».

## Следующий шаг

Пользователь:

1. Откройте проект в VS Code, ответьте «yes» на «Recommended extensions».
2. Скопируйте промпт из [START_HERE.md](../START_HERE.md) и вставьте в Claude Code.
3. Когда Claude закончит интервью и обновит `business/` — сделайте первый коммит:
   `git add -A && git commit -m "chore: первичный bootstrap smyslokod-starter"`
4. Подключите свой GitHub-репозиторий (`git remote add origin ...`) и сделайте push **только после** того, как убедились, что в репо нет реальных секретов.
