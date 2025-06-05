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
php artisan view:cache || echo "Erro ao configurar cache de views"

echo "=== VERIFICANDO VARIÁVEIS DO BANCO ==="
echo "DB_CONNECTION: $DB_CONNECTION"
echo "DB_HOST: $DB_HOST"
echo "DB_PORT: $DB_PORT"
echo "DB_DATABASE: $DB_DATABASE"
echo "DB_USERNAME: $DB_USERNAME"
echo "DB_PASSWORD definida: ${DB_PASSWORD:+SIM}"
echo "DB_SSLMODE: ${DB_SSLMODE:-não definida}"

echo "=== TESTANDO CONEXÃO COM BANCO ==="
php artisan migrate:status || echo "❌ Erro ao verificar status das migrações"

echo "=== EXECUTANDO MIGRAÇÕES ==="
php artisan migrate --force --no-interaction -v || echo "❌ Erro nas migrações"

echo "=== LIMPANDO CACHE ANTES DE INICIAR ==="
php artisan config:clear || echo "Erro ao limpar config"
php artisan view:clear || echo "Erro ao limpar views"

echo "=== INICIANDO SERVIDOR ==="
PORT=${PORT:-10000}
echo "Iniciando servidor na porta $PORT"
exec php -S 0.0.0.0:$PORT -t public/ 