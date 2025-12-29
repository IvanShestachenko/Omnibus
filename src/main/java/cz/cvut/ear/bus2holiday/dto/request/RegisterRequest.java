package cz.cvut.ear.bus2holiday.dto.request;

public record RegisterRequest(
        String firstName, String lastName, String email, String password, String phone) {}
