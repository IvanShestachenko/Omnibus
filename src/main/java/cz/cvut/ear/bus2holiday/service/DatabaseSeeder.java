package cz.cvut.ear.bus2holiday.service;

import cz.cvut.ear.bus2holiday.dao.BusRepository;
import cz.cvut.ear.bus2holiday.dao.DriverRepository;
import cz.cvut.ear.bus2holiday.dao.RouteRepository;
import cz.cvut.ear.bus2holiday.dao.TripRepository;
import cz.cvut.ear.bus2holiday.model.Bus;
import cz.cvut.ear.bus2holiday.model.Driver;
import cz.cvut.ear.bus2holiday.model.Route;
import cz.cvut.ear.bus2holiday.model.Trip;
import org.springframework.boot.CommandLineRunner;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.List;

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
            String sql = "INSERT INTO trip (route_id, bus_id, driver_id, price_koefficient, reverse, departure_datetime, arrival_datetime, status, created_at, updated_at) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, 'SCHEDULED', NOW(), NOW())";
            
            int batchSize = 1000;
            for (int i = 0; i < tripsToSave.size(); i += batchSize) {
                final List<TempTripDto> batchList = tripsToSave.subList(i, Math.min(i + batchSize, tripsToSave.size()));
                
                jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
                    @Override
                    public void setValues(PreparedStatement ps, int idx) throws SQLException {
                        TempTripDto trip = batchList.get(idx);
                        ps.setLong(1, trip.routeId);
                        ps.setLong(2, trip.busId);
                        ps.setLong(3, trip.driverId);
                        ps.setBigDecimal(4, trip.priceKoefficient);
                        ps.setBoolean(5, trip.reverse);
                        ps.setTimestamp(6, Timestamp.from(trip.departureDatetime.toInstant()));
                        ps.setTimestamp(7, Timestamp.from(trip.arrivalDatetime.toInstant()));
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

    private static class TempTripDto {
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
