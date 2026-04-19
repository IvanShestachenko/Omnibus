package cz.cvut.ear.bus2holiday;

import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;

public abstract class TestContainerConfig {

    @Container
    public static final PostgreSQLContainer<?> postgreSQLContainer =
            new PostgreSQLContainer<>("postgres:15-alpine")
                    .withDatabaseName("bus2holiday_test")
                    .withUsername("test")
                    .withPassword("test");

    static {
        postgreSQLContainer.start();
    }

    @DynamicPropertySource
    public static void setProperties(DynamicPropertyRegistry registry) {
        // Disable PostgreSQL prepared statement cache to prevent
        // "cached plan must not change result type" when ddl-auto=create-drop
        // recreates tables between Spring context loads.
        String jdbcUrl = postgreSQLContainer.getJdbcUrl() + "&preparedStatementCacheQueries=0";
        registry.add("spring.datasource.url", () -> jdbcUrl);
        registry.add("spring.datasource.username", postgreSQLContainer::getUsername);
        registry.add("spring.datasource.password", postgreSQLContainer::getPassword);
        registry.add("spring.flyway.enabled", () -> "false");
    }
}
