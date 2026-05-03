import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "smyslokod-starter",
  description:
    "Стартовый шаблон для смысло-кодинга в VS Code + Claude Code: бизнес-мозг, планы, ретроспективы.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="ru" suppressHydrationWarning>
      <body className="min-h-screen bg-background font-sans antialiased">{children}</body>
    </html>
  );
}
