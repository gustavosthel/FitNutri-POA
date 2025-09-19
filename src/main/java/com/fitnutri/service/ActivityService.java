package com.fitnutri.service;

import java.util.HashMap;
import java.util.Map;

import com.fitnutri.entity.ActivityEntity;

public class ActivityService {
	
	private final Map<String, Map<String, Double>> metValues = new HashMap<>();
    private final Map<String, String> activityNames = new HashMap<>();

    public ActivityService() {
        initializeMetValues();
        initializeActivityNames();
    }

    private void initializeMetValues() {
        metValues.put("running", Map.of("light", 6.0, "moderate", 8.0, "vigorous", 11.0));
        metValues.put("walking", Map.of("light", 3.0, "moderate", 4.0, "vigorous", 5.0));
        metValues.put("cycling", Map.of("light", 4.0, "moderate", 6.0, "vigorous", 8.0));
        metValues.put("swimming", Map.of("light", 6.0, "moderate", 8.0, "vigorous", 10.0));
        metValues.put("weightlifting", Map.of("light", 3.0, "moderate", 5.0, "vigorous", 6.0));
        metValues.put("yoga", Map.of("light", 2.0, "moderate", 3.0, "vigorous", 4.0));
        metValues.put("dancing", Map.of("light", 3.0, "moderate", 5.0, "vigorous", 7.0));
        metValues.put("soccer", Map.of("light", 5.0, "moderate", 7.0, "vigorous", 10.0));
    }

    private void initializeActivityNames() {
        activityNames.put("running", "🏃 Corrida");
        activityNames.put("walking", "🚶 Caminhada");
        activityNames.put("cycling", "🚴 Ciclismo");
        activityNames.put("swimming", "🏊 Natação");
        activityNames.put("weightlifting", "🏋️ Musculação");
        activityNames.put("yoga", "🧘 Yoga");
        activityNames.put("dancing", "💃 Dança");
        activityNames.put("soccer", "⚽ Futebol");
    }

    public ActivityEntity processActivity(String type, Integer duration, String intensity, Double weight) {
    	ActivityEntity activity = new ActivityEntity();
        activity.setType(type);
        activity.setName(activityNames.get(type));
        activity.setDuration(duration);
        activity.setIntensity(intensity);
        
        Double met = metValues.get(type).get(intensity);
        activity.setMet(met);
        
        Integer caloriesBurned = calculateCalories(met, weight, duration);
        activity.setCaloriesBurned(caloriesBurned);
        
        activity.setHeartRate(calculateHeartRate(intensity));
        activity.setSteps(calculateSteps(type, duration));
        
        // Simulação de integração com APIs externas
        try {
        	ActivityEntity apiActivity = integrateWithFitnessApis(type, duration);
            if (apiActivity != null) {
                activity.setCaloriesBurned(apiActivity.getCaloriesBurned());
                activity.setHeartRate(apiActivity.getHeartRate());
                activity.setSteps(apiActivity.getSteps());
                activity.setApiSource(apiActivity.getApiSource());
            } else {
                activity.setApiSource("Cálculo MET Local");
            }
        } catch (Exception e) {
            activity.setApiSource("Cálculo MET Local (APIs indisponíveis)");
        }
        
        return activity;
    }

    private Integer calculateCalories(Double met, Double weight, Integer duration) {
        return (int) Math.round((met * weight * duration) / 60);
    }

    private Integer calculateHeartRate(String intensity) {
        if ("light".equals(intensity)) {
            return 90 + (int) (Math.random() * 30);
        } else if ("moderate".equals(intensity)) {
            return 120 + (int) (Math.random() * 30);
        } else if ("vigorous".equals(intensity)) {
            return 150 + (int) (Math.random() * 40);
        } else {
            return 100;
        }
    }

    private Integer calculateSteps(String type, Integer duration) {
        if ("walking".equals(type)) return duration * 100;
        if ("running".equals(type)) return duration * 160;
        return 0;
    }

    private ActivityEntity integrateWithFitnessApis(String type, Integer duration) {
        // Simulação das integrações com APIs
        try {
            // Tentativa Google Fit
            return simulateGoogleFitIntegration(type, duration);
        } catch (Exception e) {
            try {
                // Fallback para Fitbit
                return simulateFitbitIntegration(type, duration);
            } catch (Exception ex) {
                return null;
            }
        }
    }

    private ActivityEntity simulateGoogleFitIntegration(String type, Integer duration) {
    	ActivityEntity activity = new ActivityEntity();
        activity.setCaloriesBurned((int) Math.round(duration * 8.5));
        activity.setHeartRate(130 + (int) (Math.random() * 30));
        activity.setSteps("running".equals(type) ? duration * 180 : duration * 120);
        activity.setApiSource("Google Fit API");
        return activity;
    }

    private ActivityEntity simulateFitbitIntegration(String type, Integer duration) {
    	ActivityEntity activity = new ActivityEntity();
        activity.setCaloriesBurned((int) Math.round(duration * 7.8));
        activity.setHeartRate(125 + (int) (Math.random() * 35));
        activity.setSteps("running".equals(type) ? duration * 170 : duration * 110);
        activity.setApiSource("Fitbit API");
        return activity;
    }

}
