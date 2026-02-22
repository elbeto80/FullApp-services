#!/bin/sh
set -e

######################################################
#❗ Las migraciones NO se revierten automáticamente  #
######################################################

MAX_RETRIES=30
i=0

echo "⏳ Waiting for database..."
until php artisan migrate:status > /dev/null 2>&1; do
  i=$((i+1))
  if [ "$i" -ge "$MAX_RETRIES" ]; then
    echo "❌ Database not ready after $MAX_RETRIES attempts"
    exit 1
  fi
  sleep 2
done

echo "🗄️ Running migrations..."
php artisan migrate --force

echo "⚡ Caching config..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

exec "$@"
