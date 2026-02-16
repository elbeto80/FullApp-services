FROM php:8.4-fpm-alpine

WORKDIR /var/www/html

RUN apk add --no-cache \
  git \
  curl \
  libpng-dev \
  oniguruma-dev \
  libxml2-dev \
  zip \
  unzip

RUN docker-php-ext-install \
  pdo \
  pdo_mysql \
  mbstring \
  exif \
  pcntl \
  bcmath \
  gd

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

EXPOSE 8000

# CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
CMD ["sh", "-c", "composer install && php artisan serve --host=0.0.0.0 --port=8000"]
