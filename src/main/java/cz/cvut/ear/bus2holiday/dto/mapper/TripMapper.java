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

        return new TripResponse(
                trip.getId(),
                trip.getRoute().getId(),
                trip.getRoute().getName(),
                trip.getBus().getRegistrationNumber(),
                trip.getDepartureDatetime(),
                trip.getArrivalDatetime(),
                trip.getPrice(),
                trip.getStatus(),
                driverName);
    }
}
