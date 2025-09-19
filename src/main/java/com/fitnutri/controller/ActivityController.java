package com.fitnutri.controller;

import java.io.IOException;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fitnutri.entity.ActivityEntity;
import com.fitnutri.service.ActivityService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ActivityServlet")
public class ActivityController extends HttpServlet{
	
	private ActivityService activityService;

    @Override
    public void init() throws ServletException {
        this.activityService = new ActivityService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String type = request.getParameter("activity-type");
            Integer duration = Integer.parseInt(request.getParameter("activity-duration"));
            String intensity = request.getParameter("activity-intensity");
            Double weight = Double.parseDouble(request.getParameter("weight"));
            
            ActivityEntity activity = activityService.processActivity(type, duration, intensity, weight);
            
            request.setAttribute("ActivityEntity", activity);
            RequestDispatcher dispatcher = request.getRequestDispatcher("activity.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parâmetros inválidos");
        }
    }

}
