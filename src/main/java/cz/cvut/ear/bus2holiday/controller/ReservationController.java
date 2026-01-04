package cz.cvut.ear.bus2holiday.controller;

import cz.cvut.ear.bus2holiday.dto.request.CreateReservationRequest;
import cz.cvut.ear.bus2holiday.dto.response.ReservationResponse;
import cz.cvut.ear.bus2holiday.exception.ForbiddenException;
import cz.cvut.ear.bus2holiday.model.Reservation;
import cz.cvut.ear.bus2holiday.security.SecurityUtils;
import cz.cvut.ear.bus2holiday.service.ReservationService;

import jakarta.validation.Valid;

import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reservations")
@RequiredArgsConstructor
class ReservationController {
    private final ReservationService reservationService;
    private final SecurityUtils securityUtils;

    @PostMapping
    @PreAuthorize("hasAnyRole('ROLE_USER', 'ROLE_ADMIN')")
    public ResponseEntity<ReservationResponse> createReservation(
            @Valid @RequestBody CreateReservationRequest request) {

        Long currentUserId = securityUtils.getCurrentUserId();
        Reservation reservation = reservationService.createReservation(currentUserId, request);
        return ResponseEntity.status(HttpStatus.CREATED).body(toResponse(reservation));
    }

    @GetMapping
    public ResponseEntity<List<ReservationResponse>> getMyReservations() {
        Long currenUserId = securityUtils.getCurrentUserId();
        List<Reservation> reservations = reservationService.findByUserId(currenUserId);

        return ResponseEntity.ok(reservations.stream().map(this::toResponse).toList());
    }

    @GetMapping("/{id}")
    public ResponseEntity<ReservationResponse> getReservation(@PathVariable Long id) {
        Long currentUserId = securityUtils.getCurrentUserId();
        Reservation reservation = reservationService.findById(id);

        if (!reservation.getUser().getId().equals(currentUserId)
                && !securityUtils.hasRole("ROLE_ADMIN")) {
            throw new ForbiddenException("Access denied");
        }

        return ResponseEntity.ok(toResponse(reservation));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> cancelReservation(@PathVariable Long id) {
        Long currentUserId = securityUtils.getCurrentUserId();
        reservationService.cancelReservation(id, currentUserId);

        return ResponseEntity.noContent().build();
    }

    private ReservationResponse toResponse(Reservation reservation) {
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
