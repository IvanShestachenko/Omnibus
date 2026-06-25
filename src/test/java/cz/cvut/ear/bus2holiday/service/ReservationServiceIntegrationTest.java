package cz.cvut.ear.bus2holiday.service;

import static org.junit.jupiter.api.Assertions.*;

import cz.cvut.ear.bus2holiday.TestContainerConfig;
import cz.cvut.ear.bus2holiday.dao.*;
import cz.cvut.ear.bus2holiday.dto.request.PassengerSeatRequest;
import cz.cvut.ear.bus2holiday.dto.request.ReservationRequest;
import cz.cvut.ear.bus2holiday.exception.SeatUnavailableException;
import cz.cvut.ear.bus2holiday.model.*;
import cz.cvut.ear.bus2holiday.model.enums.UserRole;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.List;

@SpringBootTest
@Transactional
public class ReservationServiceIntegrationTest extends TestContainerConfig {

    @Autowired private ReservationService reservationService;

    @Autowired private UserRepository userRepo;
    @Autowired private TripRepository tripRepo;
    @Autowired private RouteRepository routeRepository;
    @Autowired private BusRepository busRepo;
    @Autowired private DriverRepository driverRepo;
    @Autowired private TerminalRepository terminalRepository;
    @Autowired private RouteStopRepository routeStopRepository;

    private User testUser;
    private Trip testTrip;
    private Route savedRoute;

    @BeforeEach
    void setUp() {
        User u = new User();
        u.setEmail("test@user.com");
        u.setPasswordHash("hash");
        u.setFirstName("Test");
        u.setLastName("User");
        u.setRole(UserRole.user);
        testUser = userRepo.save(u);

        Bus bus = new Bus();
        bus.setModel("Mercedes");
        bus.setRegistrationNumber("1A2-3456");
        bus.setManufacturer("Daimler");
        bus.setYear((short) 2020);
        bus.setTotalSeats(50);
        bus.setSeatLayout("{\"categories\":{\"PANORAMIC\":[\"1A\",\"1B\"]}}");
        busRepo.save(bus);

        User du = new User();
        du.setEmail("driver@test.com");
        du.setPasswordHash("hash");
        du.setFirstName("Test");
        du.setLastName("Driver");
        du.setRole(UserRole.driver);
        User savedDu = userRepo.save(du);

        Driver driver = new Driver();
        driver.setUser(savedDu);
        driver.setLicenseNumber("DL-12345");
        driver.setLicenseExpiry(LocalDate.now().plusYears(5));
        driver.setAvailable(true);
        Driver savedDriver = driverRepo.save(driver);

        Route route = new Route();
        route.setName("Test Route");
        savedRoute = routeRepository.save(route);

        Terminal terminal = new Terminal();
        terminal.setName("Test Terminal");
        terminal.setCity("Test City");
        terminal.setCountry("Test Country");
        terminal.setStreet("Test Street");
        terminal.setBuildingNumber("1");
        terminal.setPostcode("12345");
        terminal.setLatitude(BigDecimal.valueOf(50.0));
        terminal.setLongitude(BigDecimal.valueOf(14.0));
        Terminal savedTerminal = terminalRepository.save(terminal);

        RouteStop stop1 = new RouteStop();
        stop1.setRoute(savedRoute);
        stop1.setTerminal(savedTerminal);
        stop1.setSequenceOrder(1);
        stop1.setArrivalOffsetMinutes(0);
        stop1.setDepartureOffsetMinutes(0);
        stop1.setDistanceFromOrigin(BigDecimal.ZERO);
        stop1.setBasePriceFromOrigin(BigDecimal.ZERO);
        routeStopRepository.save(stop1);

        RouteStop stop2 = new RouteStop();
        stop2.setRoute(savedRoute);
        stop2.setTerminal(savedTerminal);
        stop2.setSequenceOrder(2);
        stop2.setArrivalOffsetMinutes(60);
        stop2.setDepartureOffsetMinutes(65);
        stop2.setDistanceFromOrigin(BigDecimal.valueOf(100));
        stop2.setBasePriceFromOrigin(BigDecimal.valueOf(10));
        routeStopRepository.save(stop2);

        RouteStop stop3 = new RouteStop();
        stop3.setRoute(savedRoute);
        stop3.setTerminal(savedTerminal);
        stop3.setSequenceOrder(3);
        stop3.setArrivalOffsetMinutes(120);
        stop3.setDepartureOffsetMinutes(125);
        stop3.setDistanceFromOrigin(BigDecimal.valueOf(200));
        stop3.setBasePriceFromOrigin(BigDecimal.valueOf(20));
        routeStopRepository.save(stop3);

        RouteStop stop4 = new RouteStop();
        stop4.setRoute(savedRoute);
        stop4.setTerminal(savedTerminal);
        stop4.setSequenceOrder(4);
        stop4.setArrivalOffsetMinutes(180);
        stop4.setDepartureOffsetMinutes(185);
        stop4.setDistanceFromOrigin(BigDecimal.valueOf(300));
        stop4.setBasePriceFromOrigin(BigDecimal.valueOf(30));
        routeStopRepository.save(stop4);

        RouteStop stop5 = new RouteStop();
        stop5.setRoute(savedRoute);
        stop5.setTerminal(savedTerminal);
        stop5.setSequenceOrder(5);
        stop5.setArrivalOffsetMinutes(240);
        stop5.setDepartureOffsetMinutes(245);
        stop5.setDistanceFromOrigin(BigDecimal.valueOf(400));
        stop5.setBasePriceFromOrigin(BigDecimal.valueOf(40));
        routeStopRepository.save(stop5);

        RouteStop stop6 = new RouteStop();
        stop6.setRoute(savedRoute);
        stop6.setTerminal(savedTerminal);
        stop6.setSequenceOrder(6);
        stop6.setArrivalOffsetMinutes(300);
        stop6.setDepartureOffsetMinutes(300);
        stop6.setDistanceFromOrigin(BigDecimal.valueOf(500));
        stop6.setBasePriceFromOrigin(BigDecimal.valueOf(50));
        routeStopRepository.save(stop6);

        Trip t = new Trip();
        t.setRoute(savedRoute);
        t.setBus(bus);
        t.setDriver(savedDriver);
        t.setPriceKoefficient(BigDecimal.ONE);
        t.setDepartureDatetime(OffsetDateTime.now(ZoneOffset.UTC).plusDays(1));
        t.setArrivalDatetime(OffsetDateTime.now(ZoneOffset.UTC).plusDays(1).plusHours(5));
        testTrip = tripRepo.save(t);
    }

