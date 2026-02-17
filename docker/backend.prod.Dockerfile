# ── Stage 1: Composer dependencies ──
FROM composer:latest AS deps

WORKDIR /app

COPY laravel/composer.json laravel/composer.lock ./
RUN composer install --no-dev --no-scripts --no-autoloader --prefer-dist

COPY laravel/ .
RUN composer dump-autoload --optimize


# ── Stage 2: PHP-FPM (backend) ──
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


# ── Stage 3: Nginx (reverse proxy → PHP-FPM) ──
FROM nginx:alpine AS nginx-backend

COPY docker/nginx/backend.conf /etc/nginx/conf.d/default.conf
COPY --from=deps /app/public /var/www/html/public

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
