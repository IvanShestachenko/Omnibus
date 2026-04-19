package cz.cvut.ear.bus2holiday.dao;

import cz.cvut.ear.bus2holiday.model.Trip;
import cz.cvut.ear.bus2holiday.model.enums.TripStatus;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.OffsetDateTime;
import java.util.List;

@Repository
public interface TripRepository extends JpaRepository<Trip, Long> {

    List<Trip> findAllByRouteIdAndDepartureDatetimeBetween(
            Long routeId, OffsetDateTime start, OffsetDateTime end);

    List<Trip> findAllByRouteIdAndDepartureDatetimeBetweenAndStatus(
            Long routeId, OffsetDateTime start, OffsetDateTime end, TripStatus status);

    List<Trip> findByDriverUserId(Long driverId);
}
