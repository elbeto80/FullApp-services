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

# Copiar Laravel a directorio de staging (NO al WORKDIR del volume)
# El entrypoint copiará el código fresco al volumen en cada inicio,
# evitando el problema de "named volumes" que no se actualizan en rebuild
COPY laravel/ /app-staging/

# Instalar dependencias (prod) en staging
WORKDIR /app-staging
RUN composer install \
  --no-dev \
  --prefer-dist \
  --optimize-autoloader \
  --no-interaction

# Crear directorios de storage y permisos en staging
RUN mkdir -p storage/framework/{sessions,views,cache} \
  && mkdir -p storage/logs \
  && chown -R www-data:www-data storage bootstrap/cache \
  && chmod -R 775 storage bootstrap/cache

WORKDIR /var/www/html

# Copiar entrypoint
COPY docker/entrypoint.prod.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
