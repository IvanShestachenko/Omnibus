package cz.cvut.ear.bus2holiday.dao;

import cz.cvut.ear.bus2holiday.model.Reservation;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Long> {
    List<Reservation> findAllByUserId(Long userId);

    List<Reservation> findByUserId(Long userId);
}
