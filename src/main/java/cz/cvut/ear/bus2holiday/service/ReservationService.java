package cz.cvut.ear.bus2holiday.service;

import cz.cvut.ear.bus2holiday.dao.*;
import cz.cvut.ear.bus2holiday.dto.request.CreateReservationRequest;
import cz.cvut.ear.bus2holiday.dto.request.PassengerSeatRequest;
import cz.cvut.ear.bus2holiday.dto.request.ReservationRequest;
import cz.cvut.ear.bus2holiday.exception.CancellationNotAllowedException;
import cz.cvut.ear.bus2holiday.exception.ForbiddenException;
import cz.cvut.ear.bus2holiday.exception.ReservationNotFoundException;
import cz.cvut.ear.bus2holiday.exception.SeatUnavailableException;
import cz.cvut.ear.bus2holiday.model.*;
import cz.cvut.ear.bus2holiday.model.enums.ReservationStatus;

import jakarta.persistence.EntityNotFoundException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.time.temporal.ChronoUnit;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Service
public class ReservationService {

    private final ReservationRepository reservationRepo;
    private final ReservationPassengerRepository passengerRepo;
    private final TripRepository tripRepo;
    private final UserRepository userRepo;
    private final RouteStopRepository routeStopRepo;

    public ReservationService(
            ReservationRepository reservationRepo,
            ReservationPassengerRepository passengerRepo,
            TripRepository tripRepo,
            UserRepository userRepo,
            RouteStopRepository routeStopRepo) {
        this.reservationRepo = reservationRepo;
        this.passengerRepo = passengerRepo;
        this.tripRepo = tripRepo;
        this.userRepo = userRepo;
        this.routeStopRepo = routeStopRepo;
    }

    @Transactional
    public Reservation createReservation(Long userId, CreateReservationRequest request) {
        return createReservation(
                new ReservationRequest(userId, request.tripId(), request.passengers()));
    }

    @Transactional
    public Reservation createReservation(ReservationRequest request) {
        User user =
                userRepo.findById(request.userId())
                        .orElseThrow(
                                () ->
                                        new EntityNotFoundException(
                                                "User not found: " + request.userId()));
        Trip trip =
                tripRepo.findById(request.tripId())
                        .orElseThrow(
                                () ->
                                        new EntityNotFoundException(
                                                "Trip not found: " + request.tripId()));

        if (request.passengers().isEmpty()) {
            throw new IllegalArgumentException("Reservation must have at least one passenger");
        }

        // Validate seats and acquire lock
        PassengerSeatRequest firstPsr = request.passengers().get(0);
        int fromStopOrder = firstPsr.fromStopOrder();
        int toStopOrder = firstPsr.toStopOrder();

        RouteStop originStop =
                routeStopRepo
                        .findByRouteIdAndSequenceOrder(trip.getRoute().getId(), fromStopOrder)
                        .orElseThrow(() -> new EntityNotFoundException("Origin RouteStop not found"));

        RouteStop targetStop =
                routeStopRepo
                        .findByRouteIdAndSequenceOrder(trip.getRoute().getId(), toStopOrder)
                        .orElseThrow(() -> new EntityNotFoundException("Target RouteStop not found"));

        for (PassengerSeatRequest psr : request.passengers()) {
            if (!isSeatAvailable(trip, psr.seatNumber(), fromStopOrder, toStopOrder)) {
                throw new SeatUnavailableException(
                        "Seat " + psr.seatNumber() + " is not available for the selected segment.");
            }
        }

        Reservation reservation = new Reservation();
        reservation.setUser(user);
        reservation.setTrip(trip);
        reservation.setOriginRouteStop(originStop);
        reservation.setTargetRouteStop(targetStop);
        reservation.setStatus(ReservationStatus.PENDING);
        reservation.setBookingReference(UUID.randomUUID().toString().substring(0, 8).toUpperCase());

        BigDecimal basePrice = targetStop.getBasePriceFromOrigin()
                .subtract(originStop.getBasePriceFromOrigin())
                .abs();

        BigDecimal segmentDistance = targetStop.getDistanceFromOrigin()
                .subtract(originStop.getDistanceFromOrigin())
                .abs();

        BigDecimal totalAmount = BigDecimal.ZERO;
        Set<ReservationPassenger> passengers = new HashSet<>();

        for (PassengerSeatRequest psr : request.passengers()) {
            ReservationPassenger passenger = new ReservationPassenger();
            passenger.setReservation(reservation);
            passenger.setFirstName(psr.firstName());
            passenger.setLastName(psr.lastName());
            passenger.setCheckedIn(false);
            passenger.setSeatNumber(psr.seatNumber());

            BigDecimal passengerPrice = basePrice.multiply(trip.getPriceKoefficient());
            if (isPanoramicSeat(trip.getBus(), psr.seatNumber())) {
                BigDecimal surcharge = segmentDistance.multiply(new BigDecimal("0.004"))
                        .setScale(2, RoundingMode.HALF_UP);
                passengerPrice = passengerPrice.add(surcharge);
            }

            totalAmount = totalAmount.add(passengerPrice);
            passengers.add(passenger);
        }

        reservation.setTotalAmount(totalAmount);
        reservation.setPassengers(passengers);

        return reservationRepo.save(reservation);
    }

