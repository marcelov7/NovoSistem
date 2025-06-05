# 🚀 Guia de Configuração - NovoSistem

## 📋 Pré-requisitos

- PHP 8.2+
- PostgreSQL 13+
- Node.js 18+
- Composer
- npm ou yarn

## ⚙️ Configuração Inicial

### 1. Configurar Ambiente

```bash
# Copie o arquivo de configuração
cp env-config.txt .env

# Gere a chave da aplicação
php artisan key:generate
```

### 2. Configurar PostgreSQL

1. Crie o banco de dados no PostgreSQL:
```sql
CREATE DATABASE novosistem;
```

2. Edite o arquivo `.env` com suas credenciais PostgreSQL:
```env
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=novosistem
DB_USERNAME=seu_usuario
DB_PASSWORD=sua_senha
```

### 3. Instalar Dependências

```bash
# Dependências PHP
composer install

# Dependências Node.js
npm install
```

### 4. Configurar Banco de Dados

```bash
# Executar migrações
php artisan migrate

# (Opcional) Executar seeders
php artisan db:seed
```

### 5. Compilar Assets

```bash
# Desenvolvimento
npm run dev

# Produção
npm run build
```

### 6. Iniciar Servidor

```bash
# Método 1: Comando composer (recomendado)
composer run dev

# Método 2: Artisan serve
php artisan serve
```

## 🔧 Comandos Úteis

```bash
# Limpar cache
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear

# Executar testes
php artisan test

# Verificar status das migrações
php artisan migrate:status
```

## 🛠️ Próximos Passos de Desenvolvimento

1. **Criar Models e Migrations** específicos do negócio
2. **Desenvolver Controllers** para as funcionalidades
3. **Criar componentes Vue.js** personalizados
4. **Implementar autenticação** completa
5. **Configurar API routes** se necessário
6. **Implementar testes** unitários e de integração

## 📁 Estrutura do Projeto

```
NovoSistem/
├── app/                    # Lógica da aplicação
│   ├── Http/Controllers/   # Controllers
│   ├── Models/            # Models Eloquent
│   └── Providers/         # Service Providers
├── database/              # Migrações e seeders
├── resources/             # Views e assets
│   ├── js/               # Componentes Vue.js
│   ├── sass/             # Estilos SCSS
│   └── views/            # Templates Blade
├── routes/               # Definição de rotas
└── public/               # Assets públicos
```

## 🐛 Problemas Comuns

### Erro de conexão PostgreSQL
- Verifique se o PostgreSQL está rodando
- Confirme as credenciais no arquivo `.env`
- Teste a conexão: `php artisan tinker` → `DB::connection()->getPdo();`

### Erro de permissões
```bash
chmod -R 775 storage bootstrap/cache
```

### Assets não carregando
```bash
npm run dev
# ou
npm run build
``` 