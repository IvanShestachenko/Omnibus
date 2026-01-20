package cz.cvut.ear.bus2holiday;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.flyway.FlywayAutoConfiguration;

@SpringBootApplication(exclude = {FlywayAutoConfiguration.class})
public class Bus2holidayApplication {

    public static void main(String[] args) {
        SpringApplication.run(Bus2holidayApplication.class, args);
    }
}
