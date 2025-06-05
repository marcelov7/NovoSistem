#!/usr/bin/env bash

echo "=== DEBUG START ==="
echo "Data/Hora: $(date)"
echo "Diretório atual: $(pwd)"
echo "Usuário: $(whoami)"

echo "=== VARIÁVEIS DE AMBIENTE ==="
echo "APP_KEY definida: ${APP_KEY:+SIM}"
echo "APP_ENV: $APP_ENV"
echo "PORT: $PORT"

echo "=== VERIFICANDO ARQUIVOS ==="
ls -la

echo "=== VERIFICANDO PHP ==="
php --version

echo "=== VERIFICANDO ARTISAN ==="
ls -la artisan
php artisan --version

echo "=== TESTANDO APP_KEY ==="
if [ -z "$APP_KEY" ]; then
    echo "❌ APP_KEY NÃO DEFINIDA!"
    echo "Listando todas as variáveis que começam com APP:"
    env | grep ^APP || echo "Nenhuma variável APP encontrada"
    exit 1
else
    echo "✅ APP_KEY encontrada (${#APP_KEY} caracteres)"
fi

echo "=== CONFIGURANDO CACHE ==="
php artisan config:cache || echo "Erro ao configurar cache"
php artisan route:cache || echo "Erro ao configurar cache de rotas"

echo "=== EXECUTANDO MIGRAÇÕES ==="
php artisan migrate --force --no-interaction || echo "Erro nas migrações"

echo "=== INICIANDO SERVIDOR ==="
PORT=${PORT:-10000}
echo "Iniciando servidor na porta $PORT"
exec php -S 0.0.0.0:$PORT -t public/ 