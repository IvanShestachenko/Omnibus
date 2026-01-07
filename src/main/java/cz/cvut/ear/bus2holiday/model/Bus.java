package cz.cvut.ear.bus2holiday.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import cz.cvut.ear.bus2holiday.model.enums.BusStatus;

import jakarta.persistence.*;
import jakarta.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.type.SqlTypes;

import java.time.OffsetDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "bus")
public class Bus extends BaseEntity {

    @Column(nullable = false, length = 100)
    private String model;

    @Column(name = "registration_number", nullable = false, unique = true, length = 20)
    private String registrationNumber;

    @Column(nullable = false, length = 100)
    private String manufacturer;

    @Column(nullable = false)
    private short year;

    @Column(name = "total_seats", nullable = false)
    private int totalSeats;

    @Column(name = "seat_layout", nullable = false)
    @JdbcTypeCode(SqlTypes.JSON)
    private String seatLayout;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, columnDefinition = "bus_status")
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    private BusStatus status = BusStatus.ACTIVE;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at", nullable = false)
    private OffsetDateTime updatedAt;

    @JsonIgnore
    @OneToMany(mappedBy = "bus")
    private Set<Trip> trips = new HashSet<>();

    @JsonIgnore
    @ManyToMany
    @JoinTable(
            name = "buses_on_routes",
            joinColumns = @JoinColumn(name = "bus_id"),
            inverseJoinColumns = @JoinColumn(name = "route_id"))
    private Set<Route> routes = new HashSet<>();

    public String getModel() {
        return model;
    }

    public String getRegistrationNumber() {
        return registrationNumber;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public short getYear() {
        return year;
    }

    public int getTotalSeats() {
        return totalSeats;
    }

    public String getSeatLayout() {
        return seatLayout;
    }

    public BusStatus getStatus() {
        return status;
    }

    public OffsetDateTime getCreatedAt() {
        return createdAt;
    }

    public OffsetDateTime getUpdatedAt() {
        return updatedAt;
    }

    public Set<Trip> getTrips() {
        return trips;
    }

    public Set<Route> getRoutes() {
        return routes;
    }

    public void setRegistrationNumber(String registrationNumber) {
        this.registrationNumber = registrationNumber;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public void setYear(short year) {
        this.year = year;
    }

    public void setTotalSeats(int totalSeats) {
        this.totalSeats = totalSeats;
    }

    public void setSeatLayout(String seatLayout) {
        this.seatLayout = seatLayout;
    }

    public void setStatus(BusStatus status) {
        this.status = status;
    }

    public void setCreatedAt(OffsetDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(OffsetDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public void setTrips(Set<Trip> trips) {
        this.trips = trips;
    }

    public void setRoutes(Set<Route> routes) {
        this.routes = routes;
    }
}
