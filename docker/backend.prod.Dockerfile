FROM php:8.4-fpm-alpine

WORKDIR /var/www/html

# Dependencias del sistema
RUN apk add --no-cache \
  git \
  curl \
  libpng-dev \
  oniguruma-dev \
  libxml2-dev \
  zip \
  unzip

# Extensiones PHP
RUN docker-php-ext-install \
  pdo \
  pdo_mysql \
  mbstring \
  exif \
  pcntl \
  bcmath \
  gd

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copiar TODO Laravel
COPY laravel/ .

# Instalar dependencias (prod)
RUN composer install \
  --no-dev \
  --prefer-dist \
  --optimize-autoloader \
  --no-interaction

# 🔥 SOLO limpiar caches (NO cachear)
RUN php artisan config:clear \
  && php artisan route:clear \
  && php artisan view:clear

# Permisos (crítico para web)
RUN mkdir -p storage/framework/{sessions,views,cache} \
  && chown -R www-data:www-data storage bootstrap/cache

EXPOSE 9000

CMD ["php-fpm"]
