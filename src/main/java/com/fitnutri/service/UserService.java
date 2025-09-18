package com.fitnutri.service;

import com.fitnutri.entity.UserEntity;

public class UserService {
	
	 public void calculateGoals(UserEntity user) {
	        // BMR
	        double bmr;
	        if ("male".equalsIgnoreCase(user.getGender())) {
	            bmr = 88.362 + (13.397 * user.getWeight()) + (4.799 * user.getHeight()) - (5.677 * user.getAge());
	        } else {
	            bmr = 447.593 + (9.247 * user.getWeight()) + (3.098 * user.getHeight()) - (4.330 * user.getAge());
	        }
	        user.setBmr((int) Math.round(bmr));

	        // TDEE
	        double tdee = bmr * user.getActivityLevel();
	        user.setTdee((int) Math.round(tdee));

	        double adjustment = 0;
	        if ("weight-loss".equals(user.getGoal())) {
	            adjustment = -500;
	        } else if ("muscle-gain".equals(user.getGoal())) {
	            adjustment = +300;
	        }
	        user.setTargetCalories((int) Math.round(tdee + adjustment));
	    }

}
