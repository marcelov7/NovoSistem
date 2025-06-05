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

# Gerar chave da aplicação se não existir
echo "🔑 Configurando chave da aplicação..."
php artisan key:generate --force --no-interaction

# Testar conexão com banco
echo "🔍 Testando conexão com banco..."
php artisan migrate:status || echo "⚠️ Banco não acessível ainda"

# Executar migrações
echo "🗄️ Executando migrações..."
php artisan migrate --force --no-interaction

# Configurar cache de produção
echo "⚡ Configurando cache de produção..."
php artisan config:cache
php artisan route:cache

# Verificar se as rotas estão funcionando
echo "🔍 Verificando rotas..."
php artisan route:list --compact

echo "✅ Build concluído com sucesso!" 