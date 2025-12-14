#!/bin/bash
set -e

cd /var/www/html

# Tự tạo .env nếu chưa có
if [ ! -f .env ] && [ -f .env.example ]; then
  cp .env.example .env
fi

# Đảm bảo thư mục log/cache tồn tại và cho phép ghi
mkdir -p storage/logs bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache
chmod -R ug+rwX storage bootstrap/cache

# Cài vendor nếu chưa có (do vendor là named volume)
if [ ! -d vendor ] || [ -z "$(ls -A vendor 2>/dev/null)" ]; then
  echo "vendor missing -> composer install"
  composer install --no-interaction --prefer-dist
fi

# Generate key nếu thiếu
if ! grep -q '^APP_KEY=.' .env; then
  php artisan key:generate --force || true
fi

# Đợi SQL Server sẵn sàng
echo "Waiting for SQL Server..."
for i in {1..60}; do
  /opt/mssql-tools18/bin/sqlcmd -S "$DB_HOST,$DB_PORT" -U "$DB_USERNAME" -P "$DB_PASSWORD" -Q "SELECT 1" -C && break
  sleep 2
done

# Tạo DB nếu chưa có
/opt/mssql-tools18/bin/sqlcmd -S "$DB_HOST,$DB_PORT" -U "$DB_USERNAME" -P "$DB_PASSWORD" -Q "IF DB_ID('$DB_DATABASE') IS NULL CREATE DATABASE [$DB_DATABASE]" -C

# Nạp dữ liệu/DDL từ file SQL nếu có
if [ -f database/init-db.sql ]; then
  echo "Importing database/init-db.sql into $DB_DATABASE..."
  /opt/mssql-tools18/bin/sqlcmd \
    -S "$DB_HOST,$DB_PORT" \
    -U "$DB_USERNAME" -P "$DB_PASSWORD" \
    -d "$DB_DATABASE" \
    -i database/init-db.sql -C || true
fi

if [ "$RUN_MIGRATE" = "true" ]; then
  php artisan migrate --force || true
fi

if [ "$RUN_SEED" = "true" ]; then
  php artisan db:seed --force || true
fi

exec "$@"
