<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Assistente Nutrição</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body { font-family: Arial, sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; background-color: #f5f5f5; }
        .chat-container { background: white; border-radius: 10px; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        #chat-history { height: 400px; overflow-y: auto; border: 1px solid #ddd; padding: 15px; margin-bottom: 15px; border-radius: 5px; }
        .message { margin-bottom: 15px; padding: 10px; border-radius: 8px; }
        .user-message { background: #e3f2fd; margin-left: 20%; text-align: right; }
        .ai-message { background: #f5f5f5; margin-right: 20%; }
        .ai-message-content { line-height: 1.6; }
        .ai-message-content h1, .ai-message-content h2, .ai-message-content h3 { 
            margin: 0.5em 0; color: #2c3e50; 
        }
        .ai-message-content p { margin: 0.8em 0; }
        .ai-message-content ul, .ai-message-content ol { 
            margin: 0.8em 0; padding-left: 1.5em; 
        }
        .ai-message-content li { margin: 0.4em 0; }
        .ai-message-content code { 
            background: #f4f4f4; padding: 2px 6px; border-radius: 3px; 
            font-family: 'Courier New', monospace; 
        }
        .ai-message-content pre { 
            background: #2d2d2d; color: #f8f8f2; padding: 12px; 
            border-radius: 5px; overflow-x: auto; margin: 1em 0;
            font-family: 'Courier New', monospace; 
        }
        .ai-message-content blockquote { 
            border-left: 4px solid #4CAF50; padding-left: 1em; 
            margin: 1em 0; color: #555; font-style: italic; 
        }
        .ai-message-content strong { font-weight: bold; color: #2c3e50; }
        .ai-message-content em { font-style: italic; }
        .input-area { display: flex; gap: 10px; margin-bottom: 15px; }
        #user-input { flex: 1; padding: 12px; border: 1px solid #ddd; border-radius: 5px; resize: none; font-family: inherit; }
        button { padding: 12px 24px; background: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; }
        button:hover { background: #45a049; }
        .model-selector { margin-bottom: 15px; }
        select { padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .typing-indicator { display: flex; padding: 10px; }
        .typing-dot { width: 8px; height: 8px; background: #999; border-radius: 50%; margin: 0 3px; animation: typingAnimation 1.4s infinite ease-in-out; }
        .typing-dot:nth-child(1) { animation-delay: 0s; }
        .typing-dot:nth-child(2) { animation-delay: 0.2s; }
        .typing-dot:nth-child(3) { animation-delay: 0.4s; }
        @keyframes typingAnimation {
            0%, 60%, 100% { transform: translateY(0); }
            30% { transform: translateY(-5px); }
        }
    </style>
</head>
<body>
    <div class="chat-container">
        <h2 style="color: #4CAF50; text-align: center;">🍎 Assistente de Nutrição FitNutri</h2>
        
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
            <textarea id="user-input" rows="3" placeholder="Digite sua pergunta sobre nutrição..." 
                     onkeydown="if(event.key === 'Enter' && !event.shiftKey) { event.preventDefault(); enviarMensagem(); }"></textarea>
            <button onclick="enviarMensagem()">Enviar</button>
        </div>
        
        <div style="text-align: center; font-size: 12px; color: #666;">
            💡 Dica: Use Shift+Enter para nova linha | Enter para enviar
        </div>
    </div>

    <script>
    // Função para formatar Markdown para HTML
    function formatarResposta(texto) {
        if (!texto) return '';
        
        // Substituições básicas de Markdown
        let html = texto
            // Headers
            .replace(/^##### (.*$)/gim, '<h5>$1</h5>')
            .replace(/^#### (.*$)/gim, '<h4>$1</h4>')
            .replace(/^### (.*$)/gim, '<h3>$1</h3>')
            .replace(/^## (.*$)/gim, '<h2>$1</h2>')
            .replace(/^# (.*$)/gim, '<h1>$1</h1>')
            
            // Negrito e Itálico
            .replace(/\*\*(.*?)\*\*/gim, '<strong>$1</strong>')
            .replace(/\*(.*?)\*/gim, '<em>$1</em>')
            
            // Listas
            .replace(/^\s*[-*] (.*$)/gim, '<li>$1</li>')
            .replace(/(<li>.*<\/li>)/gims, '<ul>$1</ul>')
            
            // Links
            .replace(/\[([^\]]+)\]\(([^)]+)\)/gim, '<a href="$2" target="_blank">$1</a>')
            
            // Blocos de código
            .replace(/```([^`]+)```/gims, '<pre><code>$1</code></pre>')
            .replace(/`([^`]+)`/gim, '<code>$1</code>')
            
            // Citações
            .replace(/^> (.*$)/gim, '<blockquote>$1</blockquote>')
            
            // Quebras de linha (2 espaços no final da linha)
            .replace(/  \n/g, '<br>')
            
            // Parágrafos (linhas em branco)
            .replace(/\n\n/g, '</p><p>')
            .replace(/\n/g, '<br>');
        
        // Garantir que está envolto em parágrafos
        if (!html.startsWith('<')) {
            html = '<p>' + html + '</p>';
        }
        
        return html;
    }
    
    // Função para escapar HTML (segurança)
    function escapeHtml(texto) {
        if (!texto) return '';
        return texto
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#039;');
    }
    
    function enviarMensagem() {
        const mensagem = $('#user-input').val().trim();
        const modelo = $('#model-select').val();
        
        if (!mensagem) return;
        
        // Adicionar mensagem do usuário
        $('#chat-history').append(
            '<div class="message user-message">' + escapeHtml(mensagem) + '</div>'
        );
        
        $('#user-input').val('');
        scrollParaBaixo();
        
        // Mostrar indicador de digitação
        const indicador = $(
            '<div class="message ai-message">' +
            '<div class="typing-indicator">' +
            '<div class="typing-dot"></div>' +
            '<div class="typing-dot"></div>' +
            '<div class="typing-dot"></div>' +
            '</div></div>'
        );
        $('#chat-history').append(indicador);
        scrollParaBaixo();
        
        // Enviar para o servidor
        $.post('groq-chat', { message: mensagem, model: modelo })
            .done(function(data) {
                indicador.remove();
                
                // Formatar a resposta
                const respostaFormatada = formatarResposta(data.response);
                $('#chat-history').append(
                    '<div class="message ai-message">' +
                    '<div class="ai-message-content">' + respostaFormatada + '</div>' +
                    '</div>'
                );
                scrollParaBaixo();
            })
            .fail(function(xhr) {
                indicador.remove();
                let erro = "Erro ao conectar com a API";
                try {
                    const data = JSON.parse(xhr.responseText);
                    if (data.error) erro = data.error;
                } catch (e) {}
                
                $('#chat-history').append(
                    '<div class="message ai-message" style="color: #d32f2f;">' +
                    '<strong>❌ Erro:</strong> ' + escapeHtml(erro) +
                    '</div>'
                );
                scrollParaBaixo();
            });
    }
    
    function scrollParaBaixo() {
        const chatHistory = document.getElementById('chat-history');
        chatHistory.scrollTop = chatHistory.scrollHeight;
    }
    
    // Focar no input ao carregar a página
    $(document).ready(function() {
        $('#user-input').focus();
    });
    </script>
</body>
</html>