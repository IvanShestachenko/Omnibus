package cz.cvut.ear.bus2holiday.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.fasterxml.jackson.databind.ObjectMapper;

import cz.cvut.ear.bus2holiday.TestContainerConfig;
import cz.cvut.ear.bus2holiday.dao.*;
import cz.cvut.ear.bus2holiday.dto.request.CreateReservationRequest;
import cz.cvut.ear.bus2holiday.dto.request.LoginRequest;
import cz.cvut.ear.bus2holiday.dto.request.PassengerSeatRequest;
import cz.cvut.ear.bus2holiday.dto.response.AuthResponse;
import cz.cvut.ear.bus2holiday.model.*;
import cz.cvut.ear.bus2holiday.model.enums.ReservationStatus;
import cz.cvut.ear.bus2holiday.model.enums.TripStatus;
import cz.cvut.ear.bus2holiday.model.enums.UserRole;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.HashSet;
import java.util.List;

@SpringBootTest
@Transactional
@AutoConfigureMockMvc
public class ReservationControllerIntegrationTest extends TestContainerConfig {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;
    @Autowired private UserRepository userRepo;
    @Autowired private TripRepository tripRepo;
    @Autowired private ReservationRepository reservationRepo;
    @Autowired private BusRepository busRepo;
    @Autowired private RouteRepository routeRepo;
    @Autowired private TerminalRepository terminalRepo;
    @Autowired private RouteStopRepository routeStopRepo;
    @Autowired private PaymentRepository paymentRepo;
    @Autowired private PasswordEncoder passwordEncoder;

    private String userToken;
    private Trip testTrip;
    private User testUser;
    private Reservation testReservation;

    @BeforeEach
    void setUp() throws Exception {
        reservationRepo.deleteAll();
        tripRepo.deleteAll();
        routeStopRepo.deleteAll();
        routeRepo.deleteAll();
        terminalRepo.deleteAll();
        busRepo.deleteAll();
        userRepo.deleteAll();

        testUser = new User();
        testUser.setEmail("traveler@test.com");
        testUser.setPasswordHash(passwordEncoder.encode("password123"));
        testUser.setFirstName("John");
        testUser.setLastName("Traveler");
        testUser.setRole(UserRole.user);
        testUser = userRepo.save(testUser);

        MvcResult loginResult =
                mockMvc.perform(
                                post("/api/auth/login")
                                        .contentType(MediaType.APPLICATION_JSON)
                                        .content(
                                                objectMapper.writeValueAsString(
                                                        new LoginRequest(
                                                                "traveler@test.com",
                                                                "password123"))))
                        .andExpect(status().isOk())
                        .andReturn();
        AuthResponse authResponse =
                objectMapper.readValue(
                        loginResult.getResponse().getContentAsString(), AuthResponse.class);
        userToken = "Bearer " + authResponse.accessToken();

        Bus bus = new Bus();
        bus.setModel("Volvo");
        bus.setManufacturer("Volvo");
        bus.setRegistrationNumber("BUS-001");
        bus.setYear((short) 2024);
        bus.setTotalSeats(50);
        bus.setSeatLayout("{}");
        busRepo.save(bus);

        Terminal terminalPrague = new Terminal();
        terminalPrague.setName("Prague Main");
        terminalPrague.setCity("Prague");
        terminalPrague.setCountry("Czech Republic");
        terminalPrague.setStreet("Wilsonova");
        terminalPrague.setBuildingNumber("300/8");
        terminalPrague.setPostcode("120 00");
        terminalPrague.setLatitude(BigDecimal.valueOf(50.0835));
        terminalPrague.setLongitude(BigDecimal.valueOf(14.4341));
        terminalRepo.save(terminalPrague);

        Terminal terminalBrno = new Terminal();
        terminalBrno.setName("Brno Grand");
        terminalBrno.setCity("Brno");
        terminalBrno.setCountry("Czech Republic");
        terminalBrno.setStreet("Benesova");
        terminalBrno.setBuildingNumber("1");
        terminalBrno.setPostcode("602 00");
        terminalBrno.setLatitude(BigDecimal.valueOf(49.1950));
        terminalBrno.setLongitude(BigDecimal.valueOf(16.6068));
        terminalRepo.save(terminalBrno);

        Route route = new Route();
        route.setName("Prague-Brno");
        route.setActive(true);
        routeRepo.save(route);

        RouteStop stop1 = new RouteStop();
        stop1.setRoute(route);
        stop1.setTerminal(terminalPrague);
        stop1.setSequenceOrder(1);
        stop1.setArrivalOffsetMinutes(0);
        stop1.setDepartureOffsetMinutes(0);
        stop1.setDistanceFromOrigin(BigDecimal.ZERO);
        routeStopRepo.save(stop1);

        RouteStop stop2 = new RouteStop();
        stop2.setRoute(route);
        stop2.setTerminal(terminalBrno);
        stop2.setSequenceOrder(2);
        stop2.setArrivalOffsetMinutes(120);
        stop2.setDepartureOffsetMinutes(130);
        stop2.setDistanceFromOrigin(BigDecimal.valueOf(200));
        routeStopRepo.save(stop2);

        testTrip = new Trip();
        testTrip.setRoute(route);
        testTrip.setBus(bus);
        testTrip.setPrice(BigDecimal.valueOf(500));
        testTrip.setDepartureDatetime(OffsetDateTime.now(ZoneOffset.UTC).plusDays(5));
        testTrip.setArrivalDatetime(OffsetDateTime.now(ZoneOffset.UTC).plusDays(5).plusHours(2));
        testTrip.setStatus(TripStatus.SCHEDULED);
        tripRepo.save(testTrip);

        testReservation = new Reservation();
        testReservation.setUser(testUser);
        testReservation.setTrip(testTrip);
        testReservation.setBookingDate(OffsetDateTime.now(ZoneOffset.UTC));
        testReservation.setTotalAmount(BigDecimal.valueOf(500));
        testReservation.setStatus(ReservationStatus.CONFIRMED);
        testReservation.setBookingReference("SETUP-REF");

        ReservationPassenger passenger = new ReservationPassenger();
        passenger.setReservation(testReservation);
        passenger.setFirstName("John");
        passenger.setLastName("Doe");
        testReservation.setPassengers(new HashSet<>(List.of(passenger)));

        reservationRepo.save(testReservation);
    }

