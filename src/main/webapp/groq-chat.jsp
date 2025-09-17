<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Assistente Nutrição</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body { font-family: Arial; max-width: 800px; margin: 0 auto; padding: 20px; }
        .chat-container { background: white; border-radius: 10px; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        #chat-history { height: 400px; overflow-y: auto; border: 1px solid #ddd; padding: 15px; margin-bottom: 15px; border-radius: 5px; }
        .message { margin-bottom: 10px; padding: 10px; border-radius: 5px; }
        .user-message { background: #e3f2fd; margin-left: 20%; text-align: right; }
        .ai-message { background: #f5f5f5; margin-right: 20%; }
        .input-area { display: flex; gap: 10px; }
        #user-input { flex: 1; padding: 10px; border: 1px solid #ddd; border-radius: 5px; resize: none; }
        button { padding: 10px 20px; background: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer; }
        button:hover { background: #45a049; }
        .error { color: red; }
    </style>
</head>
<body>
    <div class="chat-container">
        <h2>🍎 Assistente de Nutrição</h2>
        
        <div id="chat-history">
            <div class="message ai-message">
                Olá! Sou seu assistente de nutrição. Como posso ajudar?
            </div>
        </div>
        
        <div class="input-area">
            <textarea id="user-input" rows="3" placeholder="Pergunte sobre nutrição..."></textarea>
            <button onclick="enviarMensagem()">Enviar</button>
        </div>
        
        <div>
            <small>Modelo: 
                <select id="model-select">
                    <option value="llama-3.1-8b-instant">Llama 3.1 8B</option>
                    <option value="mixtral-8x7b-32768">Mixtral 8x7B</option>
                    <option value="gemma-7b-it">Gemma 7B</option>
                </select>
            </small>
        </div>
    </div>

    <script>
    function enviarMensagem() {
        const mensagem = $('#user-input').val().trim();
        const modelo = $('#model-select').val();
        
        if (!mensagem) return;
        
        // Adicionar mensagem do usuário
        $('#chat-history').append(
            '<div class="message user-message">' + mensagem + '</div>'
        );
        
        $('#user-input').val('');
        scrollToBottom();
        
        // Mostrar carregamento
        $('#chat-history').append(
            '<div class="message ai-message">💭 Pensando...</div>'
        );
        scrollToBottom();
        
        // Enviar para o servlet
        $.post('groq-chat', { message: mensagem, model: modelo })
            .done(function(data) {
                // Remover "Pensando..." e adicionar resposta
                $('#chat-history .message:last').remove();
                $('#chat-history').append(
                    '<div class="message ai-message">' + data.response + '</div>'
                );
                scrollToBottom();
            })
            .fail(function(xhr) {
                $('#chat-history .message:last').remove();
                let erro = "Erro ao conectar com a API";
                try {
                    const data = JSON.parse(xhr.responseText);
                    if (data.error) erro = data.error;
                } catch (e) {}
                
                $('#chat-history').append(
                    '<div class="message ai-message error">❌ ' + erro + '</div>'
                );
                scrollToBottom();
            });
    }
    
    function scrollToBottom() {
        $('#chat-history').scrollTop($('#chat-history')[0].scrollHeight);
    }
    
    // Enter para enviar, Shift+Enter para nova linha
    $('#user-input').on('keydown', function(e) {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            enviarMensagem();
        }
    });
    </script>
</body>
</html>