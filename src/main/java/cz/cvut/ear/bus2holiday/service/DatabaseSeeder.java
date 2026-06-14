package cz.cvut.ear.bus2holiday.service;

import cz.cvut.ear.bus2holiday.dao.BusRepository;
import cz.cvut.ear.bus2holiday.dao.DriverRepository;
import cz.cvut.ear.bus2holiday.dao.RouteRepository;
import cz.cvut.ear.bus2holiday.dao.TripRepository;
import cz.cvut.ear.bus2holiday.model.Bus;
import cz.cvut.ear.bus2holiday.model.Driver;
import cz.cvut.ear.bus2holiday.model.Route;
import cz.cvut.ear.bus2holiday.model.Trip;
import cz.cvut.ear.bus2holiday.model.User;
import cz.cvut.ear.bus2holiday.model.RouteStop;
import cz.cvut.ear.bus2holiday.model.enums.ReservationStatus;
import org.springframework.boot.CommandLineRunner;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Component
public class DatabaseSeeder implements CommandLineRunner {

    private final RouteRepository routeRepository;
    private final TripRepository tripRepository;
    private final BusRepository busRepository;
    private final DriverRepository driverRepository;
    private final JdbcTemplate jdbcTemplate;

    public DatabaseSeeder(
            RouteRepository routeRepository,
            TripRepository tripRepository,
            BusRepository busRepository,
            DriverRepository driverRepository,
            JdbcTemplate jdbcTemplate) {
        this.routeRepository = routeRepository;
        this.tripRepository = tripRepository;
        this.busRepository = busRepository;
        this.driverRepository = driverRepository;
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    @Transactional
    public void run(String... args) throws Exception {
        if (tripRepository.count() > 0) {
            return;
        }

        List<Route> routes = routeRepository.findAll();
        List<Bus> allBuses = busRepository.findAll();
        List<Driver> allDrivers = driverRepository.findAll();

        if (routes.isEmpty() || allBuses.isEmpty() || allDrivers.isEmpty()) {
            return;
        }

        // 1. Seed users if not present
        Integer userCount = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM \"user\" WHERE role = 'user'", Integer.class);
        if (userCount == null || userCount == 0) {
            List<TempUserDto> usersToSave = new ArrayList<>();
            String[] firstNames = {"John", "Emma", "Michael", "Sophia", "William", "Olivia", "James", "Ava", "David", "Isabella", "Richard", "Mia", "Joseph", "Charlotte", "Thomas", "Amelia", "Charles", "Evelyn", "Daniel", "Abigail"};
            String[] lastNames = {"Smith", "Johnson", "Williams", "Brown", "Jones", "Miller", "Davis", "Garcia", "Rodriguez", "Wilson", "Martinez", "Anderson", "Taylor", "Thomas", "Hernandez", "Moore", "Martin", "Jackson", "Thompson", "White"};

            for (int i = 1; i <= 200; i++) {
                String firstName = firstNames[i % firstNames.length];
                String lastName = lastNames[(i + i / firstNames.length) % lastNames.length];
                String email = "user." + i + "@omnibus.com";
                String phone = "+420700" + String.format("%06d", i);
                String passwordHash = "$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG"; // standard driver password hash
                usersToSave.add(new TempUserDto(firstName, lastName, email, phone, passwordHash));
            }

            String userSql = "INSERT INTO \"user\" (first_name, last_name, email, password_hash, phone, preferred_currency, role, created_at, updated_at) " +
                             "VALUES (?, ?, ?, ?, ?, 'EUR', 'user', NOW(), NOW())";
            
            jdbcTemplate.batchUpdate(userSql, new BatchPreparedStatementSetter() {
                @Override
                public void setValues(PreparedStatement ps, int idx) throws SQLException {
                    TempUserDto user = usersToSave.get(idx);
                    ps.setString(1, user.firstName);
                    ps.setString(2, user.lastName);
                    ps.setString(3, user.email);
                    ps.setString(4, user.passwordHash);
                    ps.setString(5, user.phone);
                }

                @Override
                public int getBatchSize() {
                    return usersToSave.size();
                }
            });
        }

        // Fetch user pool
        List<User> userPool = jdbcTemplate.query("SELECT id, first_name, last_name FROM \"user\" WHERE role = 'user'", (rs, rowNum) -> {
            User u = new User();
            u.setId(rs.getLong("id"));
            u.setFirstName(rs.getString("first_name"));
            u.setLastName(rs.getString("last_name"));
            return u;
        });

        if (userPool.isEmpty()) {
            return;
        }

        List<TempTripDto> tripsToSave = new ArrayList<>();
        LocalDate startDate = LocalDate.now();
        int daysToSeed = 180; // 6 months

        for (Route route : routes) {
            List<Bus> routeBuses = new ArrayList<>(route.getBuses());
            if (routeBuses.isEmpty()) {
                routeBuses = allBuses;
            }
            List<Driver> routeDrivers = new ArrayList<>(route.getDrivers());
            if (routeDrivers.isEmpty()) {
                routeDrivers = allDrivers;
            }

            boolean isDomestic = !isInternationalRoute(route.getName());

            int tripsPerDay = isDomestic ? 6 : 3;
            LocalTime[] departureTimes = getDepartureTimes(isDomestic);

            // Generate a deterministic random minute offset for this route (between 1 and 59)
            int randomMinute = new java.util.Random(route.getName().hashCode()).nextInt(59) + 1;

            int tripIndex = 0;
            for (int day = 0; day < daysToSeed; day++) {
                LocalDate seedDate = startDate.plusDays(day);

                for (int t = 0; t < tripsPerDay; t++) {
                    LocalTime depTime = departureTimes[t].withMinute(randomMinute);
                    OffsetDateTime depDateTime = OffsetDateTime.of(seedDate, depTime, ZoneOffset.UTC);

                    int durationMinutes = 180; // default 3 hours
                    if (route.getStops() != null && !route.getStops().isEmpty()) {
                        durationMinutes = route.getStops().get(route.getStops().size() - 1).getDepartureOffsetMinutes();
                    }
                    OffsetDateTime arrDateTime = depDateTime.plusMinutes(durationMinutes);

                    BigDecimal priceKoefficient = BigDecimal.ONE;
                    int hour = depTime.getHour();
                    if (hour >= 17 && hour <= 22) {
                        priceKoefficient = new BigDecimal("1.20");
                    }

                    boolean isReverse = false;
                    if (isDomestic) {
                        isReverse = (t % 2 == 1);
                    } else {
                        isReverse = ((day + t) % 2 == 1);
                    }

                    Bus bus = routeBuses.get(tripIndex % routeBuses.size());
                    Driver driver = routeDrivers.get(tripIndex % routeDrivers.size());

                    tripsToSave.add(new TempTripDto(
                            route.getId(),
                            bus.getId(),
                            driver.getUserId(),
                            priceKoefficient,
                            isReverse,
                            depDateTime,
                            arrDateTime
                    ));

                    tripIndex++;
                }
            }
        }

        // Execute batch insert via JdbcTemplate
        if (!tripsToSave.isEmpty()) {
            List<Long> tripIds = allocateIds("trip", tripsToSave.size());
            for (int i = 0; i < tripsToSave.size(); i++) {
                tripsToSave.get(i).id = tripIds.get(i);
            }

            String sql = "INSERT INTO trip (id, route_id, bus_id, driver_id, price_koefficient, reverse, departure_datetime, arrival_datetime, status, created_at, updated_at) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'SCHEDULED', NOW(), NOW())";
            
            int batchSize = 1000;
            for (int i = 0; i < tripsToSave.size(); i += batchSize) {
                final List<TempTripDto> batchList = tripsToSave.subList(i, Math.min(i + batchSize, tripsToSave.size()));
                
                jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
                    @Override
                    public void setValues(PreparedStatement ps, int idx) throws SQLException {
                        TempTripDto trip = batchList.get(idx);
                        ps.setLong(1, trip.id);
                        ps.setLong(2, trip.routeId);
                        ps.setLong(3, trip.busId);
                        ps.setLong(4, trip.driverId);
                        ps.setBigDecimal(5, trip.priceKoefficient);
                        ps.setBoolean(6, trip.reverse);
                        ps.setTimestamp(7, Timestamp.from(trip.departureDatetime.toInstant()));
                        ps.setTimestamp(8, Timestamp.from(trip.arrivalDatetime.toInstant()));
                    }

                    @Override
                    public int getBatchSize() {
                        return batchList.size();
                    }
                });
            }
        }

        // Generate and seed reservations
        List<TempReservationDto> reservationsToSave = new ArrayList<>();
        Map<Long, Route> routeMap = new HashMap<>();
        for (Route r : routes) {
            routeMap.put(r.getId(), r);
        }
        Map<Long, Bus> busMap = new HashMap<>();
        for (Bus b : allBuses) {
            busMap.put(b.getId(), b);
        }

        String[] passengerFirstNames = {"David", "Robert", "John", "James", "William", "Charles", "Daniel", "Matthew", "Donald", "George", "Mary", "Patricia", "Jennifer", "Elizabeth", "Linda", "Barbara", "Susan", "Jessica", "Sarah", "Karen"};
        String[] passengerLastNames = {"Smith", "Johnson", "Williams", "Brown", "Jones", "Miller", "Davis", "Garcia", "Rodriguez", "Wilson", "Martinez", "Anderson", "Taylor", "Thomas", "Hernandez", "Moore", "Martin", "Jackson", "Thompson", "White"};

        Set<String> generatedRefs = new HashSet<>();

        for (TempTripDto trip : tripsToSave) {
            Route route = routeMap.get(trip.routeId);
            Bus bus = busMap.get(trip.busId);

            if (route == null || bus == null) continue;

            List<RouteStop> stops = new ArrayList<>(route.getStops());
            if (stops.size() < 2) continue;

            if (trip.reverse) {
                Collections.reverse(stops);
            }

            int N = stops.size() - 1;
            int totalSeats = bus.getTotalSeats();

            // Compute seat numbers for this bus
            List<String> seatNumbers = new ArrayList<>();
            try {
                com.fasterxml.jackson.databind.JsonNode rootNode = new com.fasterxml.jackson.databind.ObjectMapper().readTree(bus.getSeatLayout());
                com.fasterxml.jackson.databind.JsonNode categories = rootNode.path("categories");
                if (categories.isObject()) {
                    java.util.Iterator<String> fieldNames = categories.fieldNames();
                    while (fieldNames.hasNext()) {
                        String catName = fieldNames.next();
                        com.fasterxml.jackson.databind.JsonNode seatsNode = categories.path(catName);
                        if (seatsNode.isArray()) {
                            for (com.fasterxml.jackson.databind.JsonNode seat : seatsNode) {
                                seatNumbers.add(seat.asText());
                            }
                        }
                    }
                }
            } catch (Exception e) {}
            if (seatNumbers.size() < totalSeats) {
                seatNumbers.clear();
                for (int i = 1; i <= totalSeats; i++) {
                    seatNumbers.add(String.valueOf(i));
                }
            }

            // Occupancy percentage based on days until trip
            java.time.Duration duration = java.time.Duration.between(OffsetDateTime.now(ZoneOffset.UTC), trip.departureDatetime);
            long daysBetween = duration.toDays();
            long days = Math.max(0, Math.min(180, daysBetween));
            double targetPercentage = 80.0 - (days * (60.0 / 180.0));

            // Add random noise, cap max at 80%
            double noise = new java.util.Random(trip.id).nextDouble() * 10.0 - 5.0;
            targetPercentage = Math.max(10.0, Math.min(80.0, targetPercentage + noise));

            int maxAllowedSeats = (int) Math.floor(totalSeats * 0.80);
            int allowedSeatsCount = (int) Math.round(totalSeats * (targetPercentage / 100.0));
            allowedSeatsCount = Math.max(2, Math.min(maxAllowedSeats, allowedSeatsCount));

            int targetSeatSegments = (int) Math.round(allowedSeatsCount * N);
            int currentOccupiedSegments = 0;

            boolean[][] occupied = new boolean[totalSeats][N];
            java.util.Random random = new java.util.Random(trip.id);
            int consecutiveFailures = 0;

            // Generate a random subset of allowed seat indices for this trip (scattered all over the bus)
            Set<Integer> allowedSeatIndices = new HashSet<>();
            
            // Panoramic indices: 0, 1, 2, 3 (seats 1, 2, 3, 4)
            List<Integer> panoramicIndices = new ArrayList<>();
            for (int i = 0; i < 4; i++) {
                panoramicIndices.add(i);
            }
            Collections.shuffle(panoramicIndices, random);
            
            // Allow at most 2 panoramic seats to be occupied (always leaving at least 2 free)
            int allowedPanoramics = random.nextInt(3); // 0, 1, or 2
            for (int i = 0; i < allowedPanoramics; i++) {
                allowedSeatIndices.add(panoramicIndices.get(i));
            }
            
            // Normal indices: 4 to totalSeats - 1
            List<Integer> normalIndices = new ArrayList<>();
            for (int i = 4; i < totalSeats; i++) {
                normalIndices.add(i);
            }
            Collections.shuffle(normalIndices, random);
            
            // Fill the rest of the allowedSeatIndices up to allowedSeatsCount
            int neededNormal = allowedSeatsCount - allowedSeatIndices.size();
            for (int i = 0; i < neededNormal && i < normalIndices.size(); i++) {
                allowedSeatIndices.add(normalIndices.get(i));
            }

            while (currentOccupiedSegments < targetSeatSegments && consecutiveFailures < 20) {
                int fromIdx = random.nextInt(N);
                int toIdx = fromIdx + 1 + random.nextInt(N - fromIdx);
                int P = 2 + random.nextInt(3); // group booking: 2 to 4 passengers

                List<Integer> freeSeatIndices = new ArrayList<>();
                for (int s : allowedSeatIndices) {
                    boolean isFree = true;
                    for (int seg = fromIdx; seg < toIdx; seg++) {
                        if (occupied[s][seg]) {
                            isFree = false;
                            break;
                        }
                    }
                    if (isFree) {
                        freeSeatIndices.add(s);
                    }
                }

                if (freeSeatIndices.isEmpty()) {
                    consecutiveFailures++;
                    continue;
                }

                if (freeSeatIndices.size() < P) {
                    P = freeSeatIndices.size();
                }

                Collections.shuffle(freeSeatIndices, random);
                List<Integer> chosenSeatIndices = freeSeatIndices.subList(0, P);

                for (int s : chosenSeatIndices) {
                    for (int seg = fromIdx; seg < toIdx; seg++) {
                        occupied[s][seg] = true;
                    }
                }
                currentOccupiedSegments += P * (toIdx - fromIdx);
                consecutiveFailures = 0;

                User user = userPool.get(random.nextInt(userPool.size()));
                RouteStop originStop = stops.get(fromIdx);
                RouteStop targetStop = stops.get(toIdx);

                BigDecimal basePrice = targetStop.getBasePriceFromOrigin()
                        .subtract(originStop.getBasePriceFromOrigin())
                        .abs();

                BigDecimal segmentDistance = targetStop.getDistanceFromOrigin()
                        .subtract(originStop.getDistanceFromOrigin())
                        .abs();

                BigDecimal totalAmount = BigDecimal.ZERO;
                String bookingRef = generateBookingRef(random, generatedRefs);

                TempReservationDto reservation = new TempReservationDto(
                        user.getId(),
                        trip.id,
                        bookingRef,
                        originStop.getId(),
                        targetStop.getId()
                );

                for (int i = 0; i < P; i++) {
                    String seatNum = seatNumbers.get(chosenSeatIndices.get(i));
                    String firstName = (i == 0) ? user.getFirstName() : passengerFirstNames[random.nextInt(passengerFirstNames.length)];
                    String lastName = (i == 0) ? user.getLastName() : passengerLastNames[random.nextInt(passengerLastNames.length)];

                    TempPassengerDto passenger = new TempPassengerDto(firstName, lastName, seatNum);
                    reservation.passengers.add(passenger);

                    BigDecimal passengerPrice = basePrice.multiply(trip.priceKoefficient);
                    if (isPanoramicSeat(bus, seatNum)) {
                        BigDecimal surcharge = segmentDistance.multiply(new BigDecimal("0.004"))
                                .setScale(2, RoundingMode.HALF_UP);
                        passengerPrice = passengerPrice.add(surcharge);
                    }
                    totalAmount = totalAmount.add(passengerPrice);
                }

                reservation.totalAmount = totalAmount;
                reservationsToSave.add(reservation);
            }
        }

        // Allocate IDs for reservations and set them in passengers
        if (!reservationsToSave.isEmpty()) {
            List<Long> resIds = allocateIds("reservation", reservationsToSave.size());
            List<TempPassengerDto> allPassengersToSave = new ArrayList<>();

            for (int i = 0; i < reservationsToSave.size(); i++) {
                TempReservationDto res = reservationsToSave.get(i);
                res.id = resIds.get(i);
                for (TempPassengerDto pass : res.passengers) {
                    pass.reservationId = res.id;
                    allPassengersToSave.add(pass);
                }
            }

            // Insert reservations in batches
            String resSql = "INSERT INTO reservation (id, user_id, trip_id, booking_reference, total_amount, status, origin_route_stop_id, target_route_stop_id, created_at, updated_at) " +
                            "VALUES (?, ?, ?, ?, ?, 'CONFIRMED', ?, ?, NOW(), NOW())";

            int batchSize = 1000;
            for (int i = 0; i < reservationsToSave.size(); i += batchSize) {
                final List<TempReservationDto> batchList = reservationsToSave.subList(i, Math.min(i + batchSize, reservationsToSave.size()));
                jdbcTemplate.batchUpdate(resSql, new BatchPreparedStatementSetter() {
                    @Override
                    public void setValues(PreparedStatement ps, int idx) throws SQLException {
                        TempReservationDto res = batchList.get(idx);
                        ps.setLong(1, res.id);
                        ps.setLong(2, res.userId);
                        ps.setLong(3, res.tripId);
                        ps.setString(4, res.bookingReference);
                        ps.setBigDecimal(5, res.totalAmount);
                        ps.setLong(6, res.originRouteStopId);
                        ps.setLong(7, res.targetRouteStopId);
                    }

                    @Override
                    public int getBatchSize() {
                        return batchList.size();
                    }
                });
            }

            // Insert passengers in batches
            String passSql = "INSERT INTO reservation_passenger (reservation_id, first_name, last_name, is_checked_in, seat_number) " +
                             "VALUES (?, ?, ?, false, ?)";

            for (int i = 0; i < allPassengersToSave.size(); i += batchSize) {
                final List<TempPassengerDto> batchList = allPassengersToSave.subList(i, Math.min(i + batchSize, allPassengersToSave.size()));
                jdbcTemplate.batchUpdate(passSql, new BatchPreparedStatementSetter() {
                    @Override
                    public void setValues(PreparedStatement ps, int idx) throws SQLException {
                        TempPassengerDto pass = batchList.get(idx);
                        ps.setLong(1, pass.reservationId);
                        ps.setString(2, pass.firstName);
                        ps.setString(3, pass.lastName);
                        ps.setString(4, pass.seatNumber);
                    }

                    @Override
                    public int getBatchSize() {
                        return batchList.size();
                    }
                });
            }
        }
    }

    private boolean isInternationalRoute(String routeName) {
        String[] intRoutes = {
            "Aarhus - Copenhagen - Gothenburg - Stockholm - Oslo",
            "Bergen - Oslo - Stockholm",
            "Tampere - Helsinki - Tallinn - Tartu - Riga - Vilnius",
            "Liepaja - Daugavpils - Riga Airport - Vilnius Airport - Vilnius",
            "Amsterdam - Rotterdam - Antwerp - Brussels",
            "The Hague - Amsterdam Bijlmer - Brussels South - Bruges",
            "Prague - Dresden - Berlin ZOB - Berlin Ostbahnhof",
            "Prague - Brno - Vienna - Bratislava - Budapest",
            "Prague - Wrocław - Łódź - Warsaw - Bialystok",
            "Prague - Nuremberg - Frankfurt - Strasbourg - Paris",
            "Prague - Munich - Zurich Airport - Zurich - Basel - Geneva - Lyon - Marseille",
            "Prague - Munich - Milan - Nice - Barcelona - Valencia",
            "Prague - Kraków - Lviv - Kyiv Central - Kyiv Vydubychi",
            "Paris Bercy - Lille - Brussels North - London Victoria",
            "Madrid - Lisbon - Porto",
            "Sofia - Bucharest - Constanta"
        };
        for (String r : intRoutes) {
            if (r.equalsIgnoreCase(routeName)) {
                return true;
            }
        }
        return false;
    }

    private LocalTime[] getDepartureTimes(boolean isDomestic) {
        if (isDomestic) {
            return new LocalTime[] {
                LocalTime.of(6, 0),
                LocalTime.of(9, 0),
                LocalTime.of(12, 0),
                LocalTime.of(15, 0),
                LocalTime.of(18, 0),
                LocalTime.of(21, 0)
            };
        } else {
            return new LocalTime[] {
                LocalTime.of(8, 0),
                LocalTime.of(14, 0),
                LocalTime.of(20, 0)
            };
        }
    }

    private List<Long> allocateIds(String tableName, int count) {
        if (count <= 0) {
            return new ArrayList<>();
        }
        String sql = "SELECT nextval(pg_get_serial_sequence('" + tableName + "', 'id')) FROM generate_series(1, " + count + ")";
        return jdbcTemplate.queryForList(sql, Long.class);
    }

    private String generateBookingRef(java.util.Random random, Set<String> generatedRefs) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        while (true) {
            StringBuilder sb = new StringBuilder(8);
            for (int i = 0; i < 8; i++) {
                sb.append(chars.charAt(random.nextInt(chars.length())));
            }
            String ref = sb.toString();
            if (generatedRefs.add(ref)) {
                return ref;
            }
        }
    }

    private boolean isPanoramicSeat(Bus bus, String seatNumber) {
        try {
            com.fasterxml.jackson.databind.JsonNode root =
                    new com.fasterxml.jackson.databind.ObjectMapper().readTree(bus.getSeatLayout());
            com.fasterxml.jackson.databind.JsonNode categories = root.path("categories");
            if (categories.isObject()) {
                com.fasterxml.jackson.databind.JsonNode panoramic = categories.path("PANORAMIC");
                if (panoramic.isArray()) {
                    for (com.fasterxml.jackson.databind.JsonNode node : panoramic) {
                        if (node.asText().equals(seatNumber)) {
                            return true;
                        }
                    }
                }
            }
        } catch (Exception e) {
            // Fallback
        }
        return false;
    }

    private static class TempUserDto {
        final String firstName;
        final String lastName;
        final String email;
        final String phone;
        final String passwordHash;

        TempUserDto(String firstName, String lastName, String email, String phone, String passwordHash) {
            this.firstName = firstName;
            this.lastName = lastName;
            this.email = email;
            this.phone = phone;
            this.passwordHash = passwordHash;
        }
    }

    private static class TempReservationDto {
        Long id;
        final Long userId;
        final Long tripId;
        final String bookingReference;
        BigDecimal totalAmount;
        final Long originRouteStopId;
        final Long targetRouteStopId;
        final List<TempPassengerDto> passengers = new ArrayList<>();

        TempReservationDto(Long userId, Long tripId, String bookingReference,
                           Long originRouteStopId, Long targetRouteStopId) {
            this.userId = userId;
            this.tripId = tripId;
            this.bookingReference = bookingReference;
            this.originRouteStopId = originRouteStopId;
            this.targetRouteStopId = targetRouteStopId;
        }
    }

    private static class TempPassengerDto {
        Long reservationId;
        final String firstName;
        final String lastName;
        final String seatNumber;

        TempPassengerDto(String firstName, String lastName, String seatNumber) {
            this.firstName = firstName;
            this.lastName = lastName;
            this.seatNumber = seatNumber;
        }
    }

    private static class TempTripDto {
        Long id;
        final Long routeId;
        final Long busId;
        final Long driverId;
        final BigDecimal priceKoefficient;
        final boolean reverse;
        final OffsetDateTime departureDatetime;
        final OffsetDateTime arrivalDatetime;

        TempTripDto(Long routeId, Long busId, Long driverId, BigDecimal priceKoefficient, boolean reverse,
                    OffsetDateTime departureDatetime, OffsetDateTime arrivalDatetime) {
            this.routeId = routeId;
            this.busId = busId;
            this.driverId = driverId;
            this.priceKoefficient = priceKoefficient;
            this.reverse = reverse;
            this.departureDatetime = departureDatetime;
            this.arrivalDatetime = arrivalDatetime;
        }
    }
}
