package cz.cvut.ear.bus2holiday.controller;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.fasterxml.jackson.databind.ObjectMapper;

import cz.cvut.ear.bus2holiday.TestContainerConfig;
import cz.cvut.ear.bus2holiday.dao.BusRepository;
import cz.cvut.ear.bus2holiday.dao.UserRepository;
import cz.cvut.ear.bus2holiday.dto.request.LoginRequest;
import cz.cvut.ear.bus2holiday.dto.response.AuthResponse;
import cz.cvut.ear.bus2holiday.model.Bus;
import cz.cvut.ear.bus2holiday.model.User;
import cz.cvut.ear.bus2holiday.model.enums.BusStatus;
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

@SpringBootTest
@Transactional
@AutoConfigureMockMvc
public class BusControllerIntegrationTest extends TestContainerConfig {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;
    @Autowired private BusRepository busRepo;
    @Autowired private UserRepository userRepo;
    @Autowired private PasswordEncoder passwordEncoder;

    private String adminToken;
    private String userToken;
    private Bus testBus;

    @BeforeEach
    void setUp() throws Exception {
        busRepo.deleteAll();
        userRepo.deleteAll();

        User admin = new User();
        admin.setEmail("admin@test.com");
        admin.setPasswordHash(passwordEncoder.encode("admin123"));
        admin.setFirstName("Admin");
        admin.setLastName("User");
        admin.setRole(UserRole.admin);
        userRepo.save(admin);

        User user = new User();
        user.setEmail("user@test.com");
        user.setPasswordHash(passwordEncoder.encode("pass123"));
        user.setFirstName("Regular");
        user.setLastName("User");
        user.setRole(UserRole.user);
        userRepo.save(user);

        adminToken = loginAndGetToken("admin@test.com", "admin123");
        userToken = loginAndGetToken("user@test.com", "pass123");

        testBus = new Bus();
        testBus.setModel("Volvo 9700");
        testBus.setManufacturer("Volvo");
        testBus.setRegistrationNumber("BUS-001");
        testBus.setYear((short) 2023);
        testBus.setTotalSeats(50);
        testBus.setSeatLayout("{}");
        testBus = busRepo.save(testBus);
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
    void getAllBuses_ShouldReturnList() throws Exception {
        mockMvc.perform(get("/api/buses").header("Authorization", userToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(1))
                .andExpect(jsonPath("$[0].model").value("Volvo 9700"));
    }

    @Test
    void getBusById_ShouldReturnBus() throws Exception {
        mockMvc.perform(get("/api/buses/" + testBus.getId()).header("Authorization", userToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.registrationNumber").value("BUS-001"));
    }

    @Test
    void createBus_AsAdmin_ShouldSucceed() throws Exception {
        Bus newBus = new Bus();
        newBus.setModel("Mercedes Tourismo");
        newBus.setManufacturer("Mercedes");
        newBus.setRegistrationNumber("BUS-002");
        newBus.setYear((short) 2024);
        newBus.setTotalSeats(45);
        newBus.setSeatLayout("{}");

        mockMvc.perform(
                        post("/api/buses")
                                .header("Authorization", adminToken)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(newBus)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.model").value("Mercedes Tourismo"));

        assertEquals(2, busRepo.count());
    }

    @Test
    void createBus_AsUser_ShouldFail403() throws Exception {
        Bus newBus = new Bus();
        newBus.setModel("Test");
        newBus.setManufacturer("Test");
        newBus.setRegistrationNumber("BUS-003");
        newBus.setYear((short) 2024);
        newBus.setTotalSeats(30);
        newBus.setSeatLayout("{}");

        mockMvc.perform(
                        post("/api/buses")
                                .header("Authorization", userToken)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(newBus)))
                .andExpect(status().isForbidden());
    }

    @Test
    void updateBusStatus_AsAdmin_ShouldSucceed() throws Exception {
        mockMvc.perform(
                        patch("/api/buses/" + testBus.getId() + "/status")
                                .header("Authorization", adminToken)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content("\"MAINTENANCE\""))
                .andExpect(status().isNoContent());

        Bus updated = busRepo.findById(testBus.getId()).orElseThrow();
        assertEquals(BusStatus.MAINTENANCE, updated.getStatus());
    }

    @Test
    void deleteBus_AsAdmin_ShouldSucceed() throws Exception {
        mockMvc.perform(delete("/api/buses/" + testBus.getId()).header("Authorization", adminToken))
                .andExpect(status().isNoContent());

        assertEquals(0, busRepo.count());
    }
}
