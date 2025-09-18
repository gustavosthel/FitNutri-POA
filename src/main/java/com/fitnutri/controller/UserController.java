package com.fitnutri.controller;

import com.fitnutri.entity.UserEntity;
import com.fitnutri.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/goal-setup")
public class UserController extends HttpServlet {
	
	private UserService userService = new UserService();
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
	        throws ServletException, IOException {
	    // Exibe o formulário quando acessado via GET
	    req.getRequestDispatcher("goal-setup.jsp").forward(req, resp);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserEntity user = new UserEntity();
        user.setAge(Integer.parseInt(req.getParameter("age")));
        user.setGender(req.getParameter("gender"));
        user.setWeight(Integer.parseInt(req.getParameter("weight")));
        user.setHeight(Integer.parseInt(req.getParameter("height")));
        user.setActivityLevel(Double.parseDouble(req.getParameter("activityLevel")));
        user.setGoal(req.getParameter("goal"));
        user.setTargetWeight(Integer.parseInt(req.getParameter("targetWeight")));
        user.setTimeline(Integer.parseInt(req.getParameter("timeline")));

        userService.calculateGoals(user);

        req.setAttribute("UserEntity", user);
        req.getRequestDispatcher("goal-setup.jsp").forward(req, resp);
    }

}
