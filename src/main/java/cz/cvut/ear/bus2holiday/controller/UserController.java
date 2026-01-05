package cz.cvut.ear.bus2holiday.controller;

import cz.cvut.ear.bus2holiday.dto.mapper.UserMapper;
import cz.cvut.ear.bus2holiday.dto.request.UpdateUserRequest;
import cz.cvut.ear.bus2holiday.dto.response.UserResponse;
import cz.cvut.ear.bus2holiday.model.User;
import cz.cvut.ear.bus2holiday.security.SecurityUtils;
import cz.cvut.ear.bus2holiday.service.UserService;

import lombok.RequiredArgsConstructor;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final UserMapper userMapper;
    private final SecurityUtils securityUtils;

    @GetMapping
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<List<UserResponse>> getAllUsers() {
        List<User> users = userService.findAll();
        return ResponseEntity.ok(users.stream().map(userMapper::toResponse).toList());
    }

    @GetMapping("/me")
    public ResponseEntity<UserResponse> getCurrentUser() {
        Long currentUserId = securityUtils.getCurrentUserId();
        User user = userService.findById(currentUserId);
        return ResponseEntity.ok(userMapper.toResponse(user));
    }

    @GetMapping("/{id}")
    public ResponseEntity<UserResponse> getUserById(@PathVariable Long id) {
        User user = userService.findById(id);
        return ResponseEntity.ok(userMapper.toResponse(user));
    }

    @PutMapping("/{id}")
    public ResponseEntity<UserResponse> updateUser(
            @PathVariable Long id, @RequestBody UpdateUserRequest request) {
        Long currentUserId = securityUtils.getCurrentUserId();
        boolean isAdmin = securityUtils.hasRole("ROLE_ADMIN");

        User updatedUser =
                userService.update(
                        id,
                        request.firstName(),
                        request.lastName(),
                        request.phone(),
                        currentUserId,
                        isAdmin);
        return ResponseEntity.ok(userMapper.toResponse(updatedUser));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        userService.delete(id);
        return ResponseEntity.noContent().build();
    }
}
