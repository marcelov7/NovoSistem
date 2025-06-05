#!/usr/bin/env bash

echo "🚀 Iniciando build do NovoSistem para Render..."

# Definir variáveis de ambiente se não existirem
export APP_ENV=${APP_ENV:-production}
export APP_DEBUG=${APP_DEBUG:-false}

# Instalar dependências do Node.js primeiro
echo "📦 Instalando dependências Node.js..."
npm ci --legacy-peer-deps

# Instalar dependências do Composer
echo "📦 Instalando dependências PHP..."
composer install --no-dev --optimize-autoloader

# Compilar assets para produção
echo "🎨 Compilando assets..."
npm run build

# Limpar todos os caches antes
echo "🧹 Limpando cache inicial..."
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear

# Verificar se APP_KEY existe (será definida no runtime)
echo "🔑 Verificando chave da aplicação..."
if [ -z "$APP_KEY" ]; then
    echo "ℹ️ APP_KEY será configurada no runtime pelo Render"
else
    echo "✅ APP_KEY já configurada"
fi

# Testar conexão com banco
echo "🔍 Testando conexão com banco..."
php artisan migrate:status || echo "⚠️ Banco não acessível ainda"

# Executar migrações
echo "🗄️ Executando migrações..."
php artisan migrate --force --no-interaction

# Configurar cache de produção (apenas se APP_KEY existir)
echo "⚡ Configurando cache de produção..."
if [ -n "$APP_KEY" ]; then
    php artisan config:cache
    php artisan route:cache
else
    echo "ℹ️ Cache será configurado no runtime (APP_KEY necessária)"
fi

# Verificar se as rotas estão funcionando
echo "🔍 Verificando rotas..."
php artisan route:list --compact

echo "✅ Build concluído com sucesso!" 