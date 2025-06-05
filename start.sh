#!/usr/bin/env bash

echo "🚀 Iniciando NovoSistem..."

# Verificar se APP_KEY está definida
if [ -z "$APP_KEY" ]; then
    echo "❌ APP_KEY não está definida!"
    echo "Configure a variável de ambiente APP_KEY no Render"
    exit 1
fi

echo "✅ APP_KEY encontrada"

# Configurar cache agora que APP_KEY está disponível
echo "⚡ Configurando cache com APP_KEY..."
php artisan config:cache
php artisan route:cache

# Executar migrações se necessário
echo "🗄️ Verificando migrações..."
php artisan migrate --force --no-interaction

echo "✅ Sistema configurado! Iniciando servidor..."

# Iniciar o servidor PHP
PORT=${PORT:-10000}
php -S 0.0.0.0:$PORT -t public/ 