package cz.cvut.ear.bus2holiday.dao;

import cz.cvut.ear.bus2holiday.model.Payment;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, Long> {
    List<Payment> findByUserId(Long userId);

    List<Payment> findByReservationId(Long reservationId);
}
