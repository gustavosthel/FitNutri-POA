package com.fitnutri.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	
    	response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
        	String message = request.getParameter("message");
        	String model = request.getParameter("model");
        	
        	// Input validation
        	if (message == null || message.trim().isEmpty()) {
        		 response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                 out.write("{\"error\": \"Mensagem não pode estar vazia\"}");
                 return;
        	}
        	
        	// limpar o input
        	message = sanitizeInput(message);
        	
        	String groqResponse = groqClient.sendMessage(message, model);
        	
        	out.write("{\"response\": \"" + escapeJsonString(groqResponse) + "\"}");        	
        }catch (GroqApiException e) {
        	System.err.println("Erro na comunicação com a API: " + e.getMessage());
        	response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        	out.write("{\"error\": \"Serviço temporariamente indisponível\"}");
        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"error\": \"Um erro inexperado ocorreu\"}");
        }            
    }
    
    // funções auxiliares
    private String sanitizeInput(String input) {
    	// Basic HTML escaping to prevent XSS
    	return input.replace("&", "&amp;")
    			.replace("<", "&lt;")
    			.replace(">", "&gt;")
    			.replace("\"", "&quot;")
    			.replace("'", "&#x27;")
    			.replace("/", "&#x2F;");
    }
    
 // No método doPost do GroqServlet, modifique a parte de escape:
    private String escapeJsonString(String input) {
        if (input == null) return "";
        // Preserva quebras de linha e tabs, apenas escape aspas e barras
        return input.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\b", "\\b")
                   .replace("\f", "\\f");
        // Não escape \n e \r para preservar formatação
    }
    
    // função para fechar comunicação com a API
    public void destroy() {
    	try {
    		groqClient.close();
    	}catch(IOException e) {
    		System.err.println("Erro ao fechar o cliente HTTP: " + e.getMessage());
    	}
    }
}

