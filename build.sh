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

# Verificar se APP_KEY existe (não gerar nova em produção)
echo "🔑 Verificando chave da aplicação..."
if [ -z "$APP_KEY" ]; then
    echo "⚠️ APP_KEY não definida nas variáveis de ambiente!"
    exit 1
else
    echo "✅ APP_KEY configurada corretamente"
fi

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