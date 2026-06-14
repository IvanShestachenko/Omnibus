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

    List<Trip> findAllByRouteIdAndDepartureDatetimeBetweenAndStatusAndReverse(
            Long routeId, OffsetDateTime start, OffsetDateTime end, TripStatus status, boolean reverse);

    List<Trip> findByDriverUserId(Long driverId);

    @org.springframework.data.jpa.repository.Query("SELECT DISTINCT t FROM Trip t " +
           "LEFT JOIN FETCH t.route r " +
           "LEFT JOIN FETCH r.stops s " +
           "LEFT JOIN FETCH s.terminal term " +
           "LEFT JOIN FETCH t.bus b " +
           "LEFT JOIN FETCH t.driver d " +
           "LEFT JOIN FETCH d.user u " +
           "JOIN r.stops s1 " +
           "JOIN r.stops s2 " +
           "WHERE t.departureDatetime >= :start " +
           "AND t.departureDatetime < :end " +
           "AND t.status = :status " +
           "AND r.isActive = true " +
           "AND (:fromTerminalId IS NULL OR s1.terminal.id = :fromTerminalId) " +
           "AND (:fromCity IS NULL OR LOWER(s1.terminal.city) = :fromCity) " +
           "AND (:toTerminalId IS NULL OR s2.terminal.id = :toTerminalId) " +
           "AND (:toCity IS NULL OR LOWER(s2.terminal.city) = :toCity) " +
           "AND ((t.reverse = false AND s1.sequenceOrder < s2.sequenceOrder) OR " +
           "     (t.reverse = true AND s1.sequenceOrder > s2.sequenceOrder))")
    List<Trip> findCandidateTrips(
            @org.springframework.data.repository.query.Param("start") OffsetDateTime start,
            @org.springframework.data.repository.query.Param("end") OffsetDateTime end,
            @org.springframework.data.repository.query.Param("status") TripStatus status,
            @org.springframework.data.repository.query.Param("fromTerminalId") Long fromTerminalId,
            @org.springframework.data.repository.query.Param("fromCity") String fromCity,
            @org.springframework.data.repository.query.Param("toTerminalId") Long toTerminalId,
            @org.springframework.data.repository.query.Param("toCity") String toCity);
}
