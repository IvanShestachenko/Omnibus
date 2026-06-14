package cz.cvut.ear.bus2holiday.dto.mapper;

import cz.cvut.ear.bus2holiday.dto.response.ReservationResponse;
import cz.cvut.ear.bus2holiday.model.Reservation;

import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class ReservationMapper {

    public ReservationResponse toResponse(Reservation reservation) {
        var trip = reservation.getTrip();
        String driverName =
                trip.getDriver() != null
                        ? trip.getDriver().getUser().getFirstName()
                                + " "
                                + trip.getDriver().getUser().getLastName()
                        : null;
        String busName = trip.getBus() != null 
                ? trip.getBus().getManufacturer() + " " + trip.getBus().getModel() 
                : null;
        String busRegNum = trip.getBus() != null ? trip.getBus().getRegistrationNumber() : null;
        String seatLayout = trip.getBus() != null ? trip.getBus().getSeatLayout() : null;

        var originStop = reservation.getOriginRouteStop();
        var targetStop = reservation.getTargetRouteStop();
        var stops = trip.getRoute().getStops();

        java.time.OffsetDateTime segmentDeparture = trip.getDepartureDatetime();
        java.time.OffsetDateTime segmentArrival = trip.getArrivalDatetime();

        if (originStop != null && targetStop != null) {
            if (!trip.isReverse()) {
                segmentDeparture = trip.getDepartureDatetime().plusMinutes(originStop.getDepartureOffsetMinutes());
                segmentArrival = trip.getDepartureDatetime().plusMinutes(targetStop.getArrivalOffsetMinutes());
            } else {
                int maxOffset = 0;
                if (stops != null) {
                    for (var stop : stops) {
                        if (stop.getDepartureOffsetMinutes() > maxOffset) {
                            maxOffset = stop.getDepartureOffsetMinutes();
                        }
                    }
                }
                segmentDeparture = trip.getDepartureDatetime().plusMinutes(maxOffset - originStop.getArrivalOffsetMinutes());
                segmentArrival = trip.getDepartureDatetime().plusMinutes(maxOffset - targetStop.getDepartureOffsetMinutes());
            }
        }

        var tripSummary =
                new ReservationResponse.TripSummary(
                        trip.getId(),
                        trip.getRoute().getName(),
                        segmentDeparture,
                        segmentArrival,
                        driverName,
                        busName,
                        busRegNum,
                        seatLayout);

        List<ReservationResponse.PassengerResponse> passengerResponses =
                reservation.getPassengers().stream()
                        .map(
                                p ->
                                        new ReservationResponse.PassengerResponse(
                                                 p.getFirstName(),
                                                 p.getLastName(),
                                                 p.getSeatNumber(),
                                                 p.isCheckedIn()))
                        .toList();

        java.math.BigDecimal originDist = reservation.getOriginRouteStop().getDistanceFromOrigin();
        java.math.BigDecimal targetDist = reservation.getTargetRouteStop().getDistanceFromOrigin();
        java.math.BigDecimal distance = originDist.subtract(targetDist).abs();

        return new ReservationResponse(
                reservation.getId(),
                reservation.getBookingReference(),
                reservation.getStatus().name(),
                reservation.getTotalAmount(),
                reservation.getCreatedAt() != null ? reservation.getCreatedAt().toLocalDate() : java.time.LocalDate.now(),
                tripSummary,
                reservation.getOriginRouteStop().getTerminal().getName(),
                reservation.getTargetRouteStop().getTerminal().getName(),
                passengerResponses,
                distance);
    }
}
