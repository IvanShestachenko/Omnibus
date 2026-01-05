package cz.cvut.ear.bus2holiday.controller;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.fasterxml.jackson.databind.ObjectMapper;

import cz.cvut.ear.bus2holiday.TestContainerConfig;
import cz.cvut.ear.bus2holiday.dao.RouteRepository;
import cz.cvut.ear.bus2holiday.dao.RouteStopRepository;
import cz.cvut.ear.bus2holiday.dao.TerminalRepository;
import cz.cvut.ear.bus2holiday.dao.UserRepository;
import cz.cvut.ear.bus2holiday.dto.request.LoginRequest;
import cz.cvut.ear.bus2holiday.dto.response.AuthResponse;
import cz.cvut.ear.bus2holiday.model.Route;
import cz.cvut.ear.bus2holiday.model.RouteStop;
import cz.cvut.ear.bus2holiday.model.Terminal;
import cz.cvut.ear.bus2holiday.model.User;
import cz.cvut.ear.bus2holiday.model.enums.UserRole;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

@SpringBootTest
@Transactional
@AutoConfigureMockMvc
public class RouteControllerIntegrationTest extends TestContainerConfig {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;
    @Autowired private RouteRepository routeRepo;
    @Autowired private RouteStopRepository stopRepo;
    @Autowired private TerminalRepository terminalRepo;
    @Autowired private UserRepository userRepo;
    @Autowired private PasswordEncoder passwordEncoder;

    private String adminToken;
    private Route testRoute;
    private Terminal testTerminal;

    @BeforeEach
    void setUp() throws Exception {
        stopRepo.deleteAll();
        routeRepo.deleteAll();
        terminalRepo.deleteAll();
        userRepo.deleteAll();

        User admin = new User();
        admin.setEmail("admin@test.com");
        admin.setPasswordHash(passwordEncoder.encode("admin123"));
        admin.setFirstName("Admin");
        admin.setLastName("User");
        admin.setRole(UserRole.admin);
        userRepo.save(admin);

        adminToken = loginAndGetToken("admin@test.com", "admin123");

        testTerminal = new Terminal();
        testTerminal.setName("Prague Central");
        testTerminal.setCity("Prague");
        testTerminal.setCountry("Czech Republic");
        testTerminal.setStreet("Main St");
        testTerminal.setBuildingNumber("1");
        testTerminal.setPostcode("11000");
        testTerminal.setLatitude(BigDecimal.valueOf(50.0));
        testTerminal.setLongitude(BigDecimal.valueOf(14.0));
        testTerminal = terminalRepo.save(testTerminal);

        testRoute = new Route();
        testRoute.setName("Prague - Brno");
        testRoute.setActive(true);
        testRoute = routeRepo.save(testRoute);
    }

    private String loginAndGetToken(String email, String password) throws Exception {
        MvcResult result =
                mockMvc.perform(
                                post("/api/auth/login")
                                        .contentType(MediaType.APPLICATION_JSON)
                                        .content(
                                                objectMapper.writeValueAsString(
                                                        new LoginRequest(email, password))))
                        .andExpect(status().isOk())
                        .andReturn();
        AuthResponse auth =
                objectMapper.readValue(
                        result.getResponse().getContentAsString(), AuthResponse.class);
        return "Bearer " + auth.accessToken();
    }

    @Test
    void getAllRoutes_ShouldReturnList() throws Exception {
        mockMvc.perform(get("/api/routes").header("Authorization", adminToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(1))
                .andExpect(jsonPath("$[0].name").value("Prague - Brno"));
    }

    @Test
    void getRouteById_ShouldReturnRoute() throws Exception {
        mockMvc.perform(get("/api/routes/" + testRoute.getId()).header("Authorization", adminToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.name").value("Prague - Brno"));
    }

    @Test
    void createRoute_AsAdmin_ShouldSucceed() throws Exception {
        Route newRoute = new Route();
        newRoute.setName("Brno - Ostrava");
        newRoute.setActive(true);

        mockMvc.perform(
                        post("/api/routes")
                                .header("Authorization", adminToken)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(newRoute)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.name").value("Brno - Ostrava"));

        assertEquals(2, routeRepo.count());
    }

    @Test
    void addStop_AsAdmin_ShouldSucceed() throws Exception {
        RouteStop stop = new RouteStop();
        stop.setTerminal(testTerminal);
        stop.setSequenceOrder(1);
        stop.setArrivalOffsetMinutes(0);
        stop.setDepartureOffsetMinutes(5);
        stop.setDistanceFromOrigin(BigDecimal.ZERO);

        mockMvc.perform(
                        post("/api/routes/" + testRoute.getId() + "/stops")
                                .header("Authorization", adminToken)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(stop)))
                .andExpect(status().isCreated());

        assertEquals(1, stopRepo.count());
    }

    @Test
    void deleteRoute_AsAdmin_ShouldSucceed() throws Exception {
        mockMvc.perform(
                        delete("/api/routes/" + testRoute.getId())
                                .header("Authorization", adminToken))
                .andExpect(status().isNoContent());

        assertEquals(0, routeRepo.count());
    }

    @Test
    void deleteRoute_AsAnonymous_ShouldFail401() throws Exception {
        mockMvc.perform(delete("/api/routes/" + testRoute.getId()))
                .andExpect(status().isUnauthorized());
    }
}
