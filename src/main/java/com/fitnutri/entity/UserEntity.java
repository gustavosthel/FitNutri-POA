package com.fitnutri.entity;

public class UserEntity {
	
	private int age;
	private String gender;
	private int weight;
	private int height;
	private double activityLevel;
	private String goal;
	private int targetWeight;
	private int timeline;
	private int bmr;
	private int tdee;
	private int targetCalories;
	
	public UserEntity() {
	}
	
	public UserEntity(int age, String gender, int weight, int height, double activityLevel, String goal, int targetWeight,
			int timeline, int bmr, int tdee, int targetCalories) {
		this.age = age;
		this.gender = gender;
		this.weight = weight;
		this.height = height;
		this.activityLevel = activityLevel;
		this.goal = goal;
		this.targetWeight = targetWeight;
		this.timeline = timeline;
		this.bmr = bmr;
		this.tdee = tdee;
		this.targetCalories = targetCalories;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getWeight() {
		return weight;
	}

	public void setWeight(int weight) {
		this.weight = weight;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public double getActivityLevel() {
		return activityLevel;
	}

	public void setActivityLevel(double activityLevel) {
		this.activityLevel = activityLevel;
	}

	public String getGoal() {
		return goal;
	}

	public void setGoal(String goal) {
		this.goal = goal;
	}

	public int getTargetWeight() {
		return targetWeight;
	}

	public void setTargetWeight(int targetWeight) {
		this.targetWeight = targetWeight;
	}

	public int getTimeline() {
		return timeline;
	}

	public void setTimeline(int timeline) {
		this.timeline = timeline;
	}

	public int getBmr() {
		return bmr;
	}

	public void setBmr(int bmr) {
		this.bmr = bmr;
	}

	public int getTdee() {
		return tdee;
	}

	public void setTdee(int tdee) {
		this.tdee = tdee;
	}

	public int getTargetCalories() {
		return targetCalories;
	}

	public void setTargetCalories(int targetCalories) {
		this.targetCalories = targetCalories;
	}

}
