# ── Stage Development ──
FROM php:8.4-fpm-alpine3.23 AS dev

WORKDIR /var/www/html

# Dependencias del sistema
RUN apk add --no-cache \
  git \
  curl \
  libpng-dev \
  oniguruma-dev \
  libxml2-dev \
  postgresql-dev \
  zip \
  unzip \
  linux-headers \
  $PHPIZE_DEPS

# Extensiones PHP (xml, mbstring, opcache + resto)
RUN docker-php-ext-install \
  pdo \
  pdo_mysql \
  pdo_pgsql \
  mbstring \
  xml \
  exif \
  pcntl \
  bcmath \
  gd \
  opcache

# Xdebug
RUN pecl install xdebug \
  && docker-php-ext-enable xdebug

# Composer
COPY --from=composer:2.9 /usr/bin/composer /usr/bin/composer

COPY laravel/ /var/www/html

EXPOSE 8000 9003

CMD ["sh", "-c", "composer install && php artisan serve --host=0.0.0.0 --port=8000"]


# ── Stage 1: Composer dependencies ──
FROM composer:2.9 AS deps

WORKDIR /app

COPY laravel/composer.json laravel/composer.lock ./
RUN composer install \
  --no-dev \
  --no-scripts \
  --no-autoloader \
  --prefer-dist

COPY laravel/ .
RUN composer dump-autoload --optimize


# ── Stage 2: Production PHP-FPM ──
FROM php:8.4-fpm-alpine3.23 AS prod

WORKDIR /var/www/html

# 📦 Dependencias mínimas (solo runtime)
RUN apk add --no-cache \
  libpng-dev \
  oniguruma-dev \
  libxml2-dev \
  postgresql-dev

# 🐘 Extensiones necesarias para Laravel
RUN docker-php-ext-install \
  pdo \
  pdo_pgsql \
  pdo_mysql \
  mbstring \
  xml \
  exif \
  pcntl \
  bcmath \
  gd \
  opcache

# ⚙️ Configuración PHP producción
COPY docker/php/prod.ini /usr/local/etc/php/conf.d/prod.ini

# 📥 Código ya optimizado desde Composer
COPY --from=deps /app /var/www/html

# 🔐 Permisos correctos para Laravel
RUN mkdir -p \
  storage/logs \
  storage/framework/cache/data \
  storage/framework/sessions \
  storage/framework/views \
  bootstrap/cache \
  && chown -R www-data:www-data storage bootstrap/cache \
  && chmod -R 775 storage bootstrap/cache

# 🧹 Limpiar cualquier cache previo (build sin env vars)
RUN php artisan config:clear \
  && php artisan route:clear \
  && php artisan view:clear

# 🚀 Entrypoint que cachea config en runtime (cuando las env vars están disponibles)
COPY docker/backend/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["entrypoint.sh"]
CMD ["php-fpm"]


# ── Stage 3: Nginx Backend ──
FROM nginx:stable-alpine AS nginx-backend

COPY docker/backend/nginx/backend.conf /etc/nginx/conf.d/default.conf
# 📂 Solo archivos públicos
COPY --from=deps /app/public /var/www/html/public

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
