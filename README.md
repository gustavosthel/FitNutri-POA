# 🥗 FitNutri-POA - Assistente de Nutrição com IA

Um sistema inteligente de nutrição e fitness que utiliza IA para fornecer recomendações personalizadas de alimentação e saúde.

## 📋 Índice

- [Sobre o Projeto](#sobre-o-projeto)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Funcionalidades](#funcionalidades)
- [Pré-requisitos](#pré-requisitos)
- [Instalação](#instalação)
- [Configuração](#configuração)
- [Como Usar](#como-usar)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [API](#api)
- [Modelos de IA Disponíveis](#modelos-de-ia-disponíveis)
- [Contribuição](#contribuição)
- [Licença](#licença)

## 🎯 Sobre o Projeto

FitNutri-POA é uma aplicação web desenvolvida em Java que integra com a API da Groq para fornecer um assistente inteligente de nutrição. O sistema permite que os usuários façam perguntas sobre alimentação, dieta, nutrição e recebam respostas personalizadas e baseadas em evidências científicas.

### Principais Características:
- 🤖 **IA Conversacional**: Integração com modelos avançados da Groq
- 🍎 **Foco em Nutrição**: Especializado em questões de alimentação e saúde
- 🌐 **Interface Web**: Interface moderna e responsiva
- ⚡ **Múltiplos Modelos**: Suporte a diferentes modelos de IA
- 🔒 **Segurança**: Configuração segura de chaves de API

## 🛠️ Tecnologias Utilizadas

### Backend:
- **Java 11** - Linguagem de programação principal
- **Jakarta EE** - Framework web (Servlets, JSP)
- **Apache Tomcat 11** - Servidor de aplicação
- **Apache HTTP Client 4.5** - Cliente HTTP para integração com APIs
- **JSON** - Manipulação de dados JSON
- **SLF4J** - Sistema de logging

### Frontend:
- **HTML5/CSS3** - Estrutura e estilização
- **JavaScript/jQuery** - Interatividade
- **Bootstrap** (opcional) - Framework CSS
- **AJAX** - Comunicação assíncrona

### APIs Externas:
- **Groq API** - Serviços de IA conversacional

## 🚀 Funcionalidades

- ✅ **Chat com IA**: Converse com o assistente sobre nutrição
- ✅ **Múltiplos Modelos**: Escolha entre diferentes modelos de IA
- ✅ **Configuração de Objetivos**: Defina suas metas de saúde
- ✅ **Recomendações Personalizadas**: Sugestões baseadas no seu perfil
- ✅ **Interface Responsiva**: Funciona em desktop e mobile
- ✅ **Histórico de Conversas**: Mantenha o contexto das conversas
- ✅ **Validação de Entrada**: Sanitização e validação de dados

## 📋 Pré-requisitos

Antes de começar, certifique-se de ter:

- **Java JDK 11** ou superior
- **Apache Tomcat 11** ou superior
- **Eclipse IDE** (recomendado) ou IntelliJ IDEA
- **Conta na Groq** para obter a chave da API
- **Navegador web moderno**

## 🚀 Setup Rápido (5 minutos)

### **Opção 1: Script Automático (Recomendado)**
```powershell
# Execute o script de configuração
.\setup.ps1
```

### **Opção 2: Configuração Manual**
```bash
# 1. Clone o repositório
git clone https://github.com/gabrielteixeira021/FitNutri-POA.git
cd FitNutri-POA

# 2. Copie o arquivo de configuração
copy src\main\resources\config.properties.example src\main\resources\config.properties

# 3. Configure sua chave da API Groq
# Edite o arquivo config.properties e substitua "SUA_CHAVE_GROQ_AQUI"

# 4. Importe no Eclipse
# File → Import → Existing Projects into Workspace

# 5. Execute no Tomcat
# Right-click → Run As → Run on Server
```

## ✅ Configurações Já Incluídas

- ✅ **Facets do Eclipse**: Java 11 + Web 5.0 (pré-configuradas)
- ✅ **Build Path**: JavaSE-11 + dependências (pré-configurado)
- ✅ **Projeto Eclipse**: `.project`, `.classpath`, `.settings` (incluídos)
- ✅ **Dependências**: Apache HttpClient, JSON, Jakarta Servlet
- ✅ **Segurança**: `.gitignore` protege chaves da API

## 🔧 Configuração da Chave API (Único passo necessário)

### **Opção A - Arquivo de configuração (Recomendado):**
1. Copie o template:
   ```bash
   copy src\main\resources\config.properties.example src\main\resources\config.properties
   ```
2. Edite `src/main/resources/config.properties`
3. Substitua `SUA_CHAVE_GROQ_AQUI` pela sua chave real da API Groq

### **Opção B - Variável de ambiente (Mais seguro):**
```powershell
# Windows (PowerShell)
$env:GROQ_API_KEY = "sua_chave_aqui"

# Windows (CMD)
set GROQ_API_KEY=sua_chave_aqui

# Linux/Mac
export GROQ_API_KEY="sua_chave_aqui"
```

> **💡 Dica:** As configurações do Eclipse, dependências e facets já estão incluídas no repositório!

## 🎮 Como Usar

### 1. Inicie o servidor:
1. Right-click no projeto → Run As → Run on Server
2. Selecione o Tomcat configurado
3. Aguarde a inicialização

### 2. Acesse a aplicação:
```
http://localhost:8080/FitNutri-POA/
```

### 3. Use o Chat:
1. Acesse a página do chat: `http://localhost:8080/FitNutri-POA/groq-chat.jsp`
2. Selecione o modelo de IA desejado
3. Digite suas perguntas sobre nutrição
4. Clique em "Send" ou pressione Enter

### Exemplos de perguntas:
- "Quais alimentos são ricos em proteína?"
- "Como criar uma dieta balanceada?"
- "Que vitaminas preciso para imunidade?"
- "Receitas saudáveis para ganho de massa muscular"

## 📁 Estrutura do Projeto

```
FitNutri-POA/
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/fitnutri/
│       │       ├── ConfigurationManager.java
│       │       ├── GroqApiClient.java
│       │       ├── GroqApiException.java
│       │       └── servlet/
│       │           └── GroqServlet.java
│       │
│       ├── resources/
│       │   └── config.properties
│       │
│       └── webapp/
│           ├── WEB-INF/
│           │   ├── web.xml
│           │   └── lib/
│           ├── css/
│           │   └── style.css
│           ├── js/
│           │   └── script.js
│           ├── index.jsp
│           ├── groq-chat.jsp
│           ├── goal-setup.jsp
│           ├── nutrition.jsp
│           └── activity.jsp
│
├── bin/                    # Classes compiladas
├── .settings/              # Configurações do Eclipse
├── .classpath             # Classpath do projeto
├── .project               # Configuração do projeto Eclipse
├── .gitignore             # Arquivos ignorados pelo Git
└── README.md              # Este arquivo
```

## 🔌 API

### Endpoint Principal:
```
POST /FitNutri-POA/groq-chat
```

### Parâmetros:
- `message` (string, obrigatório): A pergunta do usuário
- `model` (string, opcional): Modelo de IA a ser usado

### Resposta de Sucesso:
```json
{
  "response": "Resposta da IA aqui..."
}
```

### Resposta de Erro:
```json
{
  "error": "Descrição do erro"
}
```

## 🤖 Modelos de IA Disponíveis

| Modelo | Descrição | Velocidade | Qualidade |
|--------|-----------|------------|-----------|
| `llama-3.1-8b-instant` | Rápido e eficiente | ⚡⚡⚡ | ⭐⭐⭐ |
| `llama-3.1-70b-versatile` | Mais inteligente | ⚡⚡ | ⭐⭐⭐⭐⭐ |
| `llama-3.2-1b-preview` | Leve e econômico | ⚡⚡⚡ | ⭐⭐ |
| `llama-3.2-3b-preview` | Balanceado | ⚡⚡ | ⭐⭐⭐ |

## 🐛 Solução de Problemas

### Erro: "Serviço temporariamente indisponível"
- Verifique se a chave da API está configurada corretamente
- Confirme se o modelo selecionado está ativo
- Verifique a conectividade com a internet

### Erro: "HttpServlet não encontrado"
- Certifique-se de que o Tomcat está configurado no classpath
- Verifique se todas as dependências estão em WEB-INF/lib/

### Erro de compilação:
- Confirme que está usando Java 11+
- Verifique se todas as bibliotecas estão no classpath

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

### Padrões de Contribuição:
- Use nomes descritivos para commits
- Mantenha o código documentado
- Adicione testes quando necessário
- Siga as convenções de código Java

## 📝 Roadmap

- [ ] Sistema de usuários e autenticação
- [ ] Histórico persistente de conversas
- [ ] Integração com APIs de nutrição
- [ ] Calculadora de IMC e BMR
- [ ] Planos de refeição personalizados
- [ ] Notificações e lembretes
- [ ] App mobile React Native
- [ ] Dashboard administrativo

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 👨‍💻 Autores

**Gabriel Teixeira** - [gabrielteixeira021](https://github.com/gabrielteixeira021)

**Gustavo Shell** - [gustavosthel](https://github.com/gustavosthel)

**Nathaly Pereira** - [metataly](https://github.com/metataly)

**Davy Andrade** - [DavyAndrade](https://github.com/DavyAndrade )

## 📞 Suporte

Se você encontrar algum problema ou tiver sugestões, por favor:

1. Verifique as [Issues existentes](https://github.com/seu-usuario/FitNutri-POA/issues)
2. Crie uma nova issue se necessário
3. Entre em contato: [charlesgabriel102@gmail.com](mailto:charlesgabriel102@gmail.com)

---

⭐ **Se este projeto te ajudou, considere dar uma estrela!** ⭐

