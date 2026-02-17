#!/bin/sh
set -e

# Cache config at runtime when environment variables are available
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Execute the main container command (php-fpm)
exec "$@"
