package cz.cvut.ear.bus2holiday.exception;

public class ReservationNotFoundException extends RuntimeException {
    public ReservationNotFoundException(Long id) {
        super("Reservation not found: " + id);
    }
}
