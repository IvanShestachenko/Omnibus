package cz.cvut.ear.bus2holiday.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.fasterxml.jackson.databind.ObjectMapper;

import cz.cvut.ear.bus2holiday.TestContainerConfig;
import cz.cvut.ear.bus2holiday.dao.DriverRepository;
import cz.cvut.ear.bus2holiday.dao.UserRepository;
import cz.cvut.ear.bus2holiday.dto.request.LoginRequest;
import cz.cvut.ear.bus2holiday.dto.response.AuthResponse;
import cz.cvut.ear.bus2holiday.model.Driver;
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

import java.time.LocalDate;

@SpringBootTest
@Transactional
@AutoConfigureMockMvc
public class DriverControllerIntegrationTest extends TestContainerConfig {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;
    @Autowired private DriverRepository driverRepo;
    @Autowired private UserRepository userRepo;
    @Autowired private PasswordEncoder passwordEncoder;

    private String adminToken;
    private String driverToken;
    private User driverUser;
    private Driver testDriver;

    @BeforeEach
    void setUp() throws Exception {
        driverRepo.deleteAll();
        userRepo.deleteAll();

        User admin = new User();
        admin.setEmail("admin@test.com");
        admin.setPasswordHash(passwordEncoder.encode("admin123"));
        admin.setFirstName("Admin");
        admin.setLastName("User");
        admin.setRole(UserRole.admin);
        userRepo.save(admin);

        driverUser = new User();
        driverUser.setEmail("driver@test.com");
        driverUser.setPasswordHash(passwordEncoder.encode("driver123"));
        driverUser.setFirstName("John");
        driverUser.setLastName("Driver");
        driverUser.setRole(UserRole.driver);
        driverUser = userRepo.save(driverUser);

        testDriver = new Driver();
        testDriver.setUser(driverUser);
        testDriver.setLicenseNumber("DL-123456");
        testDriver.setLicenseExpiry(LocalDate.now().plusYears(2));
        testDriver.setAvailable(true);
        testDriver = driverRepo.save(testDriver);

        adminToken = loginAndGetToken("admin@test.com", "admin123");
        driverToken = loginAndGetToken("driver@test.com", "driver123");
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
    void getAllDrivers_AsAdmin_ShouldSucceed() throws Exception {
        mockMvc.perform(get("/api/drivers").header("Authorization", adminToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(1))
                .andExpect(jsonPath("$[0].licenseNumber").value("DL-123456"));
    }

    @Test
    void getAllDrivers_AsDriver_ShouldFail403() throws Exception {
        mockMvc.perform(get("/api/drivers").header("Authorization", driverToken))
                .andExpect(status().isForbidden());
    }

    @Test
    void getDriver_BySelf_ShouldSucceed() throws Exception {
        mockMvc.perform(
                        get("/api/drivers/" + driverUser.getId())
                                .header("Authorization", driverToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.firstName").value("John"));
    }

    @Test
    void updateAvailability_BySelf_ShouldSucceed() throws Exception {
        mockMvc.perform(
                        patch("/api/drivers/" + driverUser.getId() + "/availability")
                                .header("Authorization", driverToken)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content("false"))
                .andExpect(status().isNoContent());

        Driver updated = driverRepo.findById(driverUser.getId()).orElseThrow();
        org.junit.jupiter.api.Assertions.assertFalse(updated.isAvailable());
    }

    @Test
    void updateAvailability_ByOtherDriver_ShouldFail403() throws Exception {
        User otherUser = new User();
        otherUser.setEmail("other@test.com");
        otherUser.setPasswordHash(passwordEncoder.encode("other123"));
        otherUser.setFirstName("Other");
        otherUser.setLastName("Driver");
        otherUser.setRole(UserRole.driver);
        otherUser = userRepo.save(otherUser);

        Driver otherDriver = new Driver();
        otherDriver.setUser(otherUser);
        otherDriver.setLicenseNumber("DL-999999");
        otherDriver.setLicenseExpiry(LocalDate.now().plusYears(1));
        driverRepo.save(otherDriver);

        String otherToken = loginAndGetToken("other@test.com", "other123");

        mockMvc.perform(
                        patch("/api/drivers/" + driverUser.getId() + "/availability")
                                .header("Authorization", otherToken)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content("false"))
                .andExpect(status().isForbidden());
    }
}
