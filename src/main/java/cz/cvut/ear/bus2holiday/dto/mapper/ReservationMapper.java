package cz.cvut.ear.bus2holiday.dto.mapper;

import cz.cvut.ear.bus2holiday.dto.response.ReservationResponse;
import cz.cvut.ear.bus2holiday.model.Reservation;

import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class ReservationMapper {

    public ReservationResponse toResponse(Reservation reservation) {
        var trip = reservation.getTrip();
        var tripSummary =
                new ReservationResponse.TripSummary(
                        trip.getId(),
                        trip.getRoute().getName(),
                        trip.getDepartureDatetime().toLocalDateTime());

        List<ReservationResponse.PassengerResponse> passengerResponses =
                reservation.getPassengers().stream()
                        .map(
                                p ->
                                        new ReservationResponse.PassengerResponse(
                                                p.getFirstName(),
                                                p.getLastName(),
                                                p.getBookedSegments().stream()
                                                        .map(
                                                                s ->
                                                                        new ReservationResponse
                                                                                .SegmentInfo(
                                                                                s.getSeatNumber(),
                                                                                s
                                                                                        .getFromStopOrder(),
                                                                                s.getToStopOrder()))
                                                        .toList()))
                        .toList();

        return new ReservationResponse(
                reservation.getId(),
                reservation.getBookingReference(),
                reservation.getStatus().name(),
                reservation.getTotalAmount(),
                reservation.getCreatedAt().toLocalDate(),
                tripSummary,
                passengerResponses);
    }
}
