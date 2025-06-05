# Use PHP 8.2 com Node.js
FROM php:8.2-cli

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    nodejs \
    npm \
    libpq-dev

# Instalar extensões PHP
RUN docker-php-ext-install pdo pdo_pgsql mbstring exif pcntl bcmath gd

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Definir diretório de trabalho
WORKDIR /app

# Copiar arquivos do projeto
COPY . .

# Tornar build.sh executável
RUN chmod +x build.sh

# Executar build
RUN ./build.sh

# Expor porta
EXPOSE $PORT

# Comando de inicialização
CMD ["sh", "-c", "php -S 0.0.0.0:$PORT -t public/"] 