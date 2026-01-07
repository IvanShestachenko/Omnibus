package cz.cvut.ear.bus2holiday.controller;

import cz.cvut.ear.bus2holiday.dao.UserRepository;

import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/** Temporary debug controller - DELETE AFTER */
@RestController
@RequestMapping("/api/auth")
public class DebugController {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public DebugController(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/debug/{email}")
    public ResponseEntity<Map<String, Object>> debugUser(
            @PathVariable String email, @RequestParam String password) {
        var userOpt = userRepository.findByEmail(email);

        if (userOpt.isEmpty()) {
            return ResponseEntity.ok(
                    Map.of("found", false, "message", "User not found with email: " + email));
        }

        var user = userOpt.get();
        boolean matches = passwordEncoder.matches(password, user.getPasswordHash());

        return ResponseEntity.ok(
                Map.of(
                        "found",
                        true,
                        "email",
                        user.getEmail(),
                        "role",
                        user.getRole().name(),
                        "passwordHashStart",
                        user.getPasswordHash().substring(0, 20) + "...",
                        "passwordMatches",
                        matches,
                        "inputPassword",
                        password));
    }

    @GetMapping("/generate-hash")
    public ResponseEntity<Map<String, String>> generateHash(@RequestParam String password) {
        String hash = passwordEncoder.encode(password);
        return ResponseEntity.ok(
                Map.of(
                        "password", password,
                        "bcryptHash", hash));
    }
}
