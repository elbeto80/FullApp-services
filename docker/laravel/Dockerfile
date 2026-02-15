# === BASE === #
FROM php:8.3-fpm-alpine AS base

RUN apk add --no-cache \
  bash \
  git \
  curl \
  libzip-dev \
  oniguruma-dev \
  unzip

RUN docker-php-ext-install \
  pdo \
  pdo_mysql \
  mbstring \
  zip

WORKDIR /var/www

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer


# === DEV === #
FROM base AS dev
CMD ["php-fpm"]


# === PROD === #
FROM base AS prod

COPY laravel/ .

RUN mkdir -p storage bootstrap/cache \
  && chown -R www-data:www-data storage bootstrap/cache \
  && chmod -R 775 storage bootstrap/cache

RUN composer install --no-dev --optimize-autoloader

RUN php artisan config:clear \
  && php artisan config:cache \
  && php artisan route:cache \
  && php artisan view:cache

RUN chown -R www-data:www-data /var/www

CMD ["php-fpm"]
