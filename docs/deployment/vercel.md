# Деплой на Vercel

Vercel — родная платформа для Next.js. Подходит для лендингов, простых SaaS, проектов без жёстких требований к локации хостинга.

## Когда выбирать

- Простой Next.js сайт.
- Нужны ISR, Edge Functions, Image Optimization без настроек.
- Аудитория глобальная или СНГ без ПДн.

## Когда НЕ выбирать

- Хранятся ПДн российских пользователей (152-ФЗ требует РФ-хостинг).
- Долгие фоновые задачи (> 60 сек на Pro плане).
- Нужен персистентный диск или TCP-соединения.

## Быстрый старт

1. Зарегистрируйтесь на https://vercel.com через GitHub.
2. New Project → Import Git Repository → выберите репо.
3. Framework Preset: **Next.js** (определит сам).
4. Build Command: `pnpm build` (по умолчанию).
5. Install Command: `pnpm install --frozen-lockfile`.
6. Output Directory: `.next` (по умолчанию).
7. Environment Variables → добавьте всё из `.env.example` с реальными значениями.
8. Deploy.

## Переменные окружения

Все из `.env.example`. Особенно важные:

| Переменная | Где использовать |
| ---------- | ---------------- |
| `NEXT_PUBLIC_APP_URL` | прод-домен (без слэша в конце) |
| `DATABASE_URL` | строка подключения, обычно из Neon / Supabase |
| `ANTHROPIC_API_KEY` | если используете Claude API |
| `WEBHOOK_SECRET` | для верификации webhooks |

**Не забудьте:** Vercel шифрует переменные, но если ты их вывел в `console.log` — они попадут в логи. См. `.claude/rules/security.md`.

## Домен

1. Settings → Domains → Add → ваш-домен.com
2. У регистратора домена пропишите DNS-записи, которые покажет Vercel.
3. SSL включается автоматически (Let's Encrypt).

## Preview-деплои

- Каждый pull request → автоматический preview-URL вида `<branch>-<project>.vercel.app`.
- Удобно для демо клиенту до мерджа в `main`.

## Откат

Deployments → находим зелёный предыдущий → ⋯ → **Promote to Production**. Применяется за секунды.

## Логи

Deployments → выбираем деплой → Functions → видим логи серверных функций и RSC-рендеров. Realtime.

## Стоимость

- **Hobby (бесплатный):** для пет-проектов. Без коммерции.
- **Pro ($20/мес):** для коммерческих. Лимиты на bandwidth и build minutes.
- **Enterprise:** только если знаете зачем.

## Если что-то идёт не так

| Симптом | Причина | Решение |
| ------- | ------- | ------- |
| Build падает на `pnpm install` | нет `pnpm-lock.yaml` или version mismatch | сделайте `pnpm install` локально, закоммитьте `pnpm-lock.yaml` |
| 500 на странице | переменная окружения не задана | проверьте Settings → Env Vars |
| Изображение с внешнего домена не грузится | домен не в whitelist | добавьте в `next.config.ts` `images.remotePatterns` |
| Долгий Cold Start | используется Node runtime для тяжёлой функции | переведите на Edge runtime если возможно |
