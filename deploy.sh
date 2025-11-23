#!/usr/bin/env bash
set -e

cd /var/www/laravel

echo "Starting deployment..."

# Update code
git fetch origin
git reset --hard origin/12.x

# Install dependencies and run migrations
composer install --no-dev --optimize-autoloader
php artisan migrate --force

# Clear caches
php artisan config:clear
php artisan cache:clear
php artisan view:clear

# Reload PHP-FPM if available
sudo systemctl reload php8.2-fpm 2>/dev/null || true

echo "Deployment successful"
