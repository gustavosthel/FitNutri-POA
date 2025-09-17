# 🚀 FitNutri-POA - Guia de Configuração

## 📋 Pré-requisitos

### ✅ Software Necessário
- **Java 11** (JDK 11 ou superior)
- **Eclipse IDE** (versão que suporte Java 11)
- **Apache Tomcat 11.0** (configurado no Eclipse)
- **Chave da API Groq** (obtenha em: https://console.groq.com)

### 🔍 Verificar Instalações
```bash
# Verificar versão do Java
java -version

# Deve mostrar algo como: "openjdk version 11.x.x"
```

## ⚡ Configuração Rápida (5 minutos)

### 1️⃣ **Clonar o Projeto**
```bash
git clone [URL_DO_SEU_REPOSITÓRIO]
cd FitNutri-POA
```

### 2️⃣ **Configurar a Chave da API**

**Opção A - Arquivo de Configuração (Recomendado para desenvolvimento):**
1. Copie o arquivo de exemplo:
   ```bash
   copy src\main\resources\config.properties.example src\main\resources\config.properties
   ```
2. Edite `src/main/resources/config.properties`
3. Substitua `SUA_CHAVE_GROQ_AQUI` pela sua chave real da API Groq

**Opção B - Variável de Ambiente (Mais seguro):**
```bash
# Windows (PowerShell)
$env:GROQ_API_KEY = "sua_chave_real_aqui"

# Windows (CMD)
set GROQ_API_KEY=sua_chave_real_aqui

# Linux/Mac
export GROQ_API_KEY="sua_chave_real_aqui"
```

### 3️⃣ **Importar no Eclipse**
1. Abra o Eclipse
2. File → Import → Existing Projects into Workspace
3. Selecione a pasta do projeto
4. ✅ O projeto deve aparecer sem erros (configurado para Java 11)

### 4️⃣ **Configurar Tomcat (se necessário)**
1. Window → Preferences → Server → Runtime Environments
2. Add → Apache Tomcat v11.0
3. Aponte para a pasta de instalação do Tomcat

### 5️⃣ **Executar o Projeto**
1. Right-click no projeto → Run As → Run on Server
2. Selecione o Tomcat 11.0
3. O projeto deve abrir no browser

## 🧪 Testar a API

### Teste Rápido via Classe de Teste
1. Execute a classe `GroqApiTest.java` como Java Application
2. Deve mostrar:
   ```
   === Testing Groq API Client ===
   API Key loaded: Yes (length: XX)
   
   === Testing API Call ===
   SUCCESS! AI Response: [resposta da IA]
   ```

### Teste via Interface Web
1. Acesse: `http://localhost:8080/FitNutri-POA`
2. Use a funcionalidade de chat
3. Deve receber respostas da IA

## 🛠️ Configurações do Projeto (Já Incluídas)

### ✅ Configurações de Java
- **Versão**: Java 11 (compatível com a maioria dos ambientes)
- **Facets**: Web 5.0, Java 11
- **Build Path**: Configurado para JavaSE-11

### ✅ Dependências Incluídas
- Apache HttpClient (para chamadas HTTP)
- JSON Library (para parsing de JSON)
- Jakarta Servlet API (para web services)

### ✅ Estrutura do Projeto
```
FitNutri-POA/
├── src/main/java/com/fitnutri/
│   ├── ConfigurationManager.java     # Gerencia configurações
│   ├── GroqApiClient.java           # Cliente da API Groq
│   ├── GroqApiException.java        # Tratamento de erros
│   ├── servlet/GroqServlet.java     # Endpoint web
│   └── test/GroqApiTest.java        # Teste da API
├── src/main/resources/
│   └── config.properties.example    # Configurações de exemplo
└── WebContent/                      # Arquivos web (HTML, CSS, JS)
```

## ❗ Solução de Problemas Comuns

### 🔧 Erro: "Project facet Java version X is not supported"
**Causa:** Versão do Java configurada no projeto não está instalada
**Solução:** O projeto já está configurado para Java 11. Verifique se você tem Java 11 instalado.

### 🔧 Erro: "config.properties not found"
**Causa:** Arquivo de configuração não foi criado
**Solução:** 
1. Copie `config.properties.example` para `config.properties`
2. Configure sua chave da API

### 🔧 Erro: "API key not found"
**Causa:** Chave da API não está configurada
**Solução:** Configure a chave usando uma das opções do passo 2️⃣

### 🔧 Erro: "Error communicating with AI service"
**Causas possíveis:**
- Chave da API inválida ou expirada
- Sem conexão com a internet
- Limite de uso da API atingido

**Solução:**
1. Verifique se a chave está correta
2. Teste a conectividade
3. Verifique os logs do servidor para mais detalhes

### 🔧 Projeto não aparece no servidor
**Causa:** Facets não configuradas corretamente
**Solução:** As configurações já estão incluídas no repositório. Se ainda assim der problema:
1. Right-click no projeto → Properties → Project Facets
2. Verifique se Java 11 e Web 5.0 estão marcados

## 📊 Status das Configurações

| Componente | Status | Observações |
|------------|--------|-------------|
| ✅ Configurações Java 11 | Incluído | Compatível com maioria dos ambientes |
| ✅ Facets do projeto | Incluído | Web 5.0 + Java 11 |
| ✅ Build path | Incluído | Tomcat 11.0 + bibliotecas |
| ✅ Estrutura do projeto | Incluído | Código fonte completo |
| ✅ Arquivo de exemplo | Incluído | `config.properties.example` |
| ❌ Chave da API | **VOCÊ DEVE CONFIGURAR** | Seguir passo 2️⃣ |

## 🔐 Segurança

- ⚠️ **NUNCA** commite o arquivo `config.properties` com chaves reais
- ✅ Use variáveis de ambiente em produção
- ✅ O `.gitignore` já está configurado para proteger suas chaves
- ✅ Sempre use o arquivo `.example` como template

## 🤝 Suporte

Se encontrar algum problema:
1. Verifique se seguiu todos os passos do **Configuração Rápida**
2. Execute o teste da API (`GroqApiTest.java`)
3. Verifique os logs do Tomcat/Eclipse
4. Entre em contato com o desenvolvedor

---
**Criado com ❤️ para facilitar o setup do projeto FitNutri-POA**
