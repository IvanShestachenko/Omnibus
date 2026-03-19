package cz.cvut.ear.bus2holiday.controller;

import cz.cvut.ear.bus2holiday.dto.mapper.ReservationMapper;
import cz.cvut.ear.bus2holiday.dto.request.CreateReservationRequest;
import cz.cvut.ear.bus2holiday.dto.response.ReservationResponse;
import cz.cvut.ear.bus2holiday.exception.ForbiddenException;
import cz.cvut.ear.bus2holiday.model.Reservation;
import cz.cvut.ear.bus2holiday.security.SecurityUtils;
import cz.cvut.ear.bus2holiday.service.PaymentService;
import cz.cvut.ear.bus2holiday.service.ReservationService;

import jakarta.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reservations")
public class ReservationController {
    private final ReservationService reservationService;
    private final PaymentService paymentService;
    private final SecurityUtils securityUtils;
    private final ReservationMapper reservationMapper;

    public ReservationController(
            ReservationService reservationService,
            PaymentService paymentService,
            SecurityUtils securityUtils,
            ReservationMapper reservationMapper) {
        this.reservationService = reservationService;
        this.paymentService = paymentService;
        this.securityUtils = securityUtils;
        this.reservationMapper = reservationMapper;
    }

    @PostMapping
    @PreAuthorize("hasAnyRole('ROLE_USER', 'ROLE_ADMIN')")
    public ResponseEntity<ReservationResponse> createReservation(
            @Valid @RequestBody CreateReservationRequest request) {

        Long currentUserId = securityUtils.getCurrentUserId();
        Reservation reservation = reservationService.createReservation(currentUserId, request);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(reservationMapper.toResponse(reservation));
    }

    @GetMapping
    public ResponseEntity<List<ReservationResponse>> getMyReservations() {
        Long currentUserId = securityUtils.getCurrentUserId();
        List<Reservation> reservations = reservationService.findByUserId(currentUserId);

        return ResponseEntity.ok(reservations.stream().map(reservationMapper::toResponse).toList());
    }

    @GetMapping("/{id}")
    public ResponseEntity<ReservationResponse> getReservation(@PathVariable Long id) {
        Long currentUserId = securityUtils.getCurrentUserId();
        Reservation reservation = reservationService.findById(id);

        if (!reservation.getUser().getId().equals(currentUserId)
                && !securityUtils.hasRole("ROLE_ADMIN")) {
            throw new ForbiddenException("Access denied");
        }

        return ResponseEntity.ok(reservationMapper.toResponse(reservation));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> cancelReservation(@PathVariable Long id) {
        Long currentUserId = securityUtils.getCurrentUserId();
        reservationService.cancelReservation(id, currentUserId);

        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{id}/pay")
    public ResponseEntity<Void> payReservation(@PathVariable Long id) {
        Long currentUserId = securityUtils.getCurrentUserId();
        paymentService.payReservation(id, currentUserId);
        return ResponseEntity.ok().build();
    }
}
