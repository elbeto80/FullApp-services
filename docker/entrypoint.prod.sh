#!/bin/sh
set -e

cd /var/www/html

# On each container start, copy fresh code from the staging directory
# into the shared volume. This solves the "stale named volume" problem
# where Docker does NOT update named volumes on image rebuild.
if [ -d /app-staging ]; then
    echo "Copying fresh application code to volume..."
    cp -af /app-staging/. /var/www/html/
fi

# Ensure storage directories exist
mkdir -p storage/framework/{sessions,views,cache}
mkdir -p storage/logs

# Fix permissions for www-data (PHP-FPM user)
chown -R www-data:www-data storage bootstrap/cache
chmod -R 775 storage bootstrap/cache

# Wait for database to be ready before running migrations
echo "Waiting for database connection..."
max_retries=30
counter=0
while [ $counter -lt $max_retries ]; do
    if php artisan migrate --force 2>&1; then
        echo "Migrations completed successfully!"
        break
    fi
    counter=$((counter + 1))
    echo "Database not ready, retrying in 3s... ($counter/$max_retries)"
    sleep 3
done

if [ $counter -eq $max_retries ]; then
    echo "WARNING: Could not run migrations after $max_retries attempts"
fi

# Cache config, routes and views for production performance
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "Laravel is ready!"

exec "$@"
