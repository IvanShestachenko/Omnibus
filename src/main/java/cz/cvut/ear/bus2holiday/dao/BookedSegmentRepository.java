package cz.cvut.ear.bus2holiday.dao;

import cz.cvut.ear.bus2holiday.model.BookedSegment;

import jakarta.persistence.LockModeType;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookedSegmentRepository extends JpaRepository<BookedSegment, Long> {

    List<BookedSegment> findByTripIdAndSeatNumber(Long tripId, String seatNumber);

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query(
            "SELECT bs FROM BookedSegment bs "
                    + "WHERE bs.trip.id = :tripId AND bs.seatNumber = :seatNumber")
    List<BookedSegment> findByTripIdAndSeatNumberForUpdate(
            @Param("tripId") Long tripId, @Param("seatNumber") String seatNumber);

    void deleteByPassenger_Reservation_Id(Long reservationId);
}
