# ── Stage 1: Build de React con Vite (used by prod stage) ──
FROM node:22-alpine3.23 AS build

ARG VITE_API_BASE_URL
ENV VITE_API_BASE_URL=$VITE_API_BASE_URL

WORKDIR /app

COPY frontend/package.json frontend/package-lock.json ./
RUN npm ci

COPY frontend/ .
RUN npm run build


# ── Stage 2: Development ──
FROM node:22-alpine3.23 AS dev

WORKDIR /frontend

EXPOSE 5173

CMD ["sh", "-c", "npm install && npm run dev"]


# ── Stage 3: Production (Nginx sirve los archivos estáticos) ──
FROM nginx:1.28-alpine3.23 AS prod

COPY docker/nginx/frontend.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
