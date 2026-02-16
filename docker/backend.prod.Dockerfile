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
  mysqli \
  zip \
  intl \
  opcache \
  soap \
  xml \
  xmlwriter \
  xmlreader \
  xsl \
  gd

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copiar composer primero (cache)
COPY laravel/composer.json laravel/composer.lock* ./
RUN composer install \
  --no-dev \
  --prefer-dist \
  --optimize-autoloader \
  --no-interaction

# Copiar el resto del proyecto
COPY laravel/ .

# Optimizar Laravel
RUN php artisan key:generate --force || true \
  && php artisan config:clear \
  && php artisan route:clear \
  && php artisan view:clear \
  && php artisan config:cache \
  && php artisan route:cache \
  && php artisan view:cache

# Permisos
RUN chown -R www-data:www-data \
  storage \
  bootstrap/cache

EXPOSE 9000

CMD ["php-fpm"]
