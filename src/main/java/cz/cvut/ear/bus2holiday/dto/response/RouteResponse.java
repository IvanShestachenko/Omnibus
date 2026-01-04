package cz.cvut.ear.bus2holiday.dto.response;

import java.math.BigDecimal;
import java.util.List;

public record RouteResponse(Long id, String name, boolean isActive, List<RouteStopResponse> stops) {
    public record RouteStopResponse(
            String terminalName,
            String city,
            int sequenceOrder,
            int arrivalOffsetMinutes,
            int departureOffsetMinutes,
            BigDecimal distanceFromOrigin) {}
}
