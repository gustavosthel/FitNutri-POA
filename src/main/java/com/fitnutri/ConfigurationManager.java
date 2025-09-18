package com.fitnutri;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigurationManager {

	private static final Properties props = new Properties();
	
	static {
		try {
			ClassLoader classLoader = ConfigurationManager.class.getClassLoader();
			InputStream input = classLoader.getResourceAsStream("config.properties");
			if(input != null) {
				props.load(input);
				input.close();
			}else {
				System.err.println("config.properties not found in classpath");
			}		
		}catch (IOException e){
			System.err.println("Failed to load configuration: " + e.getMessage());
		}
	}
		
	public static String getProperty(String key) {
		return props.getProperty(key);
	}
	
	public static String getApiKey() {
		// verifica nas variaveis de ambiente 
		String envKey = System.getenv("GROQ_API_KEY");
		if(envKey != null && !envKey.trim().isEmpty()) {
			return envKey;
		}
		
		// Verifica nas propriedades do sistema
		String sysKey = System.getProperty("GROQ_API_KEY");
		if(sysKey != null && !sysKey.trim().isEmpty()) {
			return sysKey;
		}
		
		// Consulta o arquivo de propriedades "config.properties"
		return getProperty("groq.api.key");
	}
	
	public static void testApiKey() {
	    String key = getApiKey();
	    System.out.println("API Key: " + (key != null ? 
	        key.substring(0, Math.min(8, key.length())) + "..." : "NULA"));
	    System.out.println("Tamanho: " + (key != null ? key.length() : 0));
	    System.out.println("Formato: " + (key != null && key.startsWith("gsk_") ? "CORRETO" : "ERRADO"));
	}
}
