package com.fitnutri.test;

import com.fitnutri.GroqApiClient;
import com.fitnutri.GroqApiException;
import com.fitnutri.ConfigurationManager;

public class GroqApiTest {
    public static void main(String[] args) {
        System.out.println("=== Testing Groq API Client ===");
        
        // Test configuration loading
        String apiKey = ConfigurationManager.getApiKey();
        System.out.println("API Key loaded: " + (apiKey != null ? "Yes (length: " + apiKey.length() + ")" : "No"));
        
        if (apiKey == null || apiKey.trim().isEmpty()) {
            System.err.println("ERROR: No API key found!");
            return;
        }
        
        // Test API call
        GroqApiClient client = new GroqApiClient();
        try {
            System.out.println("\n=== Testing API Call ===");
            String response = client.sendMessage("Hello, can you tell me a short joke?", null);
            System.out.println("SUCCESS! AI Response: " + response);
        } catch (GroqApiException e) {
            System.err.println("ERROR: " + e.getMessage());
        } finally {
            try {
                client.close();
            } catch (Exception e) {
                System.err.println("Error closing client: " + e.getMessage());
            }
        }
    }
}
