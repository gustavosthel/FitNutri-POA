<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>FitNutri - AI Nutrition Assistant</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .chat-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .chat-header {
            background-color: #4CAF50;
            color: white;
            padding: 15px;
            text-align: center;
        }
        #chat-history {
            height: 400px;
            overflow-y: auto;
            padding: 15px;
        }
        .message {
            margin-bottom: 15px;
            padding: 10px 15px;
            border-radius: 18px;
            max-width: 80%;
            word-wrap: break-word;
        }
        .user-message {
            background-color: #DCF8C6;
            margin-left: auto;
            text-align: right;
        }
        .ai-message {
            background-color: #E8E8E8;
        }
        .ai-message-content {
            line-height: 1.5;
        }
        .ai-message-content h1, 
        .ai-message-content h2, 
        .ai-message-content h3 {
            margin-top: 0.5em;
            margin-bottom: 0.5em;
        }
        .ai-message-content p {
            margin-bottom: 1em;
        }
        .ai-message-content ul, 
        .ai-message-content ol {
            margin-left: 1.5em;
            margin-bottom: 1em;
        }
        .ai-message-content li {
            margin-bottom: 0.5em;
        }
        .ai-message-content code {
            background-color: #f0f0f0;
            padding: 2px 4px;
            border-radius: 3px;
            font-family: monospace;
        }
        .ai-message-content pre {
            background-color: #f5f5f5;
            padding: 10px;
            border-radius: 5px;
            overflow-x: auto;
            margin-bottom: 1em;
        }
        .ai-message-content blockquote {
            border-left: 3px solid #ccc;
            margin-left: 0;
            padding-left: 1em;
            color: #555;
        }
        .input-area {
            padding: 15px;
            border-top: 1px solid #eee;
            display: flex;
        }
        #user-input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 20px;
            resize: none;
            height: 50px;
        }
        button {
            margin-left: 10px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 20px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        .model-selector {
            padding: 10px 15px;
            background-color: #f9f9f9;
            border-bottom: 1px solid #eee;
        }
        select {
            padding: 5px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }
        .typing-indicator {
            display: flex;
            padding: 10px 15px;
        }
        .typing-dot {
            width: 8px;
            height: 8px;
            background-color: #999;
            border-radius: 50%;
            margin: 0 2px;
            animation: typingAnimation 1.4s infinite ease-in-out;
        }
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
        <div class="chat-header">
            <h2>Nutrition AI Assistant</h2>
        </div>
        
        <div class="model-selector">
            <label for="model-select">Select AI Model: </label>
            <select id="model-select">
                <option value="llama-3.1-8b-instant" selected>Llama 3.1 8B (Fast)</option>
                <option value="llama-3.1-70b-versatile">Llama 3.1 70B (Smart)</option>
                <option value="llama-3.2-1b-preview">Llama 3.2 1B (Lightweight)</option>
                <option value="llama-3.2-3b-preview">Llama 3.2 3B (Balanced)</option>
                <option value="mixtral-8x7b-32768">Mixtral 8x7B (Legacy)</option>
                <option value="claude-3-sonnet-20240229">Claude 3 Sonnet</option>
            </select>
        </div>
                
        <div id="chat-history">
            <div class="message ai-message">
                <div class="ai-message-content">
                    <p>Olá! Sou sua assistente de nutrição. Como posso ajudar você com suas dúvidas sobre dieta ou nutrição hoje?</p>
                </div>
            </div>
        </div>
        
        <div class="input-area">
            <textarea id="user-input" rows="3" placeholder="Ask about nutrition..."></textarea>
            <button onclick="sendMessage()">Send</button>
        </div>
    </div>

    <script>
    // Função para converter Markdown para HTML
    function markdownToHtml(markdown) {
        if (!markdown) return '';
        
        // Substitui quebras de linha
        let html = markdown.replace(/\n/g, '<br>');
        
        // Headers
        html = html.replace(/^###### (.*$)/gim, '<h6>$1</h6>');
        html = html.replace(/^##### (.*$)/gim, '<h5>$1</h5>');
        html = html.replace(/^#### (.*$)/gim, '<h4>$1</h4>');
        html = html.replace(/^### (.*$)/gim, '<h3>$1</h3>');
        html = html.replace(/^## (.*$)/gim, '<h2>$1</h2>');
        html = html.replace(/^# (.*$)/gim, '<h1>$1</h1>');
        
        // Bold e Italic
        html = html.replace(/\*\*(.*?)\*\*/gim, '<strong>$1</strong>');
        html = html.replace(/\*(.*?)\*/gim, '<em>$1</em>');
        
        // Listas
        html = html.replace(/^\s*\- (.*$)/gim, '<li>$1</li>');
        html = html.replace(/(<li>.*<\/li>)/gim, '<ul>$1</ul>');
        
        // Links
        html = html.replace(/\[([^\[]+)\]\(([^\)]+)\)/gim, '<a href="$2">$1</a>');
        
        // Blocos de código
        html = html.replace(/```([^`]+)```/gim, '<pre><code>$1</code></pre>');
        html = html.replace(/`([^`]+)`/gim, '<code>$1</code>');
        
        // Citações
        html = html.replace(/^>\s(.*$)/gim, '<blockquote>$1</blockquote>');
        
        return html;
    }
    
    // Função para escapar HTML (segurança XSS)
    function escapeHtml(unsafe) {
        if (!unsafe) return '';
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }
    
    // Função para criar indicador de digitação
    function createTypingIndicator() {
        return $('<div class="message ai-message typing-indicator-container"></div>').append(
            $('<div class="typing-indicator"></div>').append(
                $('<div class="typing-dot"></div>'),
                $('<div class="typing-dot"></div>'),
                $('<div class="typing-dot"></div>')
            )
        );
    }
    
    function sendMessage() {
        const message = $('#user-input').val().trim();
        const model = $('#model-select').val();
        
        if (!message) return;
        
        // Adiciona mensagem do usuário ao chat
        $('#chat-history').append(
            '<div class="message user-message">' + escapeHtml(message) + '</div>'
        );
        
        $('#user-input').val('');
        scrollToBottom();
        
        // Mostra indicador de digitação
        const typingIndicator = createTypingIndicator();
        $('#chat-history').append(typingIndicator);
        scrollToBottom();
        
        // Envia para o servidor
        $.post('groq-chat', { message: message, model: model })
            .done(function(data) {
                typingIndicator.remove();
                
                // Converte markdown para HTML e adiciona ao chat
                const formattedResponse = markdownToHtml(data.response);
                $('#chat-history').append(
                    '<div class="message ai-message">' + 
                    '<div class="ai-message-content">' + formattedResponse + '</div>' +
                    '</div>'
                );
                scrollToBottom();
            })
            .fail(function(xhr) {
                typingIndicator.remove();
                let errorMsg = "Error communicating with AI service";
                try {
                    const errorData = JSON.parse(xhr.responseText);
                    if (errorData.error) errorMsg = errorData.error;
                } catch (e) {}
                
                $('#chat-history').append(
                    '<div class="message ai-message">' + 
                    '<div class="ai-message-content" style="color: red;">' + 
                    errorMsg + 
                    '</div></div>'
                );
                scrollToBottom();
            });
    }
    
    function scrollToBottom() {
        const chatHistory = document.getElementById('chat-history');
        chatHistory.scrollTop = chatHistory.scrollHeight;
    }
    
    // Permite enviar mensagem com Enter (Shift+Enter para nova linha)
    $('#user-input').on('keydown', function(e) {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            sendMessage();
        }
    });
    
    // Foca no campo de input ao carregar a página
    $(document).ready(function() {
        $('#user-input').focus();
    });
    </script>
</body>
</html>