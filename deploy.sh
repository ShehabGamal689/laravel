#!/usr/bin/env bash
set -e

APP_DIR="/var/www/laravel"

cd "$APP_DIR"

echo "Pulling latest changes from main..."
git fetch origin
git checkout 12.x
git pull origin 12.x

echo "Installing composer dependencies..."
composer install --no-dev --optimize-autoloader

echo "Running migrations..."
php artisan migrate --force

echo "Clearing and caching config/routes..."
php artisan config:clear
php artisan cache:clear
php artisan route:cache || true

echo "Reloading PHP-FPM if available..."
sudo systemctl reload php8.2-fpm 2>/dev/null || true

echo "Deployment finished successfully."
