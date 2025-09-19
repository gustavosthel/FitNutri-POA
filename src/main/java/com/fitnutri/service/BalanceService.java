package com.fitnutri.service;

import com.fitnutri.entity.BalanceEntity;
import java.time.LocalDate;
import java.util.Random;

public class BalanceService {
    
    public BalanceEntity calculateBalance(Integer consumedCalories, Integer burnedCalories, Integer dailyGoal) {
        BalanceEntity balance = new BalanceEntity();
        
        // Calcular valores básicos
        balance.setConsumedCalories(consumedCalories);
        balance.setBurnedCalories(burnedCalories);
        balance.setNetBalance(consumedCalories - burnedCalories);
        balance.setDailyGoal(dailyGoal);
        
        // Calcular progresso da meta (0-100%)
        int progress = (int) Math.round((consumedCalories / (double) dailyGoal) * 100);
        balance.setGoalProgress(Math.min(progress, 100));
        
        // Calcular distribuição de macros (simulado)
        balance.setProteinPercentage("75%");
        balance.setCarbsPercentage("55%");
        balance.setFatPercentage("45%");
        
        // Calcular déficit semanal (simulado)
        Random rand = new Random();
        int weeklyDeficit = -1050 + rand.nextInt(500) - 250; // Valor entre -800 e -1300
        balance.setWeeklyDeficit(weeklyDeficit);
        
        // Calcular perda de peso estimada (aproximadamente 1kg = 7700kcal)
        double estimatedLoss = weeklyDeficit / 7700.0;
        balance.setEstimatedWeightLoss(Math.round(estimatedLoss * 10.0) / 10.0);
        
        return balance;
    }
    
    // Método para simular dados se nenhum parâmetro for passado
    public BalanceEntity getSimulatedBalance() {
        Random rand = new Random();
        int consumed = 1247 + rand.nextInt(300) - 150; // Entre 1100 e 1400
        int burned = 423 + rand.nextInt(100) - 50;     // Entre 370 e 470
        int goal = 2000;
        
        return calculateBalance(consumed, burned, goal);
    }
}