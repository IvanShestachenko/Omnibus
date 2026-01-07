package cz.cvut.ear.bus2holiday.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;
import jakarta.persistence.Table;

import java.math.BigDecimal;

@Entity
@Table(
        name = "route_stop",
        uniqueConstraints = {@UniqueConstraint(columnNames = {"route_id", "sequence_order"})})
public class RouteStop extends BaseEntity {

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "route_id", nullable = false)
    private Route route;

    @Column(name = "sequence_order", nullable = false)
    private int sequenceOrder;

    @Column(name = "arrival_offset_minutes", nullable = false)
    private int arrivalOffsetMinutes;

    @Column(name = "departure_offset_minutes", nullable = false)
    private int departureOffsetMinutes;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "terminal_id", nullable = false)
    private Terminal terminal;

    @Column(name = "distance_from_origin", nullable = false, precision = 8, scale = 2)
    private BigDecimal distanceFromOrigin;

    public Route getRoute() {
        return route;
    }

    public void setRoute(Route route) {
        this.route = route;
    }

    public int getSequenceOrder() {
        return sequenceOrder;
    }

    public void setSequenceOrder(int sequenceOrder) {
        this.sequenceOrder = sequenceOrder;
    }

    public int getArrivalOffsetMinutes() {
        return arrivalOffsetMinutes;
    }

    public void setArrivalOffsetMinutes(int arrivalOffsetMinutes) {
        this.arrivalOffsetMinutes = arrivalOffsetMinutes;
    }

    public int getDepartureOffsetMinutes() {
        return departureOffsetMinutes;
    }

    public void setDepartureOffsetMinutes(int departureOffsetMinutes) {
        this.departureOffsetMinutes = departureOffsetMinutes;
    }

    public Terminal getTerminal() {
        return terminal;
    }

    public void setTerminal(Terminal terminal) {
        this.terminal = terminal;
    }

    public BigDecimal getDistanceFromOrigin() {
        return distanceFromOrigin;
    }

    public void setDistanceFromOrigin(BigDecimal distanceFromOrigin) {
        this.distanceFromOrigin = distanceFromOrigin;
    }
}
