package cz.cvut.ear.bus2holiday.dto.response;

import cz.cvut.ear.bus2holiday.model.enums.TripStatus;

import java.math.BigDecimal;
import java.time.OffsetDateTime;

public record TripResponse(
        Long id,
        Long routeId,
        String routeName,
        String busRegistrationNumber,
        OffsetDateTime departureDatetime,
        OffsetDateTime arrivalDatetime,
        BigDecimal price,
        TripStatus status,
        String driverName) {}
