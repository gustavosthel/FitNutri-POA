package com.fitnutri.entity;

import java.time.LocalDateTime;

public class ActivityEntity {
	
	private String type;
    private String name;
    private Integer duration;
    private String intensity;
    private Double met;
    private Integer caloriesBurned;
    private Integer heartRate;
    private Integer steps;
    private String apiSource;
    private LocalDateTime timestamp;
    
    // Construtores
    public ActivityEntity() {
        this.timestamp = LocalDateTime.now();
    }
    
    public ActivityEntity(String type, String name, Integer duration, String intensity, Double met, Integer caloriesBurned,
		Integer heartRate, Integer steps, String apiSource, LocalDateTime timestamp) {
		this.type = type;
		this.name = name;
		this.duration = duration;
		this.intensity = intensity;
		this.met = met;
		this.caloriesBurned = caloriesBurned;
		this.heartRate = heartRate;
		this.steps = steps;
		this.apiSource = apiSource;
		this.timestamp = timestamp;
    }



	// Getters e Setters
    
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public Integer getDuration() { return duration; }
    public void setDuration(Integer duration) { this.duration = duration; }
    
    public String getIntensity() { return intensity; }
    public void setIntensity(String intensity) { this.intensity = intensity; }
    
    public Double getMet() { return met; }
    public void setMet(Double met) { this.met = met; }
    
    public Integer getCaloriesBurned() { return caloriesBurned; }
    public void setCaloriesBurned(Integer caloriesBurned) { this.caloriesBurned = caloriesBurned; }
    
    public Integer getHeartRate() { return heartRate; }
    public void setHeartRate(Integer heartRate) { this.heartRate = heartRate; }
    
    public Integer getSteps() { return steps; }
    public void setSteps(Integer steps) { this.steps = steps; }
    
    public String getApiSource() { return apiSource; }
    public void setApiSource(String apiSource) { this.apiSource = apiSource; }
    
    public LocalDateTime getTimestamp() { return timestamp; }
    public void setTimestamp(LocalDateTime timestamp) { this.timestamp = timestamp; }

}
