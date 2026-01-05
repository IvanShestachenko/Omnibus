package cz.cvut.ear.bus2holiday.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import cz.cvut.ear.bus2holiday.dao.PaymentRepository;
import cz.cvut.ear.bus2holiday.dao.ReservationRepository;
import cz.cvut.ear.bus2holiday.exception.ForbiddenException;
import cz.cvut.ear.bus2holiday.exception.ReservationNotFoundException;
import cz.cvut.ear.bus2holiday.model.Payment;
import cz.cvut.ear.bus2holiday.model.Reservation;
import cz.cvut.ear.bus2holiday.model.User;
import cz.cvut.ear.bus2holiday.model.enums.PaymentStatus;
import cz.cvut.ear.bus2holiday.model.enums.ReservationStatus;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.util.Optional;

@ExtendWith(MockitoExtension.class)
class PaymentServiceTest {

    @Mock private PaymentRepository paymentRepo;

    @Mock private ReservationRepository reservationRepo;

    @InjectMocks private PaymentService paymentService;

    private Reservation testReservation;
    private User testUser;

    @BeforeEach
    void setUp() {
        testUser = new User();
        testUser.setId(1L);
        testUser.setEmail("user@test.com");

        testReservation = new Reservation();
        testReservation.setId(100L);
        testReservation.setUser(testUser);
        testReservation.setStatus(ReservationStatus.PENDING);
        testReservation.setTotalAmount(BigDecimal.valueOf(500));
    }

    @Test
    void payReservation_WhenValid_ShouldCreatePaymentAndConfirm() {
        when(reservationRepo.findById(100L)).thenReturn(Optional.of(testReservation));
        when(paymentRepo.save(any(Payment.class))).thenAnswer(inv -> inv.getArgument(0));
        when(reservationRepo.save(any(Reservation.class))).thenAnswer(inv -> inv.getArgument(0));

        paymentService.payReservation(100L, 1L);

        ArgumentCaptor<Payment> paymentCaptor = ArgumentCaptor.forClass(Payment.class);
        verify(paymentRepo).save(paymentCaptor.capture());

        Payment savedPayment = paymentCaptor.getValue();
        assertEquals(PaymentStatus.COMPLETED, savedPayment.getStatus());
        assertEquals(BigDecimal.valueOf(500), savedPayment.getAmount());
        assertEquals("CZK", savedPayment.getCurrency());
        assertNotNull(savedPayment.getTransactionId());

        assertEquals(ReservationStatus.CONFIRMED, testReservation.getStatus());
    }

    @Test
    void payReservation_WhenNotOwner_ShouldThrowForbidden() {
        when(reservationRepo.findById(100L)).thenReturn(Optional.of(testReservation));

        assertThrows(ForbiddenException.class, () -> paymentService.payReservation(100L, 999L));
    }

    @Test
    void payReservation_WhenNotPending_ShouldThrowIllegalState() {
        testReservation.setStatus(ReservationStatus.CONFIRMED);
        when(reservationRepo.findById(100L)).thenReturn(Optional.of(testReservation));

        assertThrows(IllegalStateException.class, () -> paymentService.payReservation(100L, 1L));
    }

    @Test
    void payReservation_WhenNotFound_ShouldThrowNotFound() {
        when(reservationRepo.findById(999L)).thenReturn(Optional.empty());

        assertThrows(
                ReservationNotFoundException.class, () -> paymentService.payReservation(999L, 1L));
    }
}
