package cz.cvut.ear.bus2holiday.dto.response;

import cz.cvut.ear.bus2holiday.model.enums.TripStatus;

import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.List;

public record TripResponse(
        Long id,
        Long routeId,
        String routeName,
        String busRegistrationNumber,
        String busName,
        String seatLayout,
        String originTerminalName,
        String destinationTerminalName,
        OffsetDateTime departureDatetime,
        OffsetDateTime arrivalDatetime,
        BigDecimal price,
        TripStatus status,
        String driverName,
        List<String> availableSeats,
        List<String> occupiedSeats) {}
