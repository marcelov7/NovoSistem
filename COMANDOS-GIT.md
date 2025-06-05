# 🚀 Comandos Git para Deploy

## ✅ Status Atual
O commit inicial já foi feito com sucesso! ✅
- **98 arquivos** adicionados
- **16.658 linhas** de código
- Sistema completo pronto para deploy

## 📋 Próximos Passos

### 1. Criar Repositório no GitHub/GitLab

**GitHub:**
1. Acesse https://github.com
2. Clique em "New repository"
3. Nome: `novosistem`
4. Deixe **público** ou **privado**
5. **NÃO** inicialize com README (já temos)
6. Clique "Create repository"

**GitLab:**
1. Acesse https://gitlab.com
2. Clique em "New project"
3. Nome: `novosistem`
4. Visibilidade: Público/Privado
5. **NÃO** inicialize com README
6. Clique "Create project"

### 2. Conectar e Push

```bash
# Adicionar remote (substitua pela sua URL)
git remote add origin https://github.com/SEU_USUARIO/novosistem.git

# Verificar se foi adicionado
git remote -v

# Push inicial
git push -u origin main
```

### 3. Comandos Completos (COPIE E COLE)

**Para GitHub:**
```bash
# Substitua SEU_USUARIO pelo seu username do GitHub
git remote add origin https://github.com/SEU_USUARIO/novosistem.git
git push -u origin main
```

**Para GitLab:**
```bash
# Substitua SEU_USUARIO pelo seu username do GitLab
git remote add origin https://gitlab.com/SEU_USUARIO/novosistem.git
git push -u origin main
```

## 🔧 Se Precisar Fazer Alterações

```bash
# Ver status
git status

# Adicionar alterações
git add .

# Commit
git commit -m "feat: nova funcionalidade"

# Push
git push origin main
```

## 🌐 Deploy no Render

### Após o Push para GitHub/GitLab:

1. **Acesse** https://render.com
2. **Clique** "New +" → "Web Service"
3. **Conecte** seu repositório
4. **Configure:**
   - **Name:** novosistem
   - **Environment:** Node
   - **Build Command:** `./build.sh`
   - **Start Command:** `php -S 0.0.0.0:$PORT -t public/`
   - **Instance Type:** Free

5. **Adicione Variáveis de Ambiente:**
```env
APP_NAME=NovoSistem
APP_ENV=production
APP_DEBUG=false
APP_KEY=base64:WILL_BE_GENERATED
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

6. **Clique** "Create Web Service"

## 🎯 URLs Finais

Após o deploy:
- **App:** https://novosistem.onrender.com
- **Login:** https://novosistem.onrender.com/login
- **Dashboard:** https://novosistem.onrender.com/home

## ✅ Checklist Final

- [x] Commit realizado ✅
- [ ] Repositório GitHub/GitLab criado
- [ ] Remote adicionado
- [ ] Push realizado
- [ ] Render configurado
- [ ] Deploy funcionando

---

**🎉 Sistema pronto para produção!** 