# 🚀 Deploy NovoSistem no Render

## 📋 Preparação do Projeto

### 1. Configuração do Banco de Dados
✅ **Já configurado** - PostgreSQL do Render conectado:
- **Host:** dpg-d10ti95pdvs73acede0-a.oregon-postgres.render.com
- **Database:** dbrelatorio_rqkg
- **User:** dbrelatorio_rqkg_user
- **Port:** 5432

### 2. Arquivos de Deploy Criados
✅ **build.sh** - Script de build para o Render
✅ **render.yaml** - Configuração do serviço
✅ **Procfile** - Comando de inicialização
✅ **env-config.txt** - Variáveis de ambiente atualizadas

## 🔧 Passos para Deploy

### 1. Preparar o Repositório Git

```bash
# Inicializar git (se não foi feito)
git init

# Adicionar todos os arquivos
git add .

# Fazer commit inicial
git commit -m "feat: Sistema NovoSistem com Laravel + Vue.js pronto para deploy"

# Adicionar remote do GitHub/GitLab
git remote add origin https://github.com/SEU_USUARIO/novosistem.git

# Push para o repositório
git push -u origin main
```

### 2. Configurar no Render

1. **Acesse** https://render.com
2. **Clique** em "New +" → "Web Service"
3. **Conecte** seu repositório Git
4. **Configure:**
   - **Name:** novosistem
   - **Environment:** Node
   - **Build Command:** `./build.sh`
   - **Start Command:** `php -S 0.0.0.0:$PORT -t public/`

### 3. Variáveis de Ambiente

Configure estas variáveis no Render Dashboard:

```env
APP_NAME=NovoSistem
APP_ENV=production
APP_DEBUG=false
APP_TIMEZONE=America/Sao_Paulo
APP_URL=https://novosistem.onrender.com

DB_CONNECTION=pgsql
DB_HOST=dpg-d10ti95pdvs73acede0-a.oregon-postgres.render.com
DB_PORT=5432
DB_DATABASE=dbrelatorio_rqkg
DB_USERNAME=dbrelatorio_rqkg_user
DB_PASSWORD=CJZUYC4FeqPg3FfSZDVu7SoSaXhpzPwV

CACHE_STORE=database
QUEUE_CONNECTION=database
SESSION_DRIVER=database
```

## 🎯 Comandos Git para Deploy

### Push Inicial
```bash
# Verificar status
git status

# Adicionar alterações
git add .

# Commit
git commit -m "deploy: Configuração para Render finalizada"

# Push para o repositório
git push origin main
```

### Para Atualizações Futuras
```bash
# Fazer alterações...
git add .
git commit -m "feat: nova funcionalidade"
git push origin main
```

## ✅ Checklist de Deploy

- [ ] PostgreSQL configurado no Render
- [ ] Repositório Git criado e configurado
- [ ] build.sh com permissão de execução
- [ ] Variáveis de ambiente configuradas no Render
- [ ] Deploy automático configurado
- [ ] SSL habilitado (automático no Render)
- [ ] Domínio personalizado (opcional)

## 🔧 Troubleshooting

### Erro de Permissão no build.sh
```bash
chmod +x build.sh
git add build.sh
git commit -m "fix: permissão de execução para build.sh"
git push origin main
```

### Erro de Migração
- Verificar se as credenciais do banco estão corretas
- Verificar se o banco PostgreSQL está acessível

### Erro de Assets
- Certificar que o `npm run build` está funcionando localmente
- Verificar se todas as dependências estão no package.json

## 🌐 URLs do Sistema

### Após o Deploy
- **Aplicação:** https://novosistem.onrender.com
- **Login:** https://novosistem.onrender.com/login
- **Dashboard:** https://novosistem.onrender.com/home
- **Usuários:** https://novosistem.onrender.com/users

## 📱 Funcionalidades Disponíveis

✅ **Sistema de Autenticação** completo
✅ **CRUD de Usuários** com interface Vue.js
✅ **Dashboard** interativo
✅ **API REST** para integrações
✅ **Interface Responsiva** (Bootstrap 5)
✅ **PostgreSQL** configurado

---

**🚀 Após o push, o Render fará o deploy automaticamente!** 