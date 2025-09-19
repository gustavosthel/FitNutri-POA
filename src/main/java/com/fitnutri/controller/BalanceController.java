package com.fitnutri.controller;

import java.io.IOException;

import com.fitnutri.entity.BalanceEntity;
import com.fitnutri.service.BalanceService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/BalanceServlet")
public class BalanceController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private BalanceService balanceService;

    @Override
    public void init() throws ServletException {
        this.balanceService = new BalanceService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            BalanceEntity balance;
            
            // Verificar se temos parâmetros para cálculo personalizado
            String consumedParam = request.getParameter("consumed");
            String burnedParam = request.getParameter("burned");
            String goalParam = request.getParameter("goal");
            
            if (consumedParam != null && burnedParam != null && goalParam != null) {
                // Calcular com os parâmetros fornecidos
                int consumed = Integer.parseInt(consumedParam);
                int burned = Integer.parseInt(burnedParam);
                int goal = Integer.parseInt(goalParam);
                
                balance = balanceService.calculateBalance(consumed, burned, goal);
            } else {
                // Usar dados simulados
                balance = balanceService.getSimulatedBalance();
            }
            
            request.setAttribute("balance", balance);
            request.getRequestDispatcher("balance.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Erro no processamento dos dados");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
