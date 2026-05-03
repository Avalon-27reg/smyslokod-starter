# Деплой на Railway

Railway — облачная платформа для контейнерных приложений с предустановленными базами данных и фоновыми воркерами.

## Когда выбирать

- Международный продукт с бэкендом и БД.
- Нужны долгие фоновые задачи / cron / воркеры.
- Нужна Postgres / Redis из коробки.
- Удобен Docker / nixpacks.

## Когда НЕ выбирать

- Хранятся ПДн российских пользователей (хостинг не в РФ).
- Только лендинг — Vercel дешевле и проще.

## Быстрый старт

1. Зарегистрируйтесь: https://railway.app
2. New Project → Deploy from GitHub repo → выберите.
3. Railway сам определит Next.js через nixpacks.
4. Settings → Variables → добавьте всё из `.env.example`.
5. Settings → Networking → Generate Domain (или подключите свой).
6. Settings → Deploy → Build Command: `pnpm build`. Start Command: `pnpm start`.
7. Deploy.

## Postgres / Redis

В проекте → New → Database → Add PostgreSQL / Redis.
Railway автоматически прокидывает `DATABASE_URL` / `REDIS_URL` в переменные окружения вашего сервиса (через Reference Variables).

## Стоимость

- **Trial:** $5 кредитов на старте, потом нужна карта.
- **Pay-as-you-go:** $5/мес минимум за каждый сервис + потребление CPU / RAM / Network.
- Postgres дешёвый: $5/мес за минимальный.

## Workers и cron

- New Service → Empty Service → подключите тот же репо.
- Start Command: `pnpm tsx src/worker.ts` (например).
- Для cron: установите `pm2` или используйте Railway Cron Jobs (Settings → Cron).

## Откат

Deployments → находите старый зелёный → Redeploy. Перезаливает образ.

## Логи

В сервисе вкладка Logs. Realtime + поиск.

## Если что-то идёт не так

| Симптом | Причина | Решение |
| ------- | ------- | ------- |
| Build падает на nixpacks | не определён Node | добавьте `engines.node` в `package.json` (уже есть) |
| Сервис вылетает с OOM | не хватает RAM | поднимите план или оптимизируйте |
| 502 при первом запросе | приложение не слушает `process.env.PORT` | Next.js слушает PORT из коробки, проверьте Start Command = `pnpm start` |
| Не видит DATABASE_URL | не привязали Reference Variable | Settings → Variables → Add Reference → выберите БД |

## Безопасность

- Сетевые порты по умолчанию закрыты, открывается только тот, что в Start Command.
- Все секреты — в Variables (зашифрованы).
- Не коммитьте `.env` (в `.gitignore` уже зашито).
