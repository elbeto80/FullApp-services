import { useState } from "react";
import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Separator } from "@/components/ui/separator";
import { Switch } from "@/components/ui/switch";
import { Moon, Sun, Zap, Shield, BarChart3 } from "lucide-react";

function App() {
  const [dark, setDark] = useState(false);

  const toggleTheme = () => {
    setDark(prev => {
      document.documentElement.classList.toggle("dark", !prev);
      return !prev;
    });
  };

  return (
    <div className="min-h-svh bg-background text-foreground transition-colors">
      <header className="border-b border-border px-6 py-4">
        <div className="mx-auto flex max-w-5xl items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="flex size-9 items-center justify-center rounded-lg bg-primary">
              <Zap className="size-5 text-primary-foreground" />
            </div>
            <span className="text-xl font-bold tracking-tight">SIMA NOC</span>
            <Badge variant="secondary">v0.1</Badge>
          </div>

          <div className="flex items-center gap-2">
            <Sun className="size-4 text-muted-foreground" />
            <Switch checked={dark} onCheckedChange={toggleTheme} />
            <Moon className="size-4 text-muted-foreground" />
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-5xl space-y-8 px-6 py-10">
        <section className="space-y-2">
          <h1 className="text-3xl font-bold">Theming & Components</h1>
          <p className="text-muted-foreground">
            Vista de prueba para verificar Tailwind v4, variables CSS de tema y
            componentes shadcn.
          </p>
        </section>

        <Separator />

        {/* Color palette */}
        <section className="space-y-4">
          <h2 className="text-lg font-semibold">Paleta de colores</h2>
          <div className="flex flex-wrap gap-3">
            {[
              {
                name: "primary",
                bg: "bg-primary",
                fg: "text-primary-foreground",
              },
              {
                name: "secondary",
                bg: "bg-secondary",
                fg: "text-secondary-foreground",
              },
              { name: "accent", bg: "bg-accent", fg: "text-accent-foreground" },
              { name: "muted", bg: "bg-muted", fg: "text-muted-foreground" },
              { name: "destructive", bg: "bg-destructive", fg: "text-white" },
            ].map(c => (
              <div
                key={c.name}
                className={`${c.bg} ${c.fg} flex h-20 w-32 items-center justify-center rounded-lg text-sm font-medium shadow-sm`}
              >
                {c.name}
              </div>
            ))}
          </div>

          <div className="flex flex-wrap gap-3">
            {[
              { name: "primary-50", cls: "bg-primary-50" },
              { name: "primary-100", cls: "bg-primary-100" },
              { name: "primary-200", cls: "bg-primary-200" },
              { name: "primary-300", cls: "bg-primary-300" },
              { name: "primary-400", cls: "bg-primary-400" },
              { name: "primary-500", cls: "bg-primary-500" },
              { name: "primary-600", cls: "bg-primary-600" },
              { name: "primary-700", cls: "bg-primary-700" },
            ].map(c => (
              <div
                key={c.name}
                className={`${c.cls} flex h-14 w-24 items-center justify-center rounded-md text-xs font-medium text-dark-normal shadow-sm`}
              >
                {c.name}
              </div>
            ))}
          </div>
        </section>

        <Separator />

        {/* Button variants */}
        <section className="space-y-4">
          <h2 className="text-lg font-semibold">Botones</h2>
          <div className="flex flex-wrap gap-3">
            <Button>Primary</Button>
            <Button variant="secondary">Secondary</Button>
            <Button variant="destructive">Destructive</Button>
            <Button variant="outline">Outline</Button>
            <Button variant="ghost">Ghost</Button>
            <Button variant="link">Link</Button>
          </div>
          <div className="flex flex-wrap gap-3">
            <Button size="sm">Small</Button>
            <Button size="default">Default</Button>
            <Button size="lg">Large</Button>
            <Button size="icon">
              <Zap />
            </Button>
          </div>
        </section>

        <Separator />

        {/* Badge variants */}
        <section className="space-y-4">
          <h2 className="text-lg font-semibold">Badges</h2>
          <div className="flex flex-wrap gap-3">
            <Badge>Default</Badge>
            <Badge variant="secondary">Secondary</Badge>
            <Badge variant="destructive">Destructive</Badge>
            <Badge variant="outline">Outline</Badge>
          </div>
        </section>

        <Separator />

        {/* Cards */}
        <section className="space-y-4">
          <h2 className="text-lg font-semibold">Cards</h2>
          <div className="grid gap-4 sm:grid-cols-3">
            <Card>
              <CardHeader>
                <div className="flex items-center gap-2">
                  <Zap className="size-5 text-primary" />
                  <CardTitle>Monitoreo</CardTitle>
                </div>
                <CardDescription>
                  Estado de los servicios en tiempo real
                </CardDescription>
              </CardHeader>
              <CardContent>
                <p className="text-2xl font-bold text-primary">99.8%</p>
                <p className="text-sm text-muted-foreground">
                  Uptime últimas 24h
                </p>
              </CardContent>
              <CardFooter>
                <Badge>Operativo</Badge>
              </CardFooter>
            </Card>

            <Card>
              <CardHeader>
                <div className="flex items-center gap-2">
                  <Shield className="size-5 text-secondary" />
                  <CardTitle>Seguridad</CardTitle>
                </div>
                <CardDescription>Alertas y eventos del sistema</CardDescription>
              </CardHeader>
              <CardContent>
                <p className="text-2xl font-bold">3</p>
                <p className="text-sm text-muted-foreground">Alertas activas</p>
              </CardContent>
              <CardFooter>
                <Badge variant="destructive">Atención</Badge>
              </CardFooter>
            </Card>

            <Card>
              <CardHeader>
                <div className="flex items-center gap-2">
                  <BarChart3 className="size-5 text-primary" />
                  <CardTitle>Reportes</CardTitle>
                </div>
                <CardDescription>
                  Métricas y análisis de rendimiento
                </CardDescription>
              </CardHeader>
              <CardContent>
                <p className="text-2xl font-bold">1,240</p>
                <p className="text-sm text-muted-foreground">
                  Eventos procesados hoy
                </p>
              </CardContent>
              <CardFooter>
                <Button variant="outline" size="sm">
                  Ver detalle
                </Button>
              </CardFooter>
            </Card>
          </div>
        </section>

        <Separator />

        {/* Custom tokens */}
        <section className="space-y-4">
          <h2 className="text-lg font-semibold">Tokens custom del tema</h2>
          <div className="flex flex-wrap gap-3">
            {[
              { name: "neutral-violet", cls: "bg-neutral-violet text-white" },
              { name: "dark-violet", cls: "bg-dark-violet text-white" },
              { name: "accent-info-500", cls: "bg-accent-info-500 text-white" },
              { name: "red-error-500", cls: "bg-red-error-500 text-white" },
              { name: "green-wpp", cls: "bg-green-wpp text-white" },
              { name: "warning-500", cls: "bg-warning-500 text-white" },
              { name: "success-700", cls: "bg-success-700 text-white" },
            ].map(c => (
              <div
                key={c.name}
                className={`${c.cls} flex h-14 items-center justify-center rounded-md px-4 text-xs font-medium shadow-sm`}
              >
                {c.name}
              </div>
            ))}
          </div>
        </section>
      </main>

      <footer className="border-t border-border px-6 py-4 text-center text-sm text-muted-foreground">
        SIMA Front NOC — Tailwind v4 + shadcn — Vista de prueba
      </footer>
    </div>
  );
}

export default App;
