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

    @Query("SELECT rp FROM ReservationPassenger rp JOIN rp.reservation r " +
           "WHERE r.trip.id = :tripId AND rp.seatNumber = :seatNumber AND r.status <> cz.cvut.ear.bus2holiday.model.enums.ReservationStatus.CANCELLED")
    List<ReservationPassenger> findActivePassengersByTripAndSeat(
            @Param("tripId") Long tripId, 
            @Param("seatNumber") String seatNumber);
}
