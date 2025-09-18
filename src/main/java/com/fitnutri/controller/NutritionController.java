package com.fitnutri.controller;

import com.fitnutri.entity.NutritionEntity;
import com.fitnutri.service.NutritionService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet("/nutrition-analyzer")
public class NutritionController extends HttpServlet {
    private NutritionService nutritionService = new NutritionService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String food = request.getParameter("food");
        double quantity = Double.parseDouble(request.getParameter("quantity"));
        String unit = request.getParameter("unit");
        
        NutritionEntity nutritionData = nutritionService.analyzeFood(food, quantity, unit);
        
        Gson gson = new Gson();
        String json = gson.toJson(nutritionData);
        
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
}
