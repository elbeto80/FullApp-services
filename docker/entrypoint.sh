#!/bin/sh
set -e

######################################################
#❗ Las migraciones NO se revierten automáticamente  #
######################################################

echo "⏳ Waiting for database..."
until php artisan migrate:status > /dev/null 2>&1; do
  sleep 2
done

echo "🗄️ Running migrations..."
php artisan migrate --force

echo "⚡ Caching config..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

exec "$@"