    @Test
    void createReservation_ShouldSucceed() throws Exception {
        PassengerSeatRequest passenger = new PassengerSeatRequest("Alice", "Smith", "1A", 1, 2);
        CreateReservationRequest request =
                new CreateReservationRequest(testTrip.getId(), List.of(passenger));

        mockMvc.perform(
                        post("/api/reservations")
                                .header("Authorization", userToken)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.status").value("PENDING"))
                .andExpect(jsonPath("$.passengers[0].firstName").value("Alice"))
                .andExpect(jsonPath("$.passengers[0].segments[0].seatNumber").value("1A"));

        assertEquals(2, reservationRepo.count());
    }

    @Test
    void createReservation_ShouldFail_WhenSeatTaken() throws Exception {
        PassengerSeatRequest p1 = new PassengerSeatRequest("Alice", "Smith", "1A", 1, 2);
        CreateReservationRequest r1 = new CreateReservationRequest(testTrip.getId(), List.of(p1));

        mockMvc.perform(
                        post("/api/reservations")
                                .header("Authorization", userToken)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(r1)))
                .andExpect(status().isCreated());

        PassengerSeatRequest p2 = new PassengerSeatRequest("Bob", "Jones", "1A", 1, 2);
        CreateReservationRequest r2 = new CreateReservationRequest(testTrip.getId(), List.of(p2));

        mockMvc.perform(
                        post("/api/reservations")
                                .header("Authorization", userToken)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(r2)))
                .andExpect(status().isConflict()) // Expect 409
                .andExpect(jsonPath("$.error").value("Seat unavailable"));
    }

    @Test
    void getMyReservations_ShouldReturnList() throws Exception {
        CreateReservationRequest request =
                new CreateReservationRequest(
                        testTrip.getId(),
                        List.of(new PassengerSeatRequest("Me", "Myself", "2B", 1, 2)));
        mockMvc.perform(
                        post("/api/reservations")
                                .header("Authorization", userToken)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated());

        mockMvc.perform(get("/api/reservations").header("Authorization", userToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(2))
                .andExpect(
                        jsonPath(
                                "$[*].passengers[*].firstName",
                                org.hamcrest.Matchers.hasItem("Me")));
    }

    @Test
    void cancelReservation_ShouldSuccess() throws Exception {
        CreateReservationRequest request =
                new CreateReservationRequest(
                        testTrip.getId(),
                        List.of(new PassengerSeatRequest("To", "Cancel", "3C", 1, 2)));
        MvcResult res =
                mockMvc.perform(
                                post("/api/reservations")
                                        .header("Authorization", userToken)
                                        .contentType(MediaType.APPLICATION_JSON)
                                        .content(objectMapper.writeValueAsString(request)))
                        .andExpect(status().isCreated())
                        .andReturn();

        String content = res.getResponse().getContentAsString();
        Long reservationId = objectMapper.readTree(content).get("id").asLong();

        mockMvc.perform(
                        delete("/api/reservations/" + reservationId)
                                .header("Authorization", userToken))
                .andExpect(status().isNoContent());
        Reservation reservation = reservationRepo.findById(reservationId).orElseThrow();
        assertEquals(ReservationStatus.CANCELLED, reservation.getStatus());
    }

    @Test
    void payReservation_ShouldSuccess() throws Exception {
        CreateReservationRequest request =
                new CreateReservationRequest(
                        testTrip.getId(),
                        List.of(new PassengerSeatRequest("Payer", "Test", "4D", 1, 2)));

        MvcResult createRes =
                mockMvc.perform(
                                post("/api/reservations")
                                        .header("Authorization", userToken)
                                        .contentType(MediaType.APPLICATION_JSON)
                                        .content(objectMapper.writeValueAsString(request)))
                        .andExpect(status().isCreated())
                        .andReturn();

        Long reservationId =
                objectMapper
                        .readTree(createRes.getResponse().getContentAsString())
                        .get("id")
                        .asLong();

        mockMvc.perform(
                        post("/api/reservations/" + reservationId + "/pay")
                                .header("Authorization", userToken))
                .andExpect(status().isOk());

        Reservation reservation = reservationRepo.findById(reservationId).orElseThrow();
        assertEquals(ReservationStatus.CONFIRMED, reservation.getStatus());

        assertEquals(1, paymentRepo.findByReservationId(reservationId).size());
        assertEquals("CONFIRMED", reservation.getStatus().name());
    }
}
