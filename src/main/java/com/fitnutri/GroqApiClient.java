package com.fitnutri;

import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Scanner;

public class GroqApiClient {
    
    public String sendMessage(String message, String model) throws GroqApiException {
        String apiKey = ConfigurationManager.getApiKey();
        
        if (apiKey == null || apiKey.trim().isEmpty()) {
            throw new GroqApiException("API key não configurada");
        }
        
        if (!apiKey.startsWith("gsk_")) {
            throw new GroqApiException("API key com formato inválido");
        }
        
        try {
            URL url = new URL("https://api.groq.com/openai/v1/chat/completions");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            
            // Configurar conexão
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Authorization", "Bearer " + apiKey);
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Accept", "application/json");
            connection.setDoOutput(true);
            
            // Criar JSON manualmente
            String jsonInputString = String.format(
                "{\"model\": \"%s\", \"messages\": [{\"role\": \"user\", \"content\": \"%s\"}], " +
                "\"temperature\": 0.7, \"max_tokens\": 1024, \"top_p\": 1, \"stream\": false}",
                (model != null ? model : "llama-3.1-8b-instant"),
                escapeJsonString(message)
            );
            
            System.out.println("📤 Enviando para Groq API: " + jsonInputString);
            
            // Enviar requisição
            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = jsonInputString.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }
            
            // Verificar resposta
            int responseCode = connection.getResponseCode();
            System.out.println("📥 Código de resposta: " + responseCode);
            
            if (responseCode == 200) {
                // Ler resposta
                try (Scanner scanner = new Scanner(connection.getInputStream(), StandardCharsets.UTF_8.name())) {
                    String responseBody = scanner.useDelimiter("\\A").next();
                    System.out.println("✅ Resposta recebida: " + responseBody);
                    
                    // Parse manual simples do JSON
                    return parseGroqResponse(responseBody);
                }
                
            } else if (responseCode == 401) {
                throw new GroqApiException("API Key inválida ou expirada");
            } else if (responseCode == 429) {
                throw new GroqApiException("Limite de requisições excedido");
            } else {
                throw new GroqApiException("Erro HTTP " + responseCode);
            }
            
        } catch (IOException e) {
            throw new GroqApiException("Erro de conexão: " + e.getMessage());
        }
    }
    
    private String parseGroqResponse(String responseBody) throws GroqApiException {
        try {
            // Parse manual simples - procura por "content"
            int contentStart = responseBody.indexOf("\"content\":\"") + 11;
            if (contentStart == -1) {
                throw new GroqApiException("Resposta da API em formato inválido");
            }
            
            int contentEnd = responseBody.indexOf("\"", contentStart);
            if (contentEnd == -1) {
                throw new GroqApiException("Resposta da API em formato inválido");
            }
            
            String content = responseBody.substring(contentStart, contentEnd);
            return content.replace("\\n", "\n").replace("\\\"", "\"");
            
        } catch (Exception e) {
            throw new GroqApiException("Erro ao processar resposta: " + e.getMessage());
        }
    }
    
    private String escapeJsonString(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }
    
    public void close() throws IOException {
        // Não precisa fechar nada nesta implementação
    }
}