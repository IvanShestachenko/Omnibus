package cz.cvut.ear.bus2holiday.dao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import cz.cvut.ear.bus2holiday.TestContainerConfig;
import cz.cvut.ear.bus2holiday.model.Bus;
import cz.cvut.ear.bus2holiday.model.Route;
import cz.cvut.ear.bus2holiday.model.Terminal;
import cz.cvut.ear.bus2holiday.model.Trip;
import cz.cvut.ear.bus2holiday.model.User;
import cz.cvut.ear.bus2holiday.model.enums.UserRole;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.List;

@SpringBootTest
@Transactional
public class NamedQueriesTest extends TestContainerConfig {

    @PersistenceContext private EntityManager em;

    @Autowired private UserRepository userRepository;
    @Autowired private RouteRepository routeRepository;
    @Autowired private TerminalRepository terminalRepository;
    @Autowired private TripRepository tripRepository;
    @Autowired private BusRepository busRepository;

    @Test
    public void findByRole_ShouldReturnUsersWithSpecifiedRole() {
        User user1 = new User();
        user1.setFirstName("Misha");
        user1.setLastName("Admin");
        user1.setEmail("misha@example.com");
        user1.setPasswordHash("hash");
        user1.setPhone("123456789");
        user1.setRole(UserRole.admin);
        userRepository.save(user1);

        User user2 = new User();
        user2.setFirstName("Vanya");
        user2.setLastName("User");
        user2.setEmail("vanya@example.com");
        user2.setPasswordHash("hash");
        user2.setPhone("987654321");
        user2.setRole(UserRole.user);
        userRepository.save(user2);

        List<User> admins =
                em.createNamedQuery("User.findByRole", User.class)
                        .setParameter("role", UserRole.admin)
                        .getResultList();

        assertEquals(1, admins.size());
        assertEquals("Misha", admins.get(0).getFirstName());

        List<User> users =
                em.createNamedQuery("User.findByRole", User.class)
                        .setParameter("role", UserRole.user)
                        .getResultList();

        assertEquals(1, users.size());
        assertEquals("Vanya", users.get(0).getFirstName());
    }

    @Test
    public void findAllActive_ShouldReturnOnlyActiveRoutes() {
        Route activeRoute = new Route();
        activeRoute.setName("Active Route");
        activeRoute.setActive(true);
        routeRepository.save(activeRoute);

        Route inactiveRoute = new Route();
        inactiveRoute.setName("Inactive Route");
        inactiveRoute.setActive(false);
        routeRepository.save(inactiveRoute);

        List<Route> result =
                em.createNamedQuery("Route.findAllActive", Route.class).getResultList();

        assertEquals(1, result.size());
        assertEquals("Active Route", result.get(0).getName());
    }

    @Test
    public void findAllTerminals_ShouldReturnAllTerminals() {
        Terminal t1 = new Terminal();
        t1.setName("Terminal 1");
        t1.setCity("Prague");
        t1.setCountry("Czech Republic");
        t1.setStreet("Main St");
        t1.setBuildingNumber("1");
        t1.setPostcode("11000");
        t1.setLatitude(BigDecimal.valueOf(50.0));
        t1.setLongitude(BigDecimal.valueOf(14.0));
        terminalRepository.save(t1);

        Terminal t2 = new Terminal();
        t2.setName("Terminal 2");
        t2.setCity("Brno");
        t2.setCountry("Czech Republic");
        t2.setStreet("Second St");
        t2.setBuildingNumber("2");
        t2.setPostcode("60200");
        t2.setLatitude(BigDecimal.valueOf(49.0));
        t2.setLongitude(BigDecimal.valueOf(16.0));
        terminalRepository.save(t2);

        List<Terminal> result =
                em.createNamedQuery("Terminal.findAllTerminals", Terminal.class).getResultList();

        assertTrue(result.size() >= 2);
    }

    @Test
    public void findTripByRoute_ShouldReturnTripsForRoute() {
        Route route1 = new Route();
        route1.setName("Route 1");
        routeRepository.save(route1);

        Route route2 = new Route();
        route2.setName("Route 2");
        routeRepository.save(route2);

        Bus bus = new Bus();
        bus.setTotalSeats(50);
        bus.setRegistrationNumber("ABC-123");
        bus.setModel("Mercedes");
        bus.setRegistrationNumber("1A2-3456");
        bus.setManufacturer("Daimler");
        bus.setYear((short) 2020);
        bus.setTotalSeats(50);
        bus.setSeatLayout("{}");
        busRepository.save(bus);

        Trip trip1 = new Trip();
        trip1.setRoute(route1);
        trip1.setBus(bus);
        trip1.setPrice(new BigDecimal("100.00"));
        trip1.setDepartureDatetime(OffsetDateTime.now(ZoneOffset.UTC).plusDays(1));
        trip1.setArrivalDatetime(OffsetDateTime.now(ZoneOffset.UTC).plusDays(1).plusHours(2));
        tripRepository.save(trip1);

        Trip trip2 = new Trip();
        trip2.setRoute(route2);
        trip2.setBus(bus);
        trip2.setPrice(new BigDecimal("200.00"));
        trip2.setDepartureDatetime(OffsetDateTime.now(ZoneOffset.UTC).plusDays(2));
        trip2.setArrivalDatetime(OffsetDateTime.now(ZoneOffset.UTC).plusDays(2).plusHours(2));
        tripRepository.save(trip2);

        List<Trip> result =
                em.createNamedQuery("Trip.findTripByRoute", Trip.class)
                        .setParameter("route", route1)
                        .getResultList();

        assertEquals(1, result.size());
        assertEquals(trip1.getId(), result.get(0).getId());
    }
}
