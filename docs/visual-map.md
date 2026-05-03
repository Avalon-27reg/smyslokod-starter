# Визуальная карта проекта

Три диаграммы для быстрого ориентирования. Если меняется архитектура — обновляйте здесь и в `docs/architecture/overview.md`.

## 1. Архитектура проекта

```mermaid
flowchart LR
    User[👤 Пользователь]
    Browser[🌐 Браузер]
    NextEdge[Next.js<br/>Edge / Node]
    RSC[Server<br/>Components]
    APIRoute[API Routes /<br/>Server Actions]
    DB[(БД<br/>Postgres)]
    Cache[(Redis)]
    LLM[LLM API<br/>Anthropic / OpenAI]
    Pay[Платёжный<br/>провайдер]
    Analytics[Аналитика<br/>Я.Метрика]

    User --> Browser
    Browser <-->|HTTP / RSC| NextEdge
    NextEdge --> RSC
    NextEdge --> APIRoute
    RSC -->|SQL / ORM| DB
    APIRoute -->|SQL / ORM| DB
    APIRoute --> Cache
    APIRoute -->|HTTPS| LLM
    APIRoute -->|HTTPS| Pay
    Pay -.->|webhook| APIRoute
    Browser -.->|JS| Analytics
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

## 3. Workflow Claude Code

```mermaid
flowchart TD
    Idea[💡 Идея пользователя]
    StartHere[START_HERE.md]
    CC[🧠 Claude Code]
    ReadCLAUDE[Читает CLAUDE.md]
    ReadBusiness[Читает business/<br/>выборочно по INDEX.md]
    Plan[Создаёт план в plans/]
    Critic[Запускает critic]
    Wait{Утверждено?}
    Implement[Реализация<br/>одного шага]
    Retro[Запись в<br/>retrospectives/]
    Update[Обновляет business/<br/>если узнал новое]

    Idea --> StartHere
    StartHere --> CC
    CC --> ReadCLAUDE
    ReadCLAUDE --> ReadBusiness
    ReadBusiness --> Plan
    Plan --> Critic
    Critic --> Wait
    Wait -- Нет --> Plan
    Wait -- Да --> Implement
    Implement --> Retro
    Retro --> Update
    Update --> Idea
```