    @Transactional(readOnly = true)
    public List<Reservation> findByUserId(Long userId) {
        return reservationRepo.findByUserId(userId);
    }

    @Transactional
    public Reservation findById(Long id) {
        return reservationRepo.findById(id).orElseThrow(() -> new ReservationNotFoundException(id));
    }

    @Transactional
    public void cancelReservation(Long reservationId, Long currentUserId) {
        Reservation reservation = findById(reservationId);

        if (!reservation.getUser().getId().equals(currentUserId)) {
            throw new ForbiddenException("User is not authorized to cancel this reservation");
        }

        Trip trip = reservation.getTrip();
        OffsetDateTime now = OffsetDateTime.now(ZoneOffset.UTC);
        OffsetDateTime departureTime = trip.getDepartureDatetime();

        long minutesUntilDeparture = ChronoUnit.MINUTES.between(now, departureTime);

        if (minutesUntilDeparture < 15) {
            throw new CancellationNotAllowedException(
                    "Cancellation is not possible less than 15 minutes before departure");
        }

        reservation.setStatus(ReservationStatus.CANCELLED);
        reservationRepo.save(reservation);
    }

    private boolean isSeatAvailable(
            Trip trip, String seatNumber, int requestedFrom, int requestedTo) {

        // Acquire advisory lock to prevent concurrent bookings for this specific seat on this trip
        passengerRepo.acquireAdvisoryLockForSeat(trip.getId(), seatNumber);

        List<ReservationPassenger> existingPassengers =
                passengerRepo.findActivePassengersByTripAndSeat(trip.getId(), seatNumber);

        if (existingPassengers.isEmpty()) {
            return true;
        }

        List<RouteStop> stops = trip.getRoute().getStops();
        if (trip.isReverse()) {
            stops = new java.util.ArrayList<>(stops);
            java.util.Collections.reverse(stops);
        }

        int requestedFromIdx = -1;
        int requestedToIdx = -1;
        for (int i = 0; i < stops.size(); i++) {
            if (stops.get(i).getSequenceOrder() == requestedFrom) {
                requestedFromIdx = i;
            }
            if (stops.get(i).getSequenceOrder() == requestedTo) {
                requestedToIdx = i;
            }
        }

        if (requestedFromIdx == -1 || requestedToIdx == -1 || requestedFromIdx >= requestedToIdx) {
            throw new IllegalArgumentException("Invalid stops selected for the segment");
        }

        for (ReservationPassenger passenger : existingPassengers) {
            Reservation existingRes = passenger.getReservation();
            int existingFrom = existingRes.getOriginRouteStop().getSequenceOrder();
            int existingTo = existingRes.getTargetRouteStop().getSequenceOrder();

            int existingFromIdx = -1;
            int existingToIdx = -1;
            for (int i = 0; i < stops.size(); i++) {
                if (stops.get(i).getSequenceOrder() == existingFrom) {
                    existingFromIdx = i;
                }
                if (stops.get(i).getSequenceOrder() == existingTo) {
                    existingToIdx = i;
                }
            }

            if (existingFromIdx != -1 && existingToIdx != -1) {
                boolean overlaps = (requestedFromIdx < existingToIdx) && (existingFromIdx < requestedToIdx);
                if (overlaps) {
                    return false;
                }
            }
        }

        return true;
    }

    private boolean isPanoramicSeat(Bus bus, String seatNumber) {
        try {
            com.fasterxml.jackson.databind.JsonNode root =
                    new com.fasterxml.jackson.databind.ObjectMapper().readTree(bus.getSeatLayout());
            com.fasterxml.jackson.databind.JsonNode categories = root.path("categories");
            if (categories.isObject()) {
                com.fasterxml.jackson.databind.JsonNode panoramic = categories.path("PANORAMIC");
                if (panoramic.isArray()) {
                    for (com.fasterxml.jackson.databind.JsonNode node : panoramic) {
                        if (node.asText().equals(seatNumber)) {
                            return true;
                        }
                    }
                }
            }
        } catch (Exception e) {
            // Fallback
        }
        return false;
    }
}
