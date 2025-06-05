#!/usr/bin/env bash

echo "🚀 Iniciando build do NovoSistem para Render..."

# Instalar dependências do Composer
echo "📦 Instalando dependências PHP..."
composer install --no-dev --optimize-autoloader

# Instalar dependências do Node.js
echo "📦 Instalando dependências Node.js..."
npm ci

# Gerar chave da aplicação se não existir
echo "🔑 Configurando chave da aplicação..."
php artisan key:generate --force

# Limpar e configurar cache
echo "🧹 Limpando cache..."
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear

# Compilar assets para produção
echo "🎨 Compilando assets..."
npm run build

# Executar migrações
echo "🗄️ Executando migrações..."
php artisan migrate --force

# Configurar cache de produção
echo "⚡ Configurando cache de produção..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Otimizações finais
echo "🔧 Aplicando otimizações..."
php artisan optimize

echo "✅ Build concluído com sucesso!" 