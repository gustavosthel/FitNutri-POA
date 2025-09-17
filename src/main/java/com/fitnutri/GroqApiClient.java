package com.fitnutri;

import java.io.IOException;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;

public class GroqApiClient {
	private final CloseableHttpClient httpClient;
	
	public GroqApiClient () {
		this.httpClient = HttpClients.createDefault();
	}
	
	public String sendMessage(String message, String model) throws GroqApiException {
        String apiKey = ConfigurationManager.getApiKey();
        if (apiKey == null || apiKey.trim().isEmpty()) {
            throw new GroqApiException("API key not found. Please set GROQ_API_KEY environment variable or configure in config.properties");
        }
        
        String apiUrl = "https://api.groq.com/openai/v1/chat/completions";
        HttpPost post = new HttpPost(apiUrl);
        
        // definindo headers
        post.setHeader("Authorization", "Bearer " + apiKey);
        post.setHeader("Content-Type", "application/json");
        
        try {
        	// Create request body
        	JSONObject requestBody = new JSONObject();
        	requestBody.put("model", model != null ? model : "llama-3.1-8b-instant");
        	
        	JSONArray messages = new JSONArray();
        	JSONObject messageObj = new JSONObject();
        	messageObj.put("role", "user");
        	messageObj.put("content", message);
        	messages.put(messageObj);
        	
        	requestBody.put("messages", messages);
        	requestBody.put("temperature", 0.5);
        	requestBody.put("max_tokens", 1024);
        	requestBody.put("top_p", 1);
        	requestBody.put("stream", false);
        	
        	post.setEntity(new StringEntity(requestBody.toString()));
        	
        	// request de execução
        	HttpResponse response = httpClient.execute(post);
        	return handleResponse(response);
        }catch (Exception e) {
        	throw new GroqApiException("Comunicação com a API Groq falhou: " + e.getMessage());
        }
	}
	
	// Pré-processamento das respostas
	private String preprocessResponse(String response) {
	    if (response == null) return "";
	    
	    // Remove caracteres problemáticos comuns
	    response = response.replaceAll("[\\x00-\\x1F\\x7F]", "");
	    
	    // Normaliza espaços em branco
	    response = response.replaceAll("\\s+", " ");
	    
	    return response.trim();
	}
	
	private String handleResponse(HttpResponse response) throws IOException, GroqApiException {
        int statusCode = response.getStatusLine().getStatusCode();
        String responseBody = EntityUtils.toString(response.getEntity());
        
        if (statusCode == 200) {
            JSONObject jsonResponse = new JSONObject(responseBody);
            JSONArray choices = jsonResponse.getJSONArray("choices");
            if (choices.length() > 0) {
                JSONObject firstChoice = choices.getJSONObject(0);
                JSONObject message = firstChoice.getJSONObject("message");
                String content = message.getString("content");
                return preprocessResponse(content);
            }
            throw new IOException("Nenhuma resposta da API");
        } else {
            System.err.println("Groq API error: " + statusCode + " - " + responseBody);
            throw new GroqApiException("API Request falhou com status: " + statusCode);
        }
    }
    
    public void close() throws IOException {
        httpClient.close();
    }
}
