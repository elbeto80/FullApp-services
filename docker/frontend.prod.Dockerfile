# === BUILD ===
FROM node:22.22.0-alpine3.23 AS build

WORKDIR /frontend

COPY frontend/package.json frontend/package-lock.json* ./
RUN npm ci

COPY frontend/ .
RUN npm run build


# === RUNTIME ===
FROM nginx:1.27-alpine

# Limpiar config default
RUN rm /etc/nginx/conf.d/default.conf

# Copiar build
COPY --from=build /frontend/dist /usr/share/nginx/html

# Config nginx SPA
COPY docker/nginx/frontend.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
