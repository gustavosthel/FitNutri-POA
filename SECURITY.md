# 🔒 Guia de Segurança - FitNutri-POA

## ⚠️ IMPORTANTE: Proteção de Chaves de API

### 🚨 NUNCA faça commit das suas chaves de API!

Este projeto já está configurado para proteger automaticamente suas informações sensíveis, mas é importante seguir estas práticas:

## 🛡️ Arquivos Protegidos

O `.gitignore` está configurado para ignorar:

```
✅ src/main/resources/config.properties
✅ src/config.properties  
✅ *.properties (todos os arquivos .properties)
✅ *.key, *.secret
✅ .env, .env.local, .env.production
✅ Certificados e keystores
✅ Logs e dados temporários
```

## 🔧 Como Configurar suas Chaves com Segurança

### Método 1: Arquivo de Configuração (Recomendado)

1. **Copie o arquivo de exemplo:**
   ```bash
   copy src\main\resources\config.properties.example src\main\resources\config.properties
   ```

2. **Edite o arquivo copiado:**
   ```properties
   # Em config.properties (NUNCA será commitado)
   groq.api.key=sua_chave_real_aqui
   ```

### Método 2: Variáveis de Ambiente

```bash
# Windows
set GROQ_API_KEY=sua_chave_aqui

# PowerShell
$env:GROQ_API_KEY="sua_chave_aqui"

# Linux/Mac
export GROQ_API_KEY=sua_chave_aqui
```

## 🚫 O que NUNCA fazer

❌ **NUNCA:**
- Coloque chaves de API diretamente no código
- Commit arquivos com chaves reais
- Compartilhe chaves em mensagens/emails
- Use chaves de produção em desenvolvimento
- Deixe chaves em arquivos públicos

## ✅ Boas Práticas

### 1. **Verificação antes do Commit**
Sempre execute antes de fazer commit:
```bash
git status
git diff --cached
```

### 2. **Verificar .gitignore**
Confirme que o arquivo está sendo ignorado:
```bash
git check-ignore src/main/resources/config.properties
# Deve retornar o caminho do arquivo se estiver sendo ignorado
```

### 3. **Chaves Diferentes por Ambiente**
- **Desenvolvimento**: Use chaves de teste
- **Produção**: Use chaves de produção separadas

### 4. **Rotação de Chaves**
- Troque suas chaves periodicamente
- Se uma chave foi exposta, revogue imediatamente

## 🔍 Verificações de Segurança

### Antes de cada Push:
```bash
# Verificar se não há chaves expostas
git log --oneline -n 10
git show HEAD

# Verificar arquivos que serão enviados
git ls-files | grep -E "\.(properties|key|env)$"
```

### Se Você Acidentalmente Commitou uma Chave:

1. **🚨 URGENTE: Revogue a chave imediatamente**
   - Acesse https://console.groq.com
   - Revogue/delete a chave exposta
   - Gere uma nova chave

2. **Remova do histórico Git:**
   ```bash
   # Remove o arquivo do histórico (CUIDADO!)
   git filter-branch --force --index-filter \
     'git rm --cached --ignore-unmatch src/main/resources/config.properties' \
     --prune-empty --tag-name-filter cat -- --all
   
   # Force push (apenas se necessário)
   git push --force --all
   ```

## 🔐 Configurações Adicionais de Segurança

### 1. **Configurar Git Global**
```bash
git config --global core.excludesfile ~/.gitignore_global
echo "*.properties" >> ~/.gitignore_global
echo "*.key" >> ~/.gitignore_global
echo ".env*" >> ~/.gitignore_global
```

### 2. **Hook de Pre-commit** (Opcional)
Crie `.git/hooks/pre-commit`:
```bash
#!/bin/bash
# Verificar se há chaves de API sendo commitadas
if git diff --cached --name-only | xargs grep -l "gsk_\|sk-" 2>/dev/null; then
    echo "❌ ERRO: Possível chave de API detectada!"
    echo "Verifique os arquivos antes de commitar."
    exit 1
fi
```

## 📋 Checklist de Segurança

Antes de fazer push para o repositório público:

- [ ] Verificar se `.gitignore` está funcionando
- [ ] Confirmar que `config.properties` não está sendo commitado
- [ ] Verificar se não há chaves hardcoded no código
- [ ] Testar se a aplicação funciona sem as chaves commitadas
- [ ] Revisar os últimos commits em busca de dados sensíveis

## 🆘 Em Caso de Emergência

Se você suspeitar que uma chave foi exposta:

1. **Ação Imediata:**
   - [ ] Revogue a chave no console da Groq
   - [ ] Gere uma nova chave
   - [ ] Atualize sua configuração local

2. **Investigação:**
   - [ ] Verifique o histórico do Git
   - [ ] Procure por logs que possam ter a chave
   - [ ] Verifique se outras pessoas têm acesso

3. **Prevenção:**
   - [ ] Mude todas as chaves relacionadas
   - [ ] Revise as permissões de acesso
   - [ ] Implemente rotação automática se possível

## 📞 Contato de Segurança

Se você descobrir uma vulnerabilidade de segurança:

- **NÃO** crie uma issue pública
- Entre em contato diretamente: [seu-email-seguranca@exemplo.com]
- Use [GPG] se possível para comunicação sensível

---

🔒 **Lembre-se: A segurança é responsabilidade de todos!**
