# business/ — мозг проекта

Эта папка — **источник истины** о вашем бизнесе. Не Notion, не Google Docs, а Git.
Claude Code читает её ВЫБОРОЧНО, по карте ниже. Поэтому не загружайте всё разом — это бьёт по контексту и качеству.

## Правила работы

1. Перед любой задачей открывайте только нужный файл (по карте).
2. Узнал что-то новое о проекте → обнови файл, не складывай в conversation memory.
3. Файлы — короткие. Если выросло > 200 строк — раздели по подтемам.
4. Незаполненные блоки помечайте `> 🔲 заполнить при адаптации проекта` с конкретным вопросом.
5. Wiki-ссылки в стиле `[[avatar]]` поддерживаются Obsidian / Foam — оставьте их если работаете в этих инструментах.

## Карта файлов

### Компания

- [company/about.md](./company/about.md) — что за компания, история, миссия
- [company/team.md](./company/team.md) — кто в команде, роли
- [company/values.md](./company/values.md) — ценности, культура
- [company/legal.md](./company/legal.md) — юр. форма, реквизиты, лицензии

### Продукты

- [products/overview.md](./products/overview.md) — что мы делаем, в одной странице
- [products/pricing.md](./products/pricing.md) — тарифы, скидки, политика цен → wiki: [[pricing]]
- [products/product-1.md](./products/product-1.md) — детали первого продукта

### Аудитория

- [audience/avatar.md](./audience/avatar.md) — главный портрет клиента → wiki: [[avatar]]
- [audience/segments.md](./audience/segments.md) — другие сегменты
- [audience/objections.md](./audience/objections.md) — типовые возражения и ответы → wiki: [[objections]]
- [audience/journey.md](./audience/journey.md) — путь клиента от незнания до покупки

### Цели

- [goals/annual.md](./goals/annual.md) — годовая цель + 3 ключевых результата
- [goals/quarterly.md](./goals/quarterly.md) — текущий квартал
- [goals/monthly.md](./goals/monthly.md) — текущий месяц → wiki: [[monthly]]
- [goals/kpi.md](./goals/kpi.md) — ключевые метрики и где они смотрятся

### Экономика

- [economics/unit-economics.md](./economics/unit-economics.md) — LTV, CAC, маржа
- [economics/revenue.md](./economics/revenue.md) — выручка по каналам / продуктам
- [economics/costs.md](./economics/costs.md) — постоянные и переменные расходы
- [economics/forecast.md](./economics/forecast.md) — прогноз на 3–12 месяцев

### Маркетинг

- [marketing/channels.md](./marketing/channels.md) — какие каналы используем и почему
- [marketing/funnel.md](./marketing/funnel.md) — воронка с конверсиями
- [marketing/competitors.md](./marketing/competitors.md) — кто конкуренты, чем отличаемся
- [marketing/content.md](./marketing/content.md) — контент-стратегия и темы

### Активы

- [assets/brand-guidelines.md](./assets/brand-guidelines.md) — голос, тон, цвета, шрифты → wiki: [[brand-guidelines]]
- [assets/testimonials.md](./assets/testimonials.md) — отзывы клиентов
- [assets/copy-bank.md](./assets/copy-bank.md) — банк формулировок: оффер, заголовки, CTA

## Когда какой файл читать

| Задача                      | Минимум файлов                                                     |
| --------------------------- | ------------------------------------------------------------------ |
| Тексты на лендинг           | `audience/avatar.md`, `audience/objections.md`, `assets/copy-bank.md`, `assets/brand-guidelines.md` |
| Дизайн UI                   | `assets/brand-guidelines.md`, `audience/avatar.md`                 |
| Цены / тарифы               | `products/pricing.md`, `economics/unit-economics.md`, `audience/segments.md` |
| Реклама / контент           | `marketing/channels.md`, `marketing/content.md`, `audience/avatar.md` |
| Принятие решения о фиче     | `goals/monthly.md`, `audience/avatar.md`, `economics/unit-economics.md` |
| Юр. документы / оферта      | `company/legal.md`, `products/pricing.md`                          |
