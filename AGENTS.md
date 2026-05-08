# AGENTS.md — карта проекта для агентов (Codex / Cursor / прочие)

> Этот файл существует для совместимости с агентскими системами, которые ищут `AGENTS.md`.
> **Основной файл правил для этого репозитория — [`CLAUDE.md`](./CLAUDE.md).** Если вы агент, отличный от Claude Code, прочитайте сначала этот файл, потом `CLAUDE.md`.

## Главное в одном экране

1. Это шаблон для смысло-кодинга. Бизнес-смысл живёт в `business/`, текущая работа — в `plans/`, итоги — в `retrospectives/`.
2. Стек **не зашит**. Шаблон стек-агностичен. Стек выбирается на старте через скилл `project-bootstrap` или явно пользователем. Если в `CLAUDE.md` раздел «2. Стек» ещё указывает на «не переписан» — значит проект только что развёрнут.
3. Перед любой задачей читай `CLAUDE.md` и нужные файлы из `business/INDEX.md` (карта). Не грузи business/ целиком.
4. На крупную фичу — план в `plans/YYYY-MM-DD-имя.md` по `plans/TEMPLATE.md`. **Один план = одна функция.** Обязательны: «10 причин провала», Challenge Loop, Self-Audit.
5. В конце сессии — `retrospectives/YYYY-MM-DD-имя.md` по `retrospectives/TEMPLATE.md`.
6. Все ответы пользователю — на русском. Имена файлов — латиницей, kebab-case.
7. 4 принципа кодинга (`.claude/rules/coding-principles.md`) применяются всегда. **Никаких отговорок** «out of scope», «pre-existing», «доделаем потом» при незавершённой работе.

## Жёсткие запреты

- Не читать `.env` / `.env.*` целиком. Не печатать секреты в чат/код/логи.
- Не хардкодить секреты, токены, ключи. Только через `process.env`.
- Не запускать `git push`, `git push --force`, `git reset --hard`, `git rebase`, `rm -rf` без явного «да» пользователя.
- Не использовать `git add -A` без необходимости.
- Не делать «generic AI-design» интерфейса. Сначала референсы и `business/assets/brand-guidelines.md`.

## Куда смотреть

| Тема                       | Файл                                    |
| -------------------------- | --------------------------------------- |
| Карта проекта              | [CLAUDE.md](./CLAUDE.md)                |
| Карта бизнес-контекста     | [business/INDEX.md](./business/INDEX.md) |
| Шаблон плана фичи          | [plans/TEMPLATE.md](./plans/TEMPLATE.md) |
| Шаблон ретроспективы       | [retrospectives/TEMPLATE.md](./retrospectives/TEMPLATE.md) |
| Принципы кодинга           | [.claude/rules/coding-principles.md](./.claude/rules/coding-principles.md) |
| Правила безопасности       | [.claude/rules/security.md](./.claude/rules/security.md) |
| Правила Git                | [.claude/rules/git.md](./.claude/rules/git.md) |
| Правила планирования       | [.claude/rules/planning.md](./.claude/rules/planning.md) |
| Правила UI                 | [.claude/rules/ui-design.md](./.claude/rules/ui-design.md) |
| Правила работы с business/ | [.claude/rules/business-context.md](./.claude/rules/business-context.md) |
| Правила деплоя             | [.claude/rules/deployment.md](./.claude/rules/deployment.md) |
| Скиллы Claude Code         | [.claude/skills/README.md](./.claude/skills/README.md) |
| Архитектура                | [docs/architecture/overview.md](./docs/architecture/overview.md) |
| Готовые промпты            | [docs/prompts/INDEX.md](./docs/prompts/INDEX.md) |

## Если файл противоречит CLAUDE.md

Приоритет: **`CLAUDE.md` > `AGENTS.md` > `.claude/rules/*.md` > `docs/*.md`.**
Если нашли противоречие — сообщите пользователю и не действуйте до решения.
