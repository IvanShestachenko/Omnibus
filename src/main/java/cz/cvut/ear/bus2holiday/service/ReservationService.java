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
                new ReservationRequest(
                        userId,
                        request.tripId(),
                        request.fromStopOrder(),
                        request.toStopOrder(),
                        request.passengers()
                )
        );
    }

    @Transactional
    public Reservation createReservation(ReservationRequest request) {
        if (request.passengers() == null || request.passengers().isEmpty()) {
            throw new IllegalArgumentException("Reservation must have at least one passenger");
        }

        // 1. In-memory validation of request structure (No DB calls)
        int fromStopOrder = request.fromStopOrder();
        int toStopOrder = request.toStopOrder();

        Set<String> requestedSeats = new HashSet<>();
        for (PassengerSeatRequest psr : request.passengers()) {
            // Validate name formats
            validatePassengerName(psr.firstName(), psr.lastName());

            // Validate seat number presence
            String seat = psr.seatNumber();
            if (seat == null || seat.trim().isEmpty()) {
                throw new IllegalArgumentException("Seat number cannot be empty");
            }

            // Validate seat uniqueness within request
            if (!requestedSeats.add(seat)) {
                throw new IllegalArgumentException("Duplicate seat number in reservation request: " + seat);
            }
        }

        // 2. Database validation & Entity loading
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

        RouteStop originStop =
                routeStopRepo
                        .findByRouteIdAndSequenceOrder(trip.getRoute().getId(), fromStopOrder)
                        .orElseThrow(() -> new EntityNotFoundException("Origin RouteStop not found"));

        RouteStop targetStop =
                routeStopRepo
                        .findByRouteIdAndSequenceOrder(trip.getRoute().getId(), toStopOrder)
                        .orElseThrow(() -> new EntityNotFoundException("Target RouteStop not found"));

        // 3. Layout validation (uses loaded bus layout, in-memory)
        Set<String> validSeats = getValidSeatsForBus(trip.getBus());
        for (String seat : requestedSeats) {
            if (!validSeats.contains(seat)) {
                throw new IllegalArgumentException("Seat " + seat + " does not exist in the bus layout");
            }
        }

        // 4. Concurrency lock and seat availability checks (DB calls)
        for (String seat : requestedSeats) {
            if (!isSeatAvailable(trip, seat, fromStopOrder, toStopOrder)) {
                throw new SeatUnavailableException(
                        "Seat " + seat + " is not available for the selected segment.");
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

    private static final com.fasterxml.jackson.databind.ObjectMapper OBJECT_MAPPER = new com.fasterxml.jackson.databind.ObjectMapper();
    private static final java.util.regex.Pattern NAME_PART_PATTERN = java.util.regex.Pattern.compile("^[\\p{L}'-]{2,}$");

    private void validatePassengerName(String firstName, String lastName) {
        if (firstName == null || firstName.trim().isEmpty()) {
            throw new IllegalArgumentException("First name cannot be empty");
        }
        if (lastName == null || lastName.trim().isEmpty()) {
            throw new IllegalArgumentException("Last name cannot be empty");
        }

        if (!NAME_PART_PATTERN.matcher(firstName.trim()).matches()) {
            throw new IllegalArgumentException("First name contains invalid characters or is too short: " + firstName);
        }

        String[] lastNameParts = lastName.trim().split("\\s+");
        for (String part : lastNameParts) {
            if (!NAME_PART_PATTERN.matcher(part).matches()) {
                throw new IllegalArgumentException("Last name contains invalid part: " + part);
            }
        }
    }

    private Set<String> getValidSeatsForBus(Bus bus) {
        int busTotalSeats = bus.getTotalSeats();
        Set<String> allSeats = new HashSet<>();
        try {
            com.fasterxml.jackson.databind.JsonNode rootNode = OBJECT_MAPPER.readTree(bus.getSeatLayout());
            com.fasterxml.jackson.databind.JsonNode categories = rootNode.path("categories");
            if (categories.isObject()) {
                java.util.Iterator<String> fieldNames = categories.fieldNames();
                while (fieldNames.hasNext()) {
                    String catName = fieldNames.next();
                    com.fasterxml.jackson.databind.JsonNode seatsNode = categories.path(catName);
                    if (seatsNode.isArray()) {
                        for (com.fasterxml.jackson.databind.JsonNode seat : seatsNode) {
                            allSeats.add(seat.asText());
                        }
                    }
                }
            }
        } catch (Exception e) {
            // Log or fallback
        }

        if (allSeats.size() < busTotalSeats) {
            boolean hasLetters = false;
            for (String s : allSeats) {
                if (s.matches(".*[A-Za-z].*")) {
                    hasLetters = true;
                    break;
                }
            }
            if (hasLetters) {
                int rows = 14;
                int seatsPerRow = 4;
                try {
                    com.fasterxml.jackson.databind.JsonNode rootNode = OBJECT_MAPPER.readTree(bus.getSeatLayout());
                    if (rootNode.has("rows")) rows = rootNode.get("rows").asInt();
                    if (rootNode.has("seatsPerRow")) seatsPerRow = rootNode.get("seatsPerRow").asInt();
                } catch (Exception e) {}

                char[] letters = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'};
                for (int r = 1; r <= rows; r++) {
                    for (int c = 0; c < seatsPerRow; c++) {
                        if (allSeats.size() >= busTotalSeats) break;
                        String seatNum = r + "" + letters[c];
                        allSeats.add(seatNum);
                    }
                }
            } else {
                for (int i = 1; i <= busTotalSeats; i++) {
                    allSeats.add(String.valueOf(i));
                }
            }
        }
        return allSeats;
    }

    private boolean isPanoramicSeat(Bus bus, String seatNumber) {
        try {
            com.fasterxml.jackson.databind.JsonNode root = OBJECT_MAPPER.readTree(bus.getSeatLayout());
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
