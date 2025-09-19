package com.fitnutri.controller;

import com.fitnutri.entity.NutritionEntity;
import com.fitnutri.service.NutritionService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/nutrition-analyzer")
public class NutritionController extends HttpServlet {
    private NutritionService nutritionService = new NutritionService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String food = request.getParameter("food");
            double quantity = Double.parseDouble(request.getParameter("quantity"));
            String unit = request.getParameter("unit");
            
            NutritionEntity nutritionData = nutritionService.analyzeFood(food, quantity, unit);
            
            request.setAttribute("nutritionData", nutritionData);
            
        } catch (Exception e) {
            request.setAttribute("error", "Erro ao processar a solicitação: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/nutrition.jsp").forward(request, response);
    }
}