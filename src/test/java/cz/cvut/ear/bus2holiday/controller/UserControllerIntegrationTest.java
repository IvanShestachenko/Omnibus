package cz.cvut.ear.bus2holiday.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.fasterxml.jackson.databind.ObjectMapper;

import cz.cvut.ear.bus2holiday.TestContainerConfig;
import cz.cvut.ear.bus2holiday.dao.UserRepository;
import cz.cvut.ear.bus2holiday.dto.request.LoginRequest;
import cz.cvut.ear.bus2holiday.dto.request.UpdateUserRequest;
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
import org.springframework.transaction.annotation.Transactional;

@SpringBootTest
@Transactional
@AutoConfigureMockMvc
public class UserControllerIntegrationTest extends TestContainerConfig {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;
    @Autowired private UserRepository userRepo;
    @Autowired private PasswordEncoder passwordEncoder;

    private String userToken;
    private String adminToken;
    private User testUser;
    private User adminUser;

    @BeforeEach
    void setUp() throws Exception {
        userRepo.deleteAll();

        testUser = new User();
        testUser.setEmail("user@test.com");
        testUser.setPasswordHash(passwordEncoder.encode("password123"));
        testUser.setFirstName("Regular");
        testUser.setLastName("User");
        testUser.setRole(UserRole.user);
        testUser = userRepo.save(testUser);

        adminUser = new User();
        adminUser.setEmail("admin@test.com");
        adminUser.setPasswordHash(passwordEncoder.encode("admin123"));
        adminUser.setFirstName("Admin");
        adminUser.setLastName("User");
        adminUser.setRole(UserRole.admin);
        adminUser = userRepo.save(adminUser);

        userToken = loginAndGetToken("user@test.com", "password123");
        adminToken = loginAndGetToken("admin@test.com", "admin123");
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
        AuthResponse authResponse =
                objectMapper.readValue(
                        result.getResponse().getContentAsString(), AuthResponse.class);
        return "Bearer " + authResponse.accessToken();
    }

    @Test
    void getMe_ShouldReturnCurrentUser() throws Exception {
        mockMvc.perform(get("/api/users/me").header("Authorization", userToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.email").value("user@test.com"))
                .andExpect(jsonPath("$.firstName").value("Regular"));
    }

    @Test
    void getAllUsers_AsAdmin_ShouldSucceed() throws Exception {
        mockMvc.perform(get("/api/users").header("Authorization", adminToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(2));
    }

    @Test
    void getAllUsers_AsRegularUser_ShouldFail403() throws Exception {
        mockMvc.perform(get("/api/users").header("Authorization", userToken))
                .andExpect(status().isForbidden());
    }

    @Test
    void updateSelf_ShouldSucceed() throws Exception {
        UpdateUserRequest request = new UpdateUserRequest("NewFirst", "NewLast", "+420111222333");

        mockMvc.perform(
                        put("/api/users/" + testUser.getId())
                                .header("Authorization", userToken)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.firstName").value("NewFirst"))
                .andExpect(jsonPath("$.lastName").value("NewLast"))
                .andExpect(jsonPath("$.phone").value("+420111222333"));
    }

    @Test
    void updateOtherUser_AsRegular_ShouldFail403() throws Exception {
        UpdateUserRequest request = new UpdateUserRequest("Hacker", "Attack", null);

        mockMvc.perform(
                        put("/api/users/" + adminUser.getId())
                                .header("Authorization", userToken)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isForbidden());
    }

    @Test
    void updateOtherUser_AsAdmin_ShouldSucceed() throws Exception {
        UpdateUserRequest request = new UpdateUserRequest("AdminEdited", null, null);

        mockMvc.perform(
                        put("/api/users/" + testUser.getId())
                                .header("Authorization", adminToken)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.firstName").value("AdminEdited"));
    }

    @Test
    void deleteUser_AsAdmin_ShouldSucceed() throws Exception {
        mockMvc.perform(
                        delete("/api/users/" + testUser.getId())
                                .header("Authorization", adminToken))
                .andExpect(status().isNoContent());

        assertEquals(1, userRepo.count());
    }

    @Test
    void deleteUser_AsRegular_ShouldFail403() throws Exception {
        mockMvc.perform(
                        delete("/api/users/" + adminUser.getId())
                                .header("Authorization", userToken))
                .andExpect(status().isForbidden());
    }
}
