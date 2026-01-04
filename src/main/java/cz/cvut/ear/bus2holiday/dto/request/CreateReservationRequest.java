package cz.cvut.ear.bus2holiday.dto.request;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

import java.util.List;

public record CreateReservationRequest(
        @NotNull Long tripId, @NotEmpty List<PassengerSeatRequest> passengers) {}
