# Визуальная карта проекта

Три диаграммы для быстрого ориентирования. Если меняется архитектура — обновляйте здесь и в `docs/architecture/overview.md`.

## 1. Архитектура проекта

> Шаблонная схема — обновите после выбора стека под свою архитектуру (фреймворк, БД, внешние интеграции).

```mermaid
flowchart LR
    User[👤 Пользователь]
    Client[Клиент<br/>браузер / mobile / Telegram]
    App[Приложение<br/>Next.js / FastAPI / aiogram / ...]
    Logic[Бизнес-логика]
    DB[(База данных<br/>Postgres / SQLite / ...)]
    Cache[(Кеш<br/>Redis / опционально)]
    LLM[LLM API<br/>Anthropic / OpenAI]
    Pay[Платёжный<br/>провайдер]
    Analytics[Аналитика<br/>Я.Метрика / Plausible]

    User --> Client
    Client <-->|HTTP / WebSocket / Bot API| App
    App --> Logic
    Logic -->|SQL / ORM| DB
    Logic --> Cache
    Logic -->|HTTPS| LLM
    Logic -->|HTTPS| Pay
    Pay -.->|webhook| App
    Client -.->|JS / SDK| Analytics
```

## 2. Путь пользователя

Замените на реальный путь после адаптации. Шаблонный пример:

```mermaid
journey
    title Путь от незнания до повторной покупки
    section Знакомство
      Увидел рекламу: 3: Пользователь
      Зашёл на лендинг: 4: Пользователь
      Прочитал оффер: 4: Пользователь
    section Действие
      Оставил заявку: 5: Пользователь
      Получил демо: 4: Пользователь, Менеджер
      Оплатил: 5: Пользователь
    section Использование
      Первый запуск: 4: Пользователь
      Получил результат: 5: Пользователь
    section Возврат
      Продлил подписку: 5: Пользователь
      Привёл друга: 5: Пользователь
```

## 3. Процесс работы

Процесс общий для Claude Code и Codex, подробно - `docs/workflow.md`.

```mermaid
flowchart TD
    Start[С чем пришёл пользователь:<br/>нет идеи / идея / архитектура / код]
    Cont[Продолжаем:<br/>сверить checkpoint с файлами]
    Privacy[Проверка приватности<br/>до записи business/]
    Core[Ядро business/INDEX.md<br/>разделы по мере данных]
    Plan[План результата в plans/]
    Review[Ревью по риску<br/>и судья]
    OK{Пользователь<br/>одобрил?}
    Phase[Фаза: тест до кода, код,<br/>проверки стека, Self-Audit]
    PhaseReview[Независимое ревью diff<br/>и судья]
    CP[Checkpoint в плане]
    Stop[Стоп: лимит, блокер,<br/>нужно отдельное «да»]
    Gate[4 пункта перед push]
    Done[Итоговая приёмка<br/>и ретроспектива]

    Start --> Privacy --> Core --> Plan --> Review --> OK
    OK -- правки --> Plan
    OK -- да --> Phase --> PhaseReview --> CP
    CP -- следующая фаза --> Phase
    CP -. пауза .-> Cont --> Phase
    Phase -. лимит или блокер .-> Stop
    CP -- все фазы --> Gate --> Done
```
