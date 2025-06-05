#!/usr/bin/env bash

echo "🚀 Iniciando NovoSistem (versão simples)..."

# Limpar TODOS os caches primeiro
echo "🧹 Limpando todos os caches..."
php artisan config:clear
php artisan route:clear  
php artisan view:clear
php artisan cache:clear

# Verificar APP_KEY
if [ -z "$APP_KEY" ]; then
    echo "❌ APP_KEY não definida!"
    exit 1
fi

echo "✅ APP_KEY encontrada"

# Executar migrações sem cache
echo "🗄️ Executando migrações..."
php artisan migrate --force --no-interaction

echo "✅ Sistema configurado! Iniciando servidor..."

# Iniciar servidor
PORT=${PORT:-10000}
exec php -S 0.0.0.0:$PORT -t public/ 