# ── Stage 1: Build de React con Vite (used by prod stage) ──
FROM node:22.22.0-alpine3.23 AS build

WORKDIR /app

COPY frontend/package.json frontend/package-lock.json ./
RUN npm ci

COPY frontend/ .
RUN npm run build


# ── Stage 2: Development ──
FROM node:22.22.0-alpine3.23 AS dev

WORKDIR /frontend

EXPOSE 5173

CMD ["sh", "-c", "npm install && npm run dev"]


# ── Stage 3: Production (Nginx sirve los archivos estáticos) ──
FROM nginx:alpine AS prod

COPY docker/nginx/frontend.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
