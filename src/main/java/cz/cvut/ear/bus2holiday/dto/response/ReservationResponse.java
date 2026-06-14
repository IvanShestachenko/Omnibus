package cz.cvut.ear.bus2holiday.dto.response;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.List;

public record ReservationResponse(
        Long id,
        String bookingReference,
        String status,
        BigDecimal totalAmount,
        LocalDate createdAt,
        TripSummary trip,
        String originTerminalName,
        String targetTerminalName,
        List<PassengerResponse> passengers,
        BigDecimal distance) {
    public record TripSummary(
            Long id,
            String routeName,
            OffsetDateTime departure,
            OffsetDateTime arrivalDatetime,
            String driverName,
            String busName,
            String busRegistrationNumber,
            String seatLayout) {}

    public record PassengerResponse(
            String firstName, String lastName, String seatNumber, boolean checkedIn) {}
}
