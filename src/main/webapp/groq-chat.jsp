<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Assistente Nutrição</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
      tailwind.config = {
        theme: {
          extend: {
            colors: {
              primary: "#6366F1", // Indigo
              secondary: "#4F46E5", // Indigo escuro
              accent: "#8B5CF6", // Roxo
              success: "#10B981", // Verde
              warning: "#F59E0B", // Amarelo
              danger: "#EF4444", // Vermelho
              neutral: "#F8FAFC", // Cinza muito claro
              dark: "#1E293B", // Azul escuro
            },
          },
        },
      };
    </script>

    <style>
      .chat-container {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      }
      #chat-history {
        height: 400px;
        overflow-y: auto;
        border: 1px solid #ddd;
        padding: 15px;
        margin-bottom: 15px;
        border-radius: 5px;
      }
      .message {
        margin-bottom: 15px;
        padding: 10px;
        border-radius: 8px;
      }
      .user-message {
        background: #e3f2fd;
        margin-left: 20%;
        text-align: right;
      }
      .ai-message {
        background: #f5f5f5;
        margin-right: 20%;
      }
      .ai-message-content {
        line-height: 1.6;
      }
      .ai-message-content h1,
      .ai-message-content h2,
      .ai-message-content h3 {
        margin: 0.5em 0;
        color: #2c3e50;
      }
      .ai-message-content p {
        margin: 0.8em 0;
      }
      .ai-message-content ul,
      .ai-message-content ol {
        margin: 0.8em 0;
        padding-left: 1.5em;
      }
      .ai-message-content li {
        margin: 0.4em 0;
      }
      .ai-message-content code {
        background: #f4f4f4;
        padding: 2px 6px;
        border-radius: 3px;
        font-family: "Courier New", monospace;
      }
      .ai-message-content pre {
        background: #2d2d2d;
        color: #f8f8f2;
        padding: 12px;
        border-radius: 5px;
        overflow-x: auto;
        margin: 1em 0;
        font-family: "Courier New", monospace;
      }
      .ai-message-content blockquote {
        border-left: 4px solid #4caf50;
        padding-left: 1em;
        margin: 1em 0;
        color: #555;
        font-style: italic;
      }
      .ai-message-content strong {
        font-weight: bold;
        color: #2c3e50;
      }
      .ai-message-content em {
        font-style: italic;
      }
      .input-area {
        display: flex;
        gap: 10px;
        margin-bottom: 15px;
      }
      #user-input {
        flex: 1;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 5px;
        resize: none;
        font-family: inherit;
      }
      button {
        padding: 12px 24px;
        background: #4caf50;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-weight: bold;
      }
      button:hover {
        background: #45a049;
      }
      .model-selector {
        margin-bottom: 15px;
      }
      select {
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
      }
      .typing-indicator {
        display: flex;
        padding: 10px;
      }
      .typing-dot {
        width: 8px;
        height: 8px;
        background: #999;
        border-radius: 50%;
        margin: 0 3px;
        animation: typingAnimation 1.4s infinite ease-in-out;
      }
      .typing-dot:nth-child(1) {
        animation-delay: 0s;
      }
      .typing-dot:nth-child(2) {
        animation-delay: 0.2s;
      }
      .typing-dot:nth-child(3) {
        animation-delay: 0.4s;
      }
      @keyframes typingAnimation {
        0%,
        60%,
        100% {
          transform: translateY(0);
        }
        30% {
          transform: translateY(-5px);
        }
      }
    </style>
  </head>

  <body>
    <nav class="bg-white shadow-lg fixed w-full top-0 z-50">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16">
          <div class="flex items-center">
            <div class="flex-shrink-0">
              <a
                href="index.jsp"
                class="text-2xl font-bold text-primary hover:text-secondary transition-colors"
              >
                💪 FitNutri AI
              </a>
            </div>
          </div>
          <div class="hidden md:block">
            <div class="ml-10 flex items-baseline space-x-4">
              <a
                href="index.jsp"
                class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors"
                >Início</a
              >
              <a
                href="goal-setup.jsp"
                class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors"
                >Metas</a
              >
              <a
                href="nutrition.jsp"
                class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors"
                >Nutrição</a
              >
              <a
                href="activity.jsp"
                class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors"
                >Atividades</a
              >
              <a
                href="balance.jsp"
                class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors"
                >Balanço</a
              >
              <a
                href="groq-chat.jsp"
                class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors"
                >IA Coach</a
              >
            </div>
          </div>
          <div class="md:hidden">
            <button id="mobile-menu-btn" class="text-dark hover:text-primary">
              <svg
                class="h-6 w-6"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M4 6h16M4 12h16M4 18h16"
                />
              </svg>
            </button>
          </div>
        </div>
      </div>
      <!-- Mobile menu -->
      <div id="mobile-menu" class="md:hidden hidden">
        <div class="px-2 pt-2 pb-3 space-y-1 sm:px-3 bg-white shadow-lg">
          <a
            href="index.jsp"
            class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left"
            >Início</a
          >
          <a
            href="goal-setup.jsp"
            class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left"
            >Metas</a
          >
          <a
            href="nutrition.jsp"
            class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left"
            >Nutrição</a
          >
          <a
            href="activity.jsp"
            class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left"
            >Atividades</a
          >
          <a
            href="balance.jsp"
            class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left"
            >Balanço</a
          >
          <a
            href="groq-chat.jsp"
            class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left"
            >IA Coach</a
          >
        </div>
      </div>
    </nav>

    <div class="chat-container mt-10 pt-10">
      <h2 style="color: #4caf50; text-align: center">
        🍎 Assistente de Nutrição FitNutri
      </h2>

      <div class="model-selector">
        <label for="model-select"><strong>Modelo de IA:</strong> </label>
        <select id="model-select">
          <option value="llama-3.1-8b-instant">Llama 3.1 8B</option>
          <option value="mixtral-8x7b-32768">Mixtral 8x7B</option>
          <option value="gemma-7b-it">Gemma 7B</option>
        </select>
      </div>

      <div id="chat-history">
        <div class="message ai-message">
          <div class="ai-message-content">
            <p>Olá! 👋 Sou seu assistente virtual de nutrição.</p>
            <p>Posso ajudar você com:</p>
            <ul>
              <li>📋 Planos alimentares personalizados</li>
              <li>💪 Orientação sobre suplementos</li>
              <li>🍎 Informações nutricionais</li>
              <li>🏋️ Dicas para seus objetivos fitness</li>
            </ul>
            <p>Como posso ajudar você hoje?</p>
          </div>
        </div>
      </div>

      <div class="input-area">
        <textarea
          id="user-input"
          rows="3"
          placeholder="Digite sua pergunta sobre nutrição..."
          onkeydown="if(event.key === 'Enter' && !event.shiftKey) { event.preventDefault(); enviarMensagem(); }"
        ></textarea>
        <button onclick="enviarMensagem()">Enviar</button>
      </div>

      <div style="text-align: center; font-size: 12px; color: #666">
        💡 Dica: Use Shift+Enter para nova linha | Enter para enviar
      </div>
    </div>

    <footer class="bg-dark text-white py-12">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid md:grid-cols-4 gap-8">
          <div class="md:col-span-2">
            <h3 class="text-2xl font-bold text-primary mb-4">💪 FitNutri AI</h3>
            <p class="text-gray-300 mb-4">
              Plataforma inteligente que cruza alimentação e atividade física
              para gerar recomendações personalizadas baseadas em suas metas de
              saúde.
            </p>
            <div class="text-sm text-gray-400">
              <p>• 5 Servlets especializados</p>
              <p>• Balanço calórico em tempo real</p>
              <p>• IA Coach personalizado</p>
            </div>
          </div>
          <div>
            <h4 class="text-lg font-semibold mb-4">Servlets</h4>
            <ul class="space-y-2">
              <li>
                <a
                  href="goal-setup.jsp"
                  class="text-gray-300 hover:text-primary transition-colors"
                  >Goal Setup</a
                >
              </li>
              <li>
                <a
                  href="nutrition.jsp"
                  class="text-gray-300 hover:text-primary transition-colors"
                  >Nutrition Analyzer</a
                >
              </li>
              <li>
                <a
                  href="activity.jsp"
                  class="text-gray-300 hover:text-primary transition-colors"
                  >Activity Tracker</a
                >
              </li>
              <li>
                <a
                  href="balance.jsp"
                  class="text-gray-300 hover:text-primary transition-colors"
                  >Balance Engine</a
                >
              </li>
              <li>
                <a
                  href="groq-chat.jsp"
                  class="text-gray-300 hover:text-primary transition-colors"
                  >AI Coach</a
                >
              </li>
            </ul>
          </div>
          <div>
            <h4 class="text-lg font-semibold mb-4">APIs Integradas</h4>
            <ul class="space-y-2 text-gray-300">
              <li>🥗 Edamam Food API</li>
              <li>📊 USDA FoodData Central</li>
              <li>🏃 Google Fit API</li>
              <li>⌚ Fitbit API</li>
              <li>🤖 OpenAI GPT-4 API</li>
            </ul>
          </div>
        </div>
        <div class="border-t border-gray-700 mt-8 pt-8 text-center">
          <p class="text-gray-300">
            &copy; 2024 FitNutri AI. Sistema completo com 5 Servlets Java
            integrados às principais APIs de nutrição, fitness e IA do mercado.
          </p>
        </div>
      </div>
    </footer>

    <script src="js/script.js"></script>

    <script>
      // Função para formatar Markdown para HTML
      function formatarResposta(texto) {
        if (!texto) return "";

        // Substituições básicas de Markdown
        let html = texto
          // Headers
          .replace(/^##### (.*$)/gim, "<h5>$1</h5>")
          .replace(/^#### (.*$)/gim, "<h4>$1</h4>")
          .replace(/^### (.*$)/gim, "<h3>$1</h3>")
          .replace(/^## (.*$)/gim, "<h2>$1</h2>")
          .replace(/^# (.*$)/gim, "<h1>$1</h1>")

          // Negrito e Itálico
          .replace(/\*\*(.*?)\*\*/gim, "<strong>$1</strong>")
          .replace(/\*(.*?)\*/gim, "<em>$1</em>")

          // Listas
          .replace(/^\s*[-*] (.*$)/gim, "<li>$1</li>")
          .replace(/(<li>.*<\/li>)/gims, "<ul>$1</ul>")

          // Links
          .replace(
            /\[([^\]]+)\]\(([^)]+)\)/gim,
            '<a href="$2" target="_blank">$1</a>'
          )

          // Blocos de código
          .replace(/```([^`]+)```/gims, "<pre><code>$1</code></pre>")
          .replace(/`([^`]+)`/gim, "<code>$1</code>")

          // Citações
          .replace(/^> (.*$)/gim, "<blockquote>$1</blockquote>")

          // Quebras de linha (2 espaços no final da linha)
          .replace(/  \n/g, "<br>")

          // Parágrafos (linhas em branco)
          .replace(/\n\n/g, "</p><p>")
          .replace(/\n/g, "<br>");

        // Garantir que está envolto em parágrafos
        if (!html.startsWith("<")) {
          html = "<p>" + html + "</p>";
        }

        return html;
      }

      // Função para escapar HTML (segurança)
      function escapeHtml(texto) {
        if (!texto) return "";
        return texto
          .replace(/&/g, "&amp;")
          .replace(/</g, "&lt;")
          .replace(/>/g, "&gt;")
          .replace(/"/g, "&quot;")
          .replace(/'/g, "&#039;");
      }

      function enviarMensagem() {
        const mensagem = $("#user-input").val().trim();
        const modelo = $("#model-select").val();

        if (!mensagem) return;

        // Adicionar mensagem do usuário
        $("#chat-history").append(
          '<div class="message user-message">' + escapeHtml(mensagem) + "</div>"
        );

        $("#user-input").val("");
        scrollParaBaixo();

        // Mostrar indicador de digitação
        const indicador = $(
          '<div class="message ai-message">' +
            '<div class="typing-indicator">' +
            '<div class="typing-dot"></div>' +
            '<div class="typing-dot"></div>' +
            '<div class="typing-dot"></div>' +
            "</div></div>"
        );
        $("#chat-history").append(indicador);
        scrollParaBaixo();

        // Enviar para o servidor
        $.post("groq-chat", { message: mensagem, model: modelo })
          .done(function (data) {
            indicador.remove();

            // Formatar a resposta
            const respostaFormatada = formatarResposta(data.response);
            $("#chat-history").append(
              '<div class="message ai-message">' +
                '<div class="ai-message-content">' +
                respostaFormatada +
                "</div>" +
                "</div>"
            );
            scrollParaBaixo();
          })
          .fail(function (xhr) {
            indicador.remove();
            let erro = "Erro ao conectar com a API";
            try {
              const data = JSON.parse(xhr.responseText);
              if (data.error) erro = data.error;
            } catch (e) {}

            $("#chat-history").append(
              '<div class="message ai-message" style="color: #d32f2f;">' +
                "<strong>❌ Erro:</strong> " +
                escapeHtml(erro) +
                "</div>"
            );
            scrollParaBaixo();
          });
      }

      function scrollParaBaixo() {
        const chatHistory = document.getElementById("chat-history");
        chatHistory.scrollTop = chatHistory.scrollHeight;
      }

      // Focar no input ao carregar a página
      $(document).ready(function () {
        $("#user-input").focus();
      });
    </script>
  </body>
</html>
