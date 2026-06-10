package cz.cvut.ear.bus2holiday.dto.response;

import cz.cvut.ear.bus2holiday.model.enums.UserRole;

public record UserResponse(
        Long id,
        String email,
        String firstName,
        String lastName,
        String phone,
        String preferredCurrency,
        String country,
        String avatarData,
        UserRole role) {}
