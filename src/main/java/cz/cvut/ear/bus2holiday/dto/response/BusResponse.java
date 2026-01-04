package cz.cvut.ear.bus2holiday.dto.response;

import cz.cvut.ear.bus2holiday.model.enums.BusStatus;

public record BusResponse(
        Long id,
        String registrationNumber,
        String model,
        String manufacturer,
        short year,
        int totalSeats,
        BusStatus status) {}
