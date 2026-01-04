package cz.cvut.ear.bus2holiday.dto.request;

import java.util.List;

public record ReservationRequest(Long userId, Long tripId, List<PassengerSeatRequest> passengers) {}
