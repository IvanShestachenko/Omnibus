package cz.cvut.ear.bus2holiday.model;

import jakarta.persistence.*;

@Entity
@Table(name = "booked_segment")
public class BookedSegment extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "trip_id", nullable = false)
    private Trip trip;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "passenger_id", nullable = false)
    private ReservationPassenger passenger;

    @Column(name = "seat_number", nullable = false, length = 10)
    private String seatNumber;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "from_stop_id", nullable = false)
    private RouteStop fromStop;

    @Column(name = "from_stop_order", nullable = false)
    private int fromStopOrder;

    @Column(name = "to_stop_order", nullable = false)
    private int toStopOrder;

    public Trip getTrip() {
        return trip;
    }

    public void setTrip(Trip trip) {
        this.trip = trip;
    }

    public ReservationPassenger getPassenger() {
        return passenger;
    }

    public void setPassenger(ReservationPassenger passenger) {
        this.passenger = passenger;
    }

    public String getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(String seatNumber) {
        this.seatNumber = seatNumber;
    }

    public int getFromStopOrder() {
        return fromStopOrder;
    }

    public void setFromStopOrder(int fromStopOrder) {
        this.fromStopOrder = fromStopOrder;
    }

    public int getToStopOrder() {
        return toStopOrder;
    }

    public void setToStopOrder(int toStopOrder) {
        this.toStopOrder = toStopOrder;
    }

    public RouteStop getFromStop() {
        return fromStop;
    }

    public void setFromStop(RouteStop fromStop) {
        this.fromStop = fromStop;
    }
}
