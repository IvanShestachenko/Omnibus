package cz.cvut.ear.bus2holiday.controller;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.fasterxml.jackson.databind.ObjectMapper;

import cz.cvut.ear.bus2holiday.TestContainerConfig;
import cz.cvut.ear.bus2holiday.dao.UserRepository;
import cz.cvut.ear.bus2holiday.dto.request.LoginRequest;
import cz.cvut.ear.bus2holiday.dto.request.RegisterRequest;
import cz.cvut.ear.bus2holiday.dto.response.AuthResponse;
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

@SpringBootTest
@AutoConfigureMockMvc
public class AuthControllerIntegrationTest extends TestContainerConfig {

    @Autowired private MockMvc mockMvc;

    @Autowired private UserRepository userRepository;

    @Autowired private PasswordEncoder passwordEncoder;

    @Autowired private ObjectMapper objectMapper;

    @BeforeEach
    public void setUp() {
        userRepository.deleteAll();
    }

    @Test
    public void register_ShouldCreateUser_WhenRequestIsValid() throws Exception {
        RegisterRequest request =
                new RegisterRequest(
                        "John",
                        "Winchester",
                        "johnwinchester@example.com",
                        "password123",
                        "123456789");

        mockMvc.perform(
                        post("/api/auth/register")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated());

        assertTrue(userRepository.findByEmail("johnwinchester@example.com").isPresent());
    }

    @Test
    public void login_ShouldReturnToken_WhenCredentialsAreCorrect() throws Exception {
        User user = new User();
        user.setFirstName("Jane");
        user.setLastName("Hoper");
        user.setEmail("jane@example.com");
        user.setPasswordHash(passwordEncoder.encode("password123"));
        user.setPhone("987654321");
        user.setRole(UserRole.user);
        userRepository.save(user);

        LoginRequest loginRequest = new LoginRequest("janehoper@example.com", "password123");

        MvcResult result =
                mockMvc.perform(
                                post("/api/auth/login")
                                        .contentType(MediaType.APPLICATION_JSON)
                                        .content(objectMapper.writeValueAsString(loginRequest)))
                        .andExpect(status().isOk())
                        .andReturn();

        String responseContent = result.getResponse().getContentAsString();
        AuthResponse authResponse = objectMapper.readValue(responseContent, AuthResponse.class);

        assertNotNull(authResponse.accessToken());
        assertEquals("Bearer", authResponse.tokenType());
    }

    @Test
    public void login_ShouldFail_WhenPasswordIsIncorrect() throws Exception {
        User user = new User();
        user.setEmail("janehoper@example.com");
        user.setPasswordHash(passwordEncoder.encode("password123"));
        user.setFirstName("Jane");
        user.setLastName("Hoper");
        user.setRole(UserRole.user);
        userRepository.save(user);

        LoginRequest loginRequest = new LoginRequest("janehoper@example.com", "wrongpassword");

        mockMvc.perform(
                        post("/api/auth/login")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(loginRequest)))
                .andExpect(status().isUnauthorized());
    }

    @Test
    public void accessProtectedEndpoint_ShouldFail_WhenNoTokenProvided() throws Exception {
        mockMvc.perform(get("/api/some-protected-resource")).andExpect(status().isUnauthorized());
    }

    @Test
    public void accessProtectedEndpoint_ShouldPass_WhenTokenPROVIDED() throws Exception {
        User user = new User();
        user.setEmail("test@test.com");
        user.setPasswordHash(passwordEncoder.encode("password"));
        user.setFirstName("Test");
        user.setLastName("User");
        user.setRole(UserRole.user);
        userRepository.save(user);

        LoginRequest loginRequest = new LoginRequest("testtesttest@test.com", "password123");
        MvcResult loginResult =
                mockMvc.perform(
                                post("/api/auth/login")
                                        .contentType(MediaType.APPLICATION_JSON)
                                        .content(objectMapper.writeValueAsString(loginRequest)))
                        .andReturn();

        AuthResponse authResponse =
                objectMapper.readValue(
                        loginResult.getResponse().getContentAsString(), AuthResponse.class);
        String token = authResponse.accessToken();

        mockMvc.perform(
                        get("/api/some-protected-resource")
                                .header("Authorization", "Bearer " + token))
                .andExpect(status().isNotFound());
    }
}
