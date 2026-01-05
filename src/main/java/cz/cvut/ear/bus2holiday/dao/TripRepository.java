package cz.cvut.ear.bus2holiday.dao;

import cz.cvut.ear.bus2holiday.model.Trip;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.OffsetDateTime;
import java.util.List;

@Repository
public interface TripRepository extends JpaRepository<Trip, Long> {

    List<Trip> findAllByRouteIdAndDepartureDatetimeBetween(
            Long routeId, OffsetDateTime start, OffsetDateTime end);

    List<Trip> findByDriverUserId(Long driverId);
}
