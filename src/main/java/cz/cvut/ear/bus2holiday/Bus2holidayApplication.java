package cz.cvut.ear.bus2holiday;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.flyway.FlywayAutoConfiguration;

@SpringBootApplication(exclude = {FlywayAutoConfiguration.class})
public class Bus2holidayApplication {

    public static void main(String[] args) {
        System.out.println("=== DIAGNOSTIC: ENVIRONMENT VARIABLES ===");
        System.getenv().forEach((k, v) -> {
            String lower = k.toLowerCase();
            if (lower.contains("db") || lower.contains("postgres") || lower.contains("pg") || lower.contains("datasource") || lower.contains("port") || lower.contains("url")) {
                String value = (lower.contains("pass") || lower.contains("secret") || lower.contains("token")) ? "******" : v;
                System.out.println("  " + k + " = " + value);
            }
        });
        System.out.println("=========================================");
        SpringApplication.run(Bus2holidayApplication.class, args);
    }
}
