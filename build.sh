#!/usr/bin/env bash

echo "🚀 Iniciando build do NovoSistem para Render..."

# Instalar dependências do Node.js primeiro (para resolver conflitos)
echo "📦 Instalando dependências Node.js..."
npm ci --legacy-peer-deps

# Instalar dependências do Composer
echo "📦 Instalando dependências PHP..."
composer install --no-dev --optimize-autoloader

# Compilar assets para produção
echo "🎨 Compilando assets..."
npm run build

# Gerar chave da aplicação se não existir
echo "🔑 Configurando chave da aplicação..."
php artisan key:generate --force

# Limpar cache
echo "🧹 Limpando cache..."
php artisan config:clear
php artisan cache:clear

# Executar migrações
echo "🗄️ Executando migrações..."
php artisan migrate --force

# Configurar cache de produção
echo "⚡ Configurando cache de produção..."
php artisan config:cache
php artisan route:cache

echo "✅ Build concluído com sucesso!" 