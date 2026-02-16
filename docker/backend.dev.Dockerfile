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


# CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
CMD ["sh", "-c", "composer install && php artisan serve --host=0.0.0.0 --port=8000"]
