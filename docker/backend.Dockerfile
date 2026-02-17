# ── Stage 1: Composer dependencies (used by prod stages) ──
FROM composer:latest AS deps

WORKDIR /app

COPY laravel/composer.json laravel/composer.lock ./
RUN composer install --no-dev --no-scripts --no-autoloader --prefer-dist

COPY laravel/ .
RUN composer dump-autoload --optimize


# ── Stage 2: Development ──
FROM php:8.4-fpm-alpine AS dev

WORKDIR /var/www/html

# Dependencias del sistema
RUN apk add --no-cache \
  git \
  curl \
  libpng-dev \
  oniguruma-dev \
  libxml2-dev \
  zip \
  unzip \
  linux-headers \
  $PHPIZE_DEPS

# Extensiones PHP (xml, mbstring, opcache + resto)
RUN docker-php-ext-install \
  pdo \
  pdo_mysql \
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
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

EXPOSE 8000
EXPOSE 9003

CMD ["sh", "-c", "composer install && php artisan serve --host=0.0.0.0 --port=8000"]


# ── Stage 3: Production (PHP-FPM backend) ──
FROM php:8.4-fpm-alpine AS backend

WORKDIR /var/www/html

RUN apk add --no-cache \
    libpng-dev \
    oniguruma-dev \
    libxml2-dev

RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    mbstring \
    xml \
    exif \
    pcntl \
    bcmath \
    gd \
    opcache

COPY docker/php/prod.ini /usr/local/etc/php/conf.d/prod.ini

COPY --from=deps /app /var/www/html

RUN mkdir -p storage/logs \
    storage/framework/cache/data \
    storage/framework/sessions \
    storage/framework/views \
    bootstrap/cache \
    && chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

EXPOSE 9000

CMD ["php-fpm"]


# ── Stage 4: Nginx (reverse proxy → PHP-FPM) ──
FROM nginx:alpine AS nginx-backend

COPY docker/nginx/backend.conf /etc/nginx/conf.d/default.conf
COPY --from=deps /app/public /var/www/html/public

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
