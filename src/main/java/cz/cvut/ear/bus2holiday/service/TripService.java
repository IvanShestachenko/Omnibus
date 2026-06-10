package cz.cvut.ear.bus2holiday.service;

import cz.cvut.ear.bus2holiday.dao.TripRepository;
import cz.cvut.ear.bus2holiday.exception.ResourceNotFoundException;
import cz.cvut.ear.bus2holiday.model.Trip;
import cz.cvut.ear.bus2holiday.model.enums.TripStatus;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.List;

@Service
@Transactional(readOnly = true)
public class TripService {

    private final TripRepository tripRepository;

    public TripService(TripRepository tripRepository) {
        this.tripRepository = tripRepository;
    }

    public List<Trip> findAll() {
        return tripRepository.findAll();
    }

    public Trip findById(Long id) {
        return tripRepository
                .findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Trip not found with id: " + id));
    }

    public List<Trip> searchTrips(Long routeId, LocalDate date) {
        OffsetDateTime startOfDay = date.atStartOfDay().atOffset(ZoneOffset.UTC);
        OffsetDateTime endOfDay = date.plusDays(1).atStartOfDay().atOffset(ZoneOffset.UTC);

        return tripRepository.findAllByRouteIdAndDepartureDatetimeBetweenAndStatus(
                routeId, startOfDay, endOfDay, TripStatus.SCHEDULED);
    }

    public List<Trip> findByDriverId(Long driverId) {
        return tripRepository.findByDriverUserId(driverId);
    }

    @Transactional
    public Trip create(Trip trip) {
        trip.setStatus(TripStatus.SCHEDULED);
        return tripRepository.save(trip);
    }

    @Transactional
    public Trip update(Long id, Trip tripDetails) {
        Trip trip = findById(id);
        trip.setRoute(tripDetails.getRoute());
        trip.setBus(tripDetails.getBus());
        trip.setDriver(tripDetails.getDriver());
        trip.setPriceKoefficient(tripDetails.getPriceKoefficient());
        trip.setReverse(tripDetails.isReverse());
        trip.setDepartureDatetime(tripDetails.getDepartureDatetime());
        trip.setArrivalDatetime(tripDetails.getArrivalDatetime());
        return tripRepository.save(trip);
    }

    @Transactional
    public void updateStatus(Long id, TripStatus status) {
        Trip trip = findById(id);
        trip.setStatus(status);
        tripRepository.save(trip);
    }

    @Transactional
    public void delete(Long id) {
        Trip trip = findById(id);
        tripRepository.delete(trip);
    }

    public int getAvailableSeats(Long tripId) {
        Trip trip = findById(tripId);
        int totalSeats = trip.getBus().getTotalSeats();
        List<cz.cvut.ear.bus2holiday.model.RouteStop> stops = trip.getRoute().getStops();
        if (stops.size() < 2) {
            return totalSeats;
        }
        int numSegments = stops.size() - 1;
        int[] bookedCount = new int[numSegments];

        for (cz.cvut.ear.bus2holiday.model.Reservation res : trip.getReservations()) {
            if (res.getStatus() == cz.cvut.ear.bus2holiday.model.enums.ReservationStatus.CANCELLED) {
                continue;
            }
            int start = res.getOriginRouteStop().getSequenceOrder();
            int end = res.getTargetRouteStop().getSequenceOrder();

            int startIdx = -1;
            int endIdx = -1;
            for (int i = 0; i < stops.size(); i++) {
                if (stops.get(i).getSequenceOrder() == start) {
                    startIdx = i;
                }
                if (stops.get(i).getSequenceOrder() == end) {
                    endIdx = i;
                }
            }

            if (startIdx != -1 && endIdx != -1) {
                int from = Math.min(startIdx, endIdx);
                int to = Math.max(startIdx, endIdx);
                for (int s = from; s < to; s++) {
                    bookedCount[s] += res.getPassengers().size();
                }
            }
        }

        int maxBooked = 0;
        for (int count : bookedCount) {
            if (count > maxBooked) {
                maxBooked = count;
            }
        }
        return totalSeats - maxBooked;
    }
}
