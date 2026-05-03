# Правила работы с business/

`business/` — это **источник истины** о проекте, не свалка заметок. Обращайся как с базой знаний, а не как с черновиком.

## Не читай весь business/ сразу

`business/` может вырасти до 30+ файлов. Если грузить всё в контекст — пострадает качество. Используй карту:

→ `business/INDEX.md` — карта файлов и таблица «какая задача → какие файлы».

## Какие файлы открывать под какую задачу

| Задача | Минимум |
| ------ | ------- |
| Написать тексты на лендинг | `audience/avatar.md`, `audience/objections.md`, `assets/copy-bank.md`, `assets/brand-guidelines.md` |
| Сверстать UI | `assets/brand-guidelines.md`, `audience/avatar.md` |
| Решить вопрос про цены | `products/pricing.md`, `economics/unit-economics.md`, `audience/segments.md` |
| Реклама / контент-план | `marketing/channels.md`, `marketing/content.md`, `audience/avatar.md` |
| Решить «делать ли фичу» | `goals/monthly.md`, `audience/avatar.md`, `economics/unit-economics.md` |
| Юр. документы | `company/legal.md`, `products/pricing.md` |
| Письма клиентам | `assets/copy-bank.md`, `assets/brand-guidelines.md`, `audience/avatar.md` |

## Когда обновлять business/

Когда из разговора с пользователем узнал что-то про проект, чего ещё нет в business/:

- Уточнили боль аватара → `audience/avatar.md`
- Поменялась цена → `products/pricing.md`
- Появился новый канал → `marketing/channels.md`
- Изменилась цель месяца → `goals/monthly.md`

**Не складывай знание в conversation memory.** В следующей сессии его не будет. В файле — будет.

## Как обновлять

1. Точечно: меняй конкретный блок в файле, не переписывай весь.
2. Не выдумывай: если данных нет — оставь пометку `> 🔲 заполнить:` с конкретным вопросом.
3. Сошлись в чате на изменение: «обновил `business/products/pricing.md` — добавил тариф Про+».

## Когда НЕ читать business/

- Тривиальные технические задачи (опечатка, обновить зависимость, починить тип).
- Вопрос про сам шаблон (как работает `plans/`, как настроить devcontainer).
- Чисто инструментальные команды (lint, format, build).

## Антипаттерны

- Читать всё `business/` перед каждым ответом — расход контекста.
- Хранить тут TODO-список разработки — для этого `plans/`.
- Хранить пароли, ключи, выписки — это секреты, см. `.claude/rules/security.md`.
- Дублировать данные в нескольких файлах — обновлять придётся в обоих, всё равно забудете. Один источник.
