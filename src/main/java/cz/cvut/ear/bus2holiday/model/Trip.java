package cz.cvut.ear.bus2holiday.model;

import cz.cvut.ear.bus2holiday.model.enums.TripStatus;

import jakarta.persistence.*;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.type.SqlTypes;

import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@NamedQuery(name = "Trip.findTripByRoute", query = "SELECT t FROM Trip t WHERE t.route = :route")
@Table(name = "trip")
public class Trip extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "route_id", nullable = false)
    private Route route;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "bus_id", nullable = false)
    private Bus bus;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "driver_id", nullable = false)
    private Driver driver;

    @Column(name = "price_koefficient", nullable = false, precision = 3, scale = 2)
    private BigDecimal priceKoefficient = BigDecimal.ONE;

    @Column(name = "reverse", nullable = false)
    private boolean reverse = false;

    @Column(name = "departure_datetime", nullable = false)
    private OffsetDateTime departureDatetime;

    @Column(name = "arrival_datetime", nullable = false)
    private OffsetDateTime arrivalDatetime;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    private TripStatus status = TripStatus.SCHEDULED;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at", nullable = false)
    private OffsetDateTime updatedAt;

    @OneToMany(mappedBy = "trip")
    private Set<Reservation> reservations = new HashSet<>();

    public Route getRoute() {
        return route;
    }

    public void setRoute(Route route) {
        this.route = route;
    }

    public Bus getBus() {
        return bus;
    }

    public void setBus(Bus bus) {
        this.bus = bus;
    }

    public Driver getDriver() {
        return driver;
    }

    public void setDriver(Driver driver) {
        this.driver = driver;
    }

    public BigDecimal getPriceKoefficient() {
        return priceKoefficient;
    }

    public void setPriceKoefficient(BigDecimal priceKoefficient) {
        this.priceKoefficient = priceKoefficient;
    }

    public boolean isReverse() {
        return reverse;
    }

    public void setReverse(boolean reverse) {
        this.reverse = reverse;
    }

    public OffsetDateTime getDepartureDatetime() {
        return departureDatetime;
    }

    public void setDepartureDatetime(OffsetDateTime departureDatetime) {
        this.departureDatetime = departureDatetime;
    }

    public OffsetDateTime getArrivalDatetime() {
        return arrivalDatetime;
    }

    public void setArrivalDatetime(OffsetDateTime arrivalDatetime) {
        this.arrivalDatetime = arrivalDatetime;
    }

    public TripStatus getStatus() {
        return status;
    }

    public void setStatus(TripStatus status) {
        this.status = status;
    }

    public OffsetDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(OffsetDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public OffsetDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(OffsetDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Set<Reservation> getReservations() {
        return reservations;
    }

    public void setReservations(Set<Reservation> reservations) {
        this.reservations = reservations;
    }
}
