package com.fitnutri.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.fitnutri.ConfigurationManager;
import com.fitnutri.GroqApiClient;
import com.fitnutri.GroqApiException;

@WebServlet("/groq-chat")
public class GroqServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private GroqApiClient groqClient;
    
    @Override
    public void init() throws ServletException {
        super.init();
        this.groqClient = new GroqApiClient();
        System.out.println("✅ GroqServlet inicializado");
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<h2>🧪 Teste do Servlet</h2>");
        out.println("<p>Status: ✅ Online</p>");
        out.println("<p>GroqClient: " + (groqClient != null ? "✅ Inicializado" : "❌ Nulo") + "</p>");
        
        // Teste da API Key
        String apiKey = ConfigurationManager.getApiKey();
        out.println("<p>API Key: " + (apiKey != null ? "✅ Presente" : "❌ Ausente") + "</p>");
        if (apiKey != null) {
            out.println("<p>Formato: " + (apiKey.startsWith("gsk_") ? "✅ Correto" : "❌ Errado") + "</p>");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            String message = request.getParameter("message");
            String model = request.getParameter("model");
            
            // ✅ Log para debugging
            System.out.println("📥 Recebido: message='" + message + "', model='" + model + "'");
            
            // Input validation
            if (message == null || message.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("{\"error\": \"Mensagem não pode estar vazia\"}");
                return;
            }
            
            // limpar o input
            message = sanitizeInput(message);
            
            String groqResponse = groqClient.sendMessage(message, model);
            
            // ✅ Log de sucesso
            System.out.println("✅ Resposta recebida: " + 
                (groqResponse != null ? groqResponse.length() + " caracteres" : "nula"));
            
            out.write("{\"response\": \"" + escapeJsonString(groqResponse) + "\"}");        	
            
        } catch (GroqApiException e) {
            System.err.println("❌ Erro na API Groq: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"error\": \"Serviço temporariamente indisponível: " + 
                     e.getMessage().replace("\"", "'") + "\"}");
            
        } catch (Exception e) {
            System.err.println("💥 Erro inesperado: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"error\": \"Erro interno do servidor\"}");
        }
    }
    
    // ✅ escapeJsonString CORRIGIDO
    private String escapeJsonString(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\b", "\\b")
                   .replace("\f", "\\f")
                   .replace("\n", "\\n")    // ✅ ADICIONADO
                   .replace("\r", "\\r")    // ✅ ADICIONADO
                   .replace("\t", "\\t");   // ✅ ADICIONADO
    }
    
    private String sanitizeInput(String input) {
        return input.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#x27;")
                   .replace("/", "&#x2F;");
    }
    
    @Override
    public void destroy() {
        try {
            if (groqClient != null) {
                groqClient.close();
                System.out.println("✅ GroqClient fechado");
            }
        } catch (IOException e) {
            System.err.println("❌ Erro ao fechar cliente: " + e.getMessage());
        }
    }
}