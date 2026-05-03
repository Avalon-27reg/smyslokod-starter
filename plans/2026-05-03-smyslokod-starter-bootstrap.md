# План: bootstrap шаблона smyslokod-starter

**Дата:** 2026-05-03
**Автор:** Claude Code (Opus 4.7)
**Статус:** done
**Тип:** одна функция — собрать готовый стартовый шаблон

---

## 1. Цель

Создать GitHub-ready шаблон `smyslokod-starter`, который пользователь скачивает, открывает в VS Code, вставляет промпт из `START_HERE.md` в Claude Code и получает адаптированный под свою идею проект.

## 2. Контекст

- Папка пустая.
- Node 24, pnpm 10, git 2.54 — на месте.
- Платформа Windows 11, есть оба скрипта (`.sh` и `.ps1`).
- Стек: Next.js 15 + TypeScript 5 + Tailwind 3 + shadcn/ui-ready + ESLint + Prettier + pnpm.

## 3. Дизайн решений

**Next.js 15 + Tailwind 3 (а не 4):**
- Tailwind 3 — самый совместимый с экосистемой shadcn/ui и большинством туториалов.
- Tailwind 4 пока ломает много инструкций в интернете, что плохо для шаблона «для начинающих смыслокодеров».

**App Router**, потому что это default Next.js 15.

**shadcn/ui — конфигурация без установки компонентов.** Добавляю `components.json`, `lib/utils.ts`, базовые CSS-переменные. Пользователь сам ставит компоненты через `pnpm dlx shadcn@latest add button`.

**pnpm-lock.yaml** генерируется автоматически после `pnpm install`. Я не пишу его руками.

**Memory-схема:**
- `business/` — мозг проекта, читается выборочно.
- `plans/` — текущая работа.
- `retrospectives/` — итоги.
- `.claude/rules/` — правила для агента.
- `.claude/agents/` — субагенты.
- `.claude/skills/` — скиллы.

## 4. Фазы

### Фаза 1: Next.js скелет [x]
- [x] `package.json` со скриптами dev/build/lint/format
- [x] `tsconfig.json`, `next.config.ts`, `next-env.d.ts`
- [x] `tailwind.config.ts`, `postcss.config.mjs`, `globals.css`
- [x] `eslint.config.mjs`, `.prettierrc`, `.prettierignore`
- [x] `src/app/layout.tsx`, `src/app/page.tsx`
- [x] `src/lib/utils.ts`, `components.json` (shadcn-ready)
- [x] `.gitignore`, `.env.example`

### Фаза 2: Корневые документы [x]
- [x] `README.md` (cockpit)
- [x] `START_HERE.md` (главный промпт)
- [x] `CLAUDE.md` (≤ 200 строк)
- [x] `AGENTS.md` (синхронизирован)

### Фаза 3: Бизнес-мозг [x]
- [x] `business/INDEX.md`
- [x] 22 файла бизнес-контекста с шаблонными вопросами

### Фаза 4: Планы и ретроспективы [x]
- [x] `plans/README.md`, `plans/TEMPLATE.md`
- [x] `retrospectives/README.md`, `retrospectives/TEMPLATE.md`

### Фаза 5: .claude/ конфиг [x]
- [x] `.claude/settings.json` с deny-permissions
- [x] 6 файлов в `rules/`
- [x] 5 агентов в `agents/`
- [x] `skills/README.md` и `skills/project-bootstrap/SKILL.md`

### Фаза 6: docs и скрипты [x]
- [x] `docs/architecture/overview.md`
- [x] `docs/decisions/README.md`
- [x] `docs/visual-map.md` с тремя Mermaid-диаграммами
- [x] `docs/deployment/{vercel,railway,amvera}.md`
- [x] `docs/prompts/*.md` — 6 промптов
- [x] `scripts/{doctor,preflight}.{sh,ps1}`

### Фаза 7: VS Code и devcontainer [x]
- [x] `.vscode/{settings,extensions,tasks}.json`
- [x] `.devcontainer/devcontainer.json`

### Фаза 8: Проверка [x]
- [x] `pnpm install`
- [x] `pnpm lint`
- [x] `pnpm build`
- [x] `scripts/doctor`
- [x] Подготовить git init + первый коммит (без push)

## 5. 10 причин провала

1. **Tailwind v4 vs v3.** Если поставить v4 — ломаются туториалы shadcn/ui. → Решение: фиксирую v3.4.x.
2. **Next.js create-next-app зависает на Windows.** Интерактивный CLI плохо работает в неинтерактивной shell. → Решение: пишу файлы руками, не запускаю create-next-app.
3. **pnpm install падает из-за корпоративного прокси.** → Решение: документирую в README и doctor.sh, не блокирую сборку.
4. **`.claude/settings.json` deny-формат изменился между версиями.** → Решение: использую формат `permissions.deny` (актуальный на 2025-2026), фиксирую версию в комментарии README.
5. **devcontainer.json не подхватывается на Windows без Docker Desktop.** → Решение: делаю его опциональным, в README отмечаю требования.
6. **PowerShell скрипты упадут из-за политики ExecutionPolicy.** → Решение: добавляю инструкцию в README + использую совместимый синтаксис.
7. **shadcn/ui требует CSS-переменные в globals.css.** → Решение: добавляю их в стартовый globals.css.
8. **ESLint 9 flat-config несовместим со старыми плагинами.** → Решение: использую `eslint-config-next` который сам обрабатывает конфиг.
9. **Файлы business/* выглядят как заглушки и пользователь не понимает что писать.** → Решение: каждый файл содержит конкретные вопросы и пример формата.
10. **Mermaid-диаграммы не рендерятся в дефолтном markdown viewer.** → Решение: добавляю расширение Mermaid в `.vscode/extensions.json`.

## 6. Критика плана

- Сборка зависит от сети (`pnpm install`). Если сети нет — план падает. **Митигация:** фиксирую факт в финальном отчёте.
- Шаблон ориентирован на русскоязычного пользователя. Нужно явно отметить это в README.
- Нет реального тест-фреймворка (Vitest/Playwright). **Решение для v0.1:** не добавляю, оставляю как пункт v0.2.

## 7. Итог

Пользователь получает:
- запускаемый Next.js + TS + Tailwind проект,
- полный «мозг» проекта (business/, CLAUDE.md, AGENTS.md),
- готовые планы/ретроспективы/правила/агенты/скиллы для Claude Code,
- два пути запуска: `pnpm dev` локально + промпт из `START_HERE.md` для адаптации,
- проверки `doctor` и `preflight` для CI и локалки.
