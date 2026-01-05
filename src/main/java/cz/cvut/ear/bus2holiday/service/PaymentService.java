package cz.cvut.ear.bus2holiday.service;

import cz.cvut.ear.bus2holiday.dao.PaymentRepository;
import cz.cvut.ear.bus2holiday.dao.ReservationRepository;
import cz.cvut.ear.bus2holiday.exception.ForbiddenException;
import cz.cvut.ear.bus2holiday.exception.ReservationNotFoundException;
import cz.cvut.ear.bus2holiday.model.Payment;
import cz.cvut.ear.bus2holiday.model.Reservation;
import cz.cvut.ear.bus2holiday.model.enums.PaymentStatus;
import cz.cvut.ear.bus2holiday.model.enums.ReservationStatus;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class PaymentService {

    private final PaymentRepository paymentRepo;
    private final ReservationRepository reservationRepo;

    @Transactional
    public void payReservation(Long reservationId, Long userId) {
        Reservation reservation =
                reservationRepo
                        .findById(reservationId)
                        .orElseThrow(() -> new ReservationNotFoundException(reservationId));

        if (!reservation.getUser().getId().equals(userId)) {
            throw new ForbiddenException("You can only pay for your own reservations");
        }

        if (reservation.getStatus() != ReservationStatus.PENDING) {
            throw new IllegalStateException(
                    "Reservation is not in PENDING state. Current status: "
                            + reservation.getStatus());
        }

        String transactionId = UUID.randomUUID().toString();

        Payment payment = new Payment();
        payment.setReservation(reservation);
        payment.setUser(reservation.getUser());
        payment.setAmount(reservation.getTotalAmount());
        payment.setCurrency("CZK");
        payment.setStatus(PaymentStatus.COMPLETED);
        payment.setTransactionId(transactionId);
        payment.setPaidAt(OffsetDateTime.now(ZoneOffset.UTC));
        payment.setGatewayResponse("{\"status\": \"success\", \"mock\": true}");

        paymentRepo.save(payment);

        reservation.setStatus(ReservationStatus.CONFIRMED);
        reservationRepo.save(reservation);
    }
}
