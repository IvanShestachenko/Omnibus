package cz.cvut.ear.bus2holiday.service;

import cz.cvut.ear.bus2holiday.dao.UserRepository;
import cz.cvut.ear.bus2holiday.dto.mapper.UserMapper;
import cz.cvut.ear.bus2holiday.dto.request.LoginRequest;
import cz.cvut.ear.bus2holiday.dto.request.RegisterRequest;
import cz.cvut.ear.bus2holiday.dto.response.AuthResponse;
import cz.cvut.ear.bus2holiday.model.User;
import cz.cvut.ear.bus2holiday.model.enums.UserRole;
import cz.cvut.ear.bus2holiday.security.JwtTokenProvider;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AuthService {

    private final AuthenticationManager authenticationManager;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtTokenProvider tokenProvider;
    private final UserMapper userMapper;

    public AuthService(
            AuthenticationManager authenticationManager,
            UserRepository userRepository,
            PasswordEncoder passwordEncoder,
            JwtTokenProvider tokenProvider,
            UserMapper userMapper) {
        this.authenticationManager = authenticationManager;
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.tokenProvider = tokenProvider;
        this.userMapper = userMapper;
    }

    public AuthResponse login(LoginRequest request) {
        Authentication authentication =
                authenticationManager.authenticate(
                        new UsernamePasswordAuthenticationToken(
                                request.email(), request.password()));

        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwt = tokenProvider.generateToken(authentication);

        User user =
                userRepository
                        .findByEmail(request.email())
                        .orElseThrow(() -> new IllegalStateException("User not found after auth"));
        return new AuthResponse(jwt, userMapper.toResponse(user));
    }

    @Transactional
    public AuthResponse register(RegisterRequest request) {
        if (userRepository.findByEmail(request.email()).isPresent()) {
            throw new IllegalArgumentException("Email already exists");
        }

        User user = new User();
        user.setFirstName(request.firstName());
        user.setLastName(request.lastName());
        user.setEmail(request.email());
        
        // Save phone as null if blank to avoid violating unique constraint
        user.setPhone(request.phone() == null || request.phone().isBlank() ? null : request.phone());
        user.setPasswordHash(passwordEncoder.encode(request.password()));
        user.setRole(UserRole.user);

        // Map country to currency if currency is not specified
        String currency = request.preferredCurrency();
        if (currency == null || currency.isBlank()) {
            if ("Ukraine".equals(request.country())) {
                currency = "UAH";
            } else if ("Czech Republic".equals(request.country())) {
                currency = "CZK";
            } else if ("United Kingdom".equals(request.country())) {
                currency = "GBP";
            } else {
                currency = "EUR";
            }
        }
        user.setPreferredCurrency(currency);

        // Save country as null if blank or unlisted
        String country = request.country();
        if (country == null || country.isBlank() || "not_in_list".equals(country)) {
            country = null;
        }
        user.setCountry(country);
        user.setAvatarData(request.avatarData());

        userRepository.saveAndFlush(user);

        // Authenticate immediately after register
        Authentication authentication =
                authenticationManager.authenticate(
                        new UsernamePasswordAuthenticationToken(
                                request.email(), request.password()));

        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwt = tokenProvider.generateToken(authentication);

        return new AuthResponse(jwt, userMapper.toResponse(user));
    }
}
