package cz.cvut.ear.bus2holiday.dao;

import cz.cvut.ear.bus2holiday.model.BookedSegment;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookedSegmentRepository extends JpaRepository<BookedSegment, Long> {

    List<BookedSegment> findByTripIdAndSeatNumber(Long tripId, String seatNumber);

    void deleteByPassenger_Reservation_Id(Long reservationId);
}
