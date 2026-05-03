import Link from "next/link";

const quickLinks = [
  { href: "/START_HERE.md", label: "START_HERE.md", note: "промпт для запуска адаптации" },
  { href: "/CLAUDE.md", label: "CLAUDE.md", note: "карта проекта для агента" },
  { href: "/business/INDEX.md", label: "business/INDEX.md", note: "мозг проекта" },
  { href: "/plans/TEMPLATE.md", label: "plans/TEMPLATE.md", note: "шаблон плана фичи" },
];

export default function HomePage() {
  return (
    <main className="container mx-auto flex min-h-screen max-w-3xl flex-col gap-8 px-6 py-16">
      <header className="space-y-3">
        <p className="text-sm uppercase tracking-widest text-muted-foreground">
          smyslokod-starter
        </p>
        <h1 className="text-4xl font-semibold leading-tight">
          Стартовый шаблон смысло-кодинга
        </h1>
        <p className="text-lg text-muted-foreground">
          Откройте проект в VS Code, скопируйте промпт из{" "}
          <code className="rounded bg-muted px-1.5 py-0.5 text-sm">START_HERE.md</code> в Claude
          Code и шаблон сам адаптируется под вашу идею.
        </p>
      </header>

      <section className="rounded-lg border bg-card p-6 shadow-sm">
        <h2 className="mb-4 text-xl font-medium">Быстрый старт</h2>
        <ol className="list-inside list-decimal space-y-2 text-sm">
          <li>
            <code className="rounded bg-muted px-1.5 py-0.5">pnpm install</code>
          </li>
          <li>
            <code className="rounded bg-muted px-1.5 py-0.5">pnpm dev</code>
          </li>
          <li>
            Откройте <code className="rounded bg-muted px-1.5 py-0.5">START_HERE.md</code> и
            скопируйте промпт в Claude Code.
          </li>
        </ol>
      </section>

      <section className="space-y-3">
        <h2 className="text-xl font-medium">Куда смотреть дальше</h2>
        <ul className="space-y-2">
          {quickLinks.map((link) => (
            <li
              key={link.href}
              className="flex items-baseline justify-between rounded-md border bg-card px-4 py-3"
            >
              <Link className="font-mono text-sm underline-offset-4 hover:underline" href="/">
                {link.label}
              </Link>
              <span className="text-sm text-muted-foreground">{link.note}</span>
            </li>
          ))}
        </ul>
      </section>

      <footer className="mt-auto border-t pt-6 text-sm text-muted-foreground">
        Шаблон работает на Next.js 15, TypeScript, Tailwind и shadcn/ui.
      </footer>
    </main>
  );
}
