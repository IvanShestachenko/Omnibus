package cz.cvut.ear.bus2holiday.controller;

import cz.cvut.ear.bus2holiday.dto.mapper.TripMapper;
import cz.cvut.ear.bus2holiday.dto.response.TripResponse;
import cz.cvut.ear.bus2holiday.model.Trip;
import cz.cvut.ear.bus2holiday.service.TripService;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/trips")
public class TripController {

    private final TripService tripService;
    private final TripMapper tripMapper;

    public TripController(TripService tripService, TripMapper tripMapper) {
        this.tripService = tripService;
        this.tripMapper = tripMapper;
    }

    /** Search for trips by route and date. Public endpoint for users to find available trips. */
    @GetMapping("/search")
    public ResponseEntity<List<TripResponse>> searchTrips(
            @RequestParam Long routeId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        List<Trip> trips = tripService.searchTrips(routeId, date);
        return ResponseEntity.ok(trips.stream().map(tripMapper::toResponse).toList());
    }

    /** Get all trips (Admin only). */
    @GetMapping
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<List<TripResponse>> getAllTrips() {
        List<Trip> trips = tripService.findAll();
        return ResponseEntity.ok(trips.stream().map(tripMapper::toResponse).toList());
    }

    /** Get a specific trip by ID. */
    @GetMapping("/{id}")
    public ResponseEntity<TripResponse> getTrip(@PathVariable Long id) {
        Trip trip = tripService.findById(id);
        return ResponseEntity.ok(tripMapper.toResponse(trip));
    }

    /** Get available seats count for a trip. */
    @GetMapping("/{id}/available-seats")
    public ResponseEntity<Integer> getAvailableSeats(@PathVariable Long id) {
        int availableSeats = tripService.getAvailableSeats(id);
        return ResponseEntity.ok(availableSeats);
    }

    /** Create a new trip (Admin only). */
    @PostMapping
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<TripResponse> createTrip(@RequestBody Trip trip) {
        Trip created = tripService.create(trip);
        return ResponseEntity.created(URI.create("/api/trips/" + created.getId()))
                .body(tripMapper.toResponse(created));
    }

    /** Update an existing trip (Admin only). */
    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<TripResponse> updateTrip(@PathVariable Long id, @RequestBody Trip trip) {
        return ResponseEntity.ok(tripMapper.toResponse(tripService.update(id, trip)));
    }

    /** Delete a trip (Admin only). */
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<Void> deleteTrip(@PathVariable Long id) {
        tripService.delete(id);
        return ResponseEntity.noContent().build();
    }
}