    @Test
    void testCreateReservation_HappyPath() {
        PassengerSeatRequest p1 = new PassengerSeatRequest("Alice", "Smith", "1A");
        PassengerSeatRequest p2 = new PassengerSeatRequest("Bob", "Jones", "1B");
        ReservationRequest request =
                new ReservationRequest(testUser.getId(), testTrip.getId(), 1, 5, List.of(p1, p2));

        Reservation reservation = reservationService.createReservation(request);

        assertNotNull(reservation);
        assertNotNull(reservation.getId());
        assertEquals(2, reservation.getPassengers().size());
    }

    @Test
    void testCreateReservation_FailOnOverlappingSegment() {
        PassengerSeatRequest initialPassenger =
                new PassengerSeatRequest("Initial", "Booker", "2A");
        ReservationRequest initialRequest =
                new ReservationRequest(
                        testUser.getId(), testTrip.getId(), 2, 5, List.of(initialPassenger));
        reservationService.createReservation(initialRequest);

        PassengerSeatRequest overlappingPassenger =
                new PassengerSeatRequest("Late", "Booker", "2A");
        ReservationRequest overlappingRequest =
                new ReservationRequest(
                        testUser.getId(), testTrip.getId(), 4, 6, List.of(overlappingPassenger));

        assertThrows(
                SeatUnavailableException.class,
                () -> {
                    reservationService.createReservation(overlappingRequest);
                });
    }

    @Test
    void testCreateReservation_SuccessOnNonOverlappingSegment() {
        PassengerSeatRequest p1 = new PassengerSeatRequest("Anna", "First", "3B");
        ReservationRequest r1 =
                new ReservationRequest(testUser.getId(), testTrip.getId(), 1, 3, List.of(p1));
        reservationService.createReservation(r1);

        PassengerSeatRequest p2 = new PassengerSeatRequest("Boris", "Second", "3B");
        ReservationRequest r2 =
                new ReservationRequest(testUser.getId(), testTrip.getId(), 3, 5, List.of(p2));

        assertDoesNotThrow(
                () -> {
                    reservationService.createReservation(r2);
                });
    }
}
