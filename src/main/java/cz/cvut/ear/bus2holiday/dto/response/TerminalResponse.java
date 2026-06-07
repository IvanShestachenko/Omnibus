package cz.cvut.ear.bus2holiday.dto.response;

public record TerminalResponse(
    Long id,
    String name,
    String city,
    String country
) {}
