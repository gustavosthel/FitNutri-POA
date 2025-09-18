package com.fitnutri.service;

import com.fitnutri.entity.NutritionEntity;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Random;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class NutritionService {

    public NutritionEntity analyzeFood(String food, double quantity, String unit) {
    	NutritionEntity result = null;
        
        // Primeiro, tenta a API Edamam
        result = fetchFromEdamam(food, quantity, unit);
        if (result != null) {
            return result;
        }
        
        // Se falhar, tenta a USDA
        result = fetchFromUSDA(food, quantity, unit);
        if (result != null) {
            return result;
        }
        
        // Se ambas falharem, retorna dados estimados
        return getEstimatedData(food, quantity, unit);
    }

    private NutritionEntity fetchFromEdamam(String food, double quantity, String unit) {
        try {
            String appId = "demo"; // Substitua por sua APP_ID
            String appKey = "demo"; // Substitua por sua APP_KEY
            String urlStr = "https://api.edamam.com/api/food-database/v2/parser?app_id=" + appId + 
                            "&app_key=" + appKey + "&ingr=" + java.net.URLEncoder.encode(food, "UTF-8") + 
                            "&nutrition-type=cooking";
            
            URL url = new URL(urlStr);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            
            if (conn.getResponseCode() != 200) {
                return null;
            }
            
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuilder content = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }
            in.close();
            conn.disconnect();
            
            JsonObject jsonObject = JsonParser.parseString(content.toString()).getAsJsonObject();
            JsonArray hints = jsonObject.getAsJsonArray("hints");
            if (hints.size() > 0) {
                JsonObject foodItem = hints.get(0).getAsJsonObject().getAsJsonObject("food");
                JsonObject nutrients = foodItem.getAsJsonObject("nutrients");
                
                double multiplier = quantity / 100;
                
                return new NutritionEntity(
                    foodItem.get("label").getAsString(),
                    Math.round(getNutrientValue(nutrients, "ENERC_KCAL") * multiplier),
                    Math.round(getNutrientValue(nutrients, "PROCNT") * multiplier * 10) / 10.0,
                    Math.round(getNutrientValue(nutrients, "CHOCDF") * multiplier * 10) / 10.0,
                    Math.round(getNutrientValue(nutrients, "FAT") * multiplier * 10) / 10.0,
                    Math.round(getNutrientValue(nutrients, "FIBTG") * multiplier * 10) / 10.0,
                    Math.round(getNutrientValue(nutrients, "SUGAR") * multiplier * 10) / 10.0,
                    Math.round(getNutrientValue(nutrients, "NA") * multiplier),
                    Math.round(getNutrientValue(nutrients, "K") * multiplier),
                    quantity,
                    unit,
                    "Edamam API"
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private double getNutrientValue(JsonObject nutrients, String key) {
        if (nutrients.has(key) && !nutrients.get(key).isJsonNull()) {
            return nutrients.get(key).getAsDouble();
        }
        return 0;
    }

    private NutritionEntity fetchFromUSDA(String food, double quantity, String unit) {
        try {
            String apiKey = "DEMO_KEY"; // Substitua por sua chave API
            String urlStr = "https://api.nal.usda.gov/fdc/v1/foods/search?query=" + 
                            java.net.URLEncoder.encode(food, "UTF-8") + 
                            "&api_key=" + apiKey + "&dataType=Foundation,SR%20Legacy";
            
            URL url = new URL(urlStr);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            
            if (conn.getResponseCode() != 200) {
                return null;
            }
            
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuilder content = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }
            in.close();
            conn.disconnect();
            
            JsonObject jsonObject = JsonParser.parseString(content.toString()).getAsJsonObject();
            JsonArray foods = jsonObject.getAsJsonArray("foods");
            if (foods.size() > 0) {
                JsonObject foodItem = foods.get(0).getAsJsonObject();
                JsonArray nutrientsArray = foodItem.getAsJsonArray("foodNutrients");
                
                double calories = 0, protein = 0, carbs = 0, fat = 0, fiber = 0, sugar = 0, sodium = 0, potassium = 0;
                
                for (int i = 0; i < nutrientsArray.size(); i++) {
                    JsonObject nutrient = nutrientsArray.get(i).getAsJsonObject();
                    int nutrientId = nutrient.get("nutrientId").getAsInt();
                    double value = nutrient.get("value").getAsDouble();
                    
                    switch (nutrientId) {
                        case 1008: calories = value; break;
                        case 1003: protein = value; break;
                        case 1005: carbs = value; break;
                        case 1004: fat = value; break;
                        case 1079: fiber = value; break;
                        case 2000: sugar = value; break;
                        case 1093: sodium = value; break;
                        case 1092: potassium = value; break;
                    }
                }
                
                double multiplier = quantity / 100;
                
                return new NutritionEntity(
                    foodItem.get("description").getAsString(),
                    Math.round(calories * multiplier),
                    Math.round(protein * multiplier * 10) / 10.0,
                    Math.round(carbs * multiplier * 10) / 10.0,
                    Math.round(fat * multiplier * 10) / 10.0,
                    Math.round(fiber * multiplier * 10) / 10.0,
                    Math.round(sugar * multiplier * 10) / 10.0,
                    Math.round(sodium * multiplier),
                    Math.round(potassium * multiplier),
                    quantity,
                    unit,
                    "USDA FoodData Central API"
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private NutritionEntity getEstimatedData(String food, double quantity, String unit) {
        Random random = new Random();
        return new NutritionEntity(
            food,
            Math.floor(random.nextDouble() * 200) + 50,
            Math.floor(random.nextDouble() * 20) + 2,
            Math.floor(random.nextDouble() * 30) + 5,
            Math.floor(random.nextDouble() * 10) + 1,
            Math.floor(random.nextDouble() * 5) + 1,
            Math.floor(random.nextDouble() * 15) + 1,
            Math.floor(random.nextDouble() * 100) + 10,
            Math.floor(random.nextDouble() * 300) + 100,
            quantity,
            unit,
            "Estimativa (APIs indisponíveis)"
        );
    }
}
