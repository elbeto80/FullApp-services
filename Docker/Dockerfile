# === DEV === #
FROM node:22.22.0-alpine3.23 AS dev

WORKDIR /frontend

COPY frontend/package.json frontend/package-lock.json* ./
RUN npm install

COPY frontend/ .

EXPOSE 5173
CMD ["npm", "run", "dev"]


# === BUILD === #
FROM node:22.22.0-alpine3.23 AS build

WORKDIR /app

COPY frontend/package.json frontend/package-lock.json* ./
RUN npm install

COPY frontend/ .
RUN npm run build


# === PROD === #
FROM nginx:alpine AS prod

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
