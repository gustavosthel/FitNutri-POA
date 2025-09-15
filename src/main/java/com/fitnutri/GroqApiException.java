package com.fitnutri;

@SuppressWarnings("serial")
public class GroqApiException extends Exception{
	public GroqApiException(String message) {
		super(message);
	}
	
	public GroqApiException(String message, Throwable cause) {
		super(message, cause);
	}
}
