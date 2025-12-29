package cz.cvut.ear.bus2holiday.dto.response;

public record AuthResponse(String accessToken, String tokenType) {
    public AuthResponse(String accessToken) {
        this(accessToken, "Bearer");
    }
}
