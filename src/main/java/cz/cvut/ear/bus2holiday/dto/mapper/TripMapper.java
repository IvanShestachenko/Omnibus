package cz.cvut.ear.bus2holiday.dto.mapper;

import cz.cvut.ear.bus2holiday.dto.response.TripResponse;
import cz.cvut.ear.bus2holiday.model.Trip;

import org.springframework.stereotype.Component;

@Component
public class TripMapper {
    public TripResponse toResponse(Trip trip) {
        String driverName =
                trip.getDriver() != null
                        ? trip.getDriver().getUser().getFirstName()
                                + " "
                                + trip.getDriver().getUser().getLastName()
                        : null;

        java.math.BigDecimal defaultPrice = java.math.BigDecimal.ZERO;
        if (trip.getRoute().getStops() != null && !trip.getRoute().getStops().isEmpty()) {
            var stops = trip.getRoute().getStops();
            var lastStop = stops.get(stops.size() - 1);
            defaultPrice = lastStop.getBasePriceFromOrigin().multiply(trip.getPriceKoefficient());
        }

        return new TripResponse(
                trip.getId(),
                trip.getRoute().getId(),
                trip.getRoute().getName(),
                trip.getBus().getRegistrationNumber(),
                trip.getDepartureDatetime(),
                trip.getArrivalDatetime(),
                defaultPrice,
                trip.getStatus(),
                driverName);
    }
}
