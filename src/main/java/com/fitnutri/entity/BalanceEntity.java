package com.fitnutri.entity;

import java.time.LocalDate;

public class BalanceEntity {
    private Integer consumedCalories;
    private Integer burnedCalories;
    private Integer netBalance;
    private Integer dailyGoal;
    private Integer goalProgress;
    private String proteinPercentage;
    private String carbsPercentage;
    private String fatPercentage;
    private Integer weeklyDeficit;
    private Double estimatedWeightLoss;
    private LocalDate calculationDate;

    // Construtores, getters e setters
    public BalanceEntity() {
        this.calculationDate = LocalDate.now();
    }

    // Getters e setters para todos os campos
    public Integer getConsumedCalories() { return consumedCalories; }
    public void setConsumedCalories(Integer consumedCalories) { this.consumedCalories = consumedCalories; }
    
    public Integer getBurnedCalories() { return burnedCalories; }
    public void setBurnedCalories(Integer burnedCalories) { this.burnedCalories = burnedCalories; }
    
    public Integer getNetBalance() { return netBalance; }
    public void setNetBalance(Integer netBalance) { this.netBalance = netBalance; }
    
    public Integer getDailyGoal() { return dailyGoal; }
    public void setDailyGoal(Integer dailyGoal) { this.dailyGoal = dailyGoal; }
    
    public Integer getGoalProgress() { return goalProgress; }
    public void setGoalProgress(Integer goalProgress) { this.goalProgress = goalProgress; }
    
    public String getProteinPercentage() { return proteinPercentage; }
    public void setProteinPercentage(String proteinPercentage) { this.proteinPercentage = proteinPercentage; }
    
    public String getCarbsPercentage() { return carbsPercentage; }
    public void setCarbsPercentage(String carbsPercentage) { this.carbsPercentage = carbsPercentage; }
    
    public String getFatPercentage() { return fatPercentage; }
    public void setFatPercentage(String fatPercentage) { this.fatPercentage = fatPercentage; }
    
    public Integer getWeeklyDeficit() { return weeklyDeficit; }
    public void setWeeklyDeficit(Integer weeklyDeficit) { this.weeklyDeficit = weeklyDeficit; }
    
    public Double getEstimatedWeightLoss() { return estimatedWeightLoss; }
    public void setEstimatedWeightLoss(Double estimatedWeightLoss) { this.estimatedWeightLoss = estimatedWeightLoss; }
    
    public LocalDate getCalculationDate() { return calculationDate; }
    public void setCalculationDate(LocalDate calculationDate) { this.calculationDate = calculationDate; }
}