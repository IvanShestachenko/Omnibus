package cz.cvut.ear.bus2holiday.exception;

public class CancellationNotAllowedException extends RuntimeException {
    public CancellationNotAllowedException(String message) {
        super(message);
    }
}
