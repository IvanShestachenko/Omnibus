package cz.cvut.ear.bus2holiday.dto.mapper;

import cz.cvut.ear.bus2holiday.dto.response.RouteResponse;
import cz.cvut.ear.bus2holiday.model.Route;
import cz.cvut.ear.bus2holiday.model.RouteStop;

import org.springframework.stereotype.Component;

import java.util.Comparator;

@Component
public class RouteMapper {
    public RouteResponse toResponse(Route route) {
        var stops =
                route.getStops().stream()
                        .sorted(Comparator.comparingInt(RouteStop::getSequenceOrder))
                        .map(this::toStopResponse)
                        .toList();

        return new RouteResponse(route.getId(), route.getName(), route.isActive(), stops);
    }

    private RouteResponse.RouteStopResponse toStopResponse(RouteStop stop) {
        return new RouteResponse.RouteStopResponse(
                stop.getTerminal().getName(),
                stop.getTerminal().getCity(),
                stop.getSequenceOrder(),
                stop.getArrivalOffsetMinutes(),
                stop.getDepartureOffsetMinutes(),
                stop.getDistanceFromOrigin());
    }
}
