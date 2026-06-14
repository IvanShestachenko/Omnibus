package cz.cvut.ear.bus2holiday.dao;

import cz.cvut.ear.bus2holiday.model.ReservationPassenger;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReservationPassengerRepository extends JpaRepository<ReservationPassenger, Long> {

    @Query(value = "SELECT 1 FROM pg_advisory_xact_lock(cast(:tripId as int), hashtext(:seatNumber))", nativeQuery = true)
    void acquireAdvisoryLockForSeat(@Param("tripId") Long tripId, @Param("seatNumber") String seatNumber);

    @Query(value = "SELECT rp.* FROM reservation_passenger rp JOIN reservation r ON r.id = rp.reservation_id " +
           "WHERE r.trip_id = :tripId AND rp.seat_number = :seatNumber AND r.status <> 'CANCELLED'", nativeQuery = true)
    List<ReservationPassenger> findActivePassengersByTripAndSeat(
            @Param("tripId") Long tripId, 
            @Param("seatNumber") String seatNumber);

    @Query(value = "SELECT rp.seat_number FROM reservation_passenger rp JOIN reservation r ON r.id = rp.reservation_id " +
           "JOIN route_stop ors ON ors.id = r.origin_route_stop_id " +
           "JOIN route_stop trs ON trs.id = r.target_route_stop_id " +
           "WHERE r.trip_id = :tripId " +
           "AND r.status <> 'CANCELLED' " +
           "AND ((ors.sequence_order < :maxQuery AND :minQuery < trs.sequence_order) OR " +
           "     (trs.sequence_order < :maxQuery AND :minQuery < ors.sequence_order))", nativeQuery = true)
    List<String> findOccupiedSeatsForTripAndSegment(
            @Param("tripId") Long tripId,
            @Param("minQuery") int minQuery,
            @Param("maxQuery") int maxQuery);
}
