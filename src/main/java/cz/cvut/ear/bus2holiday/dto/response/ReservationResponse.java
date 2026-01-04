package cz.cvut.ear.bus2holiday.dto.response;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public record ReservationResponse(
        Long id,
        String bookingReference,
        String status,
        BigDecimal totalAmount,
        LocalDate createdAt,
        TripSummary trip,
        List<PassengerResponse> passengers) {
    public record TripSummary(Long id, String routeName, LocalDateTime departure) {}

    public record PassengerResponse(
            String firstName, String lastName, List<SegmentInfo> segments) {}

    public record SegmentInfo(String seatNumber, int fromStop, int toStop) {}
}
