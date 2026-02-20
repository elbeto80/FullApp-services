# SIMA Front NOC

Frontend del NOC de SIMA.

## Requisitos

- Node.js >= 20
- npm

## Inicio rápido

```bash
npm install
npm run dev
```

Por defecto, la app levanta en `http://localhost:5173`.

## Scripts

- `npm run dev`: entorno de desarrollo
- `npm run build`: typecheck + build de producción
- `npm run preview`: previsualizar build local
- `npm run lint`: ejecutar ESLint
- `npm run typecheck`: validar TypeScript
- `npm run prettier`: formatear proyecto

## Estructura clave

- `src/main.tsx`: punto de entrada
- `src/App.tsx`: componente raíz
- `tsconfig.json`: configuración base + references + aliases
- `tsconfig.app.json`: configuración TypeScript para app
- `tsconfig.node.json`: configuración TypeScript para Vite/Node
- `vite.config.ts`: configuración de Vite + aliases

## Alias

Alias principal:

- `@/*` -> `src/*`

Los aliases se mantienen sincronizados en `tsconfig.json` y `vite.config.ts`.
