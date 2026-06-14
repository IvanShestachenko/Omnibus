package cz.cvut.ear.bus2holiday.dto.mapper;

import cz.cvut.ear.bus2holiday.dto.response.TripResponse;
import cz.cvut.ear.bus2holiday.model.Trip;
import cz.cvut.ear.bus2holiday.model.RouteStop;

import org.springframework.stereotype.Component;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Component
public class TripMapper {
    private final cz.cvut.ear.bus2holiday.dao.ReservationPassengerRepository reservationPassengerRepository;

    public TripMapper(cz.cvut.ear.bus2holiday.dao.ReservationPassengerRepository reservationPassengerRepository) {
        this.reservationPassengerRepository = reservationPassengerRepository;
    }

    public TripResponse toResponse(Trip trip) {
        return toResponse(trip, null, null, null, null);
    }

    public TripResponse toResponse(Trip trip, Long fromTerminalId, String fromCity, Long toTerminalId, String toCity) {
        String driverName =
                trip.getDriver() != null
                        ? trip.getDriver().getUser().getFirstName()
                                + " "
                                + trip.getDriver().getUser().getLastName()
                        : null;

        java.math.BigDecimal defaultPrice = java.math.BigDecimal.ZERO;
        String originTerminalName = "";
        String destinationTerminalName = "";
        List<String> availableSeats = new ArrayList<>();
        List<String> occupiedSeats = new ArrayList<>();
        Set<String> occupiedSet = new HashSet<>();
        java.time.OffsetDateTime departureDatetime = trip.getDepartureDatetime();
        java.time.OffsetDateTime arrivalDatetime = trip.getArrivalDatetime();

        var stops = trip.getRoute().getStops();
        RouteStop bestFStop = null;
        RouteStop bestTStop = null;

        if (stops != null && !stops.isEmpty()) {
            List<RouteStop> fromStops = new ArrayList<>();
            List<RouteStop> toStops = new ArrayList<>();

            for (RouteStop stop : stops) {
                cz.cvut.ear.bus2holiday.model.Terminal terminal = stop.getTerminal();
                if (terminal == null) continue;

                boolean matchesFrom = false;
                if (fromTerminalId != null && fromTerminalId > 0) {
                    matchesFrom = terminal.getId().equals(fromTerminalId);
                } else if (fromCity != null) {
                    matchesFrom = terminal.getCity().equalsIgnoreCase(fromCity);
                }
                if (matchesFrom) {
                    fromStops.add(stop);
                }

                boolean matchesTo = false;
                if (toTerminalId != null && toTerminalId > 0) {
                    matchesTo = terminal.getId().equals(toTerminalId);
                } else if (toCity != null) {
                    matchesTo = terminal.getCity().equalsIgnoreCase(toCity);
                }
                if (matchesTo) {
                    toStops.add(stop);
                }
            }

            for (RouteStop fStop : fromStops) {
                for (RouteStop tStop : toStops) {
                    if (fStop.getId().equals(tStop.getId())) continue;

                    boolean sequenceMatches = trip.isReverse() 
                            ? fStop.getSequenceOrder() > tStop.getSequenceOrder()
                            : fStop.getSequenceOrder() < tStop.getSequenceOrder();

                    if (sequenceMatches) {
                        if (bestFStop == null) {
                            bestFStop = fStop;
                            bestTStop = tStop;
                        } else {
                            if (trip.isReverse()) {
                                if (fStop.getSequenceOrder() > bestFStop.getSequenceOrder() ||
                                    (fStop.getSequenceOrder() == bestFStop.getSequenceOrder() && tStop.getSequenceOrder() < bestTStop.getSequenceOrder())) {
                                    bestFStop = fStop;
                                    bestTStop = tStop;
                                }
                            } else {
                                if (fStop.getSequenceOrder() < bestFStop.getSequenceOrder() ||
                                    (fStop.getSequenceOrder() == bestFStop.getSequenceOrder() && tStop.getSequenceOrder() > bestTStop.getSequenceOrder())) {
                                    bestFStop = fStop;
                                    bestTStop = tStop;
                                }
                            }
                        }
                    }
                }
            }
        }

        if (bestFStop == null || bestTStop == null) {
            if (stops != null && !stops.isEmpty()) {
                if (!trip.isReverse()) {
                    bestFStop = stops.get(0);
                    bestTStop = stops.get(stops.size() - 1);
                } else {
                    bestFStop = stops.get(stops.size() - 1);
                    bestTStop = stops.get(0);
                }
            }
        }

        if (bestFStop != null && bestTStop != null) {
            originTerminalName = bestFStop.getTerminal().getName();
            destinationTerminalName = bestTStop.getTerminal().getName();
            defaultPrice = bestTStop.getBasePriceFromOrigin()
                    .subtract(bestFStop.getBasePriceFromOrigin())
                    .abs()
                    .multiply(trip.getPriceKoefficient());

            if (!trip.isReverse()) {
                departureDatetime = trip.getDepartureDatetime().plusMinutes(bestFStop.getDepartureOffsetMinutes());
                arrivalDatetime = trip.getDepartureDatetime().plusMinutes(bestTStop.getArrivalOffsetMinutes());
            } else {
                int maxOffset = 0;
                for (RouteStop stop : stops) {
                    if (stop.getDepartureOffsetMinutes() > maxOffset) {
                        maxOffset = stop.getDepartureOffsetMinutes();
                    }
                }
                departureDatetime = trip.getDepartureDatetime().plusMinutes(maxOffset - bestFStop.getArrivalOffsetMinutes());
                arrivalDatetime = trip.getDepartureDatetime().plusMinutes(maxOffset - bestTStop.getDepartureOffsetMinutes());
            }

            int queryStart = bestFStop.getSequenceOrder();
            int queryEnd = bestTStop.getSequenceOrder();

            int minQuery = Math.min(queryStart, queryEnd);
            int maxQuery = Math.max(queryStart, queryEnd);

            List<String> occupied = reservationPassengerRepository.findOccupiedSeatsForTripAndSegment(
                    trip.getId(), minQuery, maxQuery);
            occupiedSet.addAll(occupied);
        }

        int busTotalSeats = trip.getBus().getTotalSeats();
        Set<String> allSeats = new HashSet<>();
        try {
            com.fasterxml.jackson.databind.JsonNode rootNode = new com.fasterxml.jackson.databind.ObjectMapper().readTree(trip.getBus().getSeatLayout());
            com.fasterxml.jackson.databind.JsonNode categories = rootNode.path("categories");
            if (categories.isObject()) {
                java.util.Iterator<String> fieldNames = categories.fieldNames();
                while (fieldNames.hasNext()) {
                    String catName = fieldNames.next();
                    com.fasterxml.jackson.databind.JsonNode seatsNode = categories.path(catName);
                    if (seatsNode.isArray()) {
                        for (com.fasterxml.jackson.databind.JsonNode seat : seatsNode) {
                            allSeats.add(seat.asText());
                        }
                    }
                }
            }
        } catch (Exception e) {}

        if (allSeats.size() < busTotalSeats) {
            boolean hasLetters = false;
            for (String s : allSeats) {
                if (s.matches(".*[A-Za-z].*")) {
                    hasLetters = true;
                    break;
                }
            }
            if (hasLetters) {
                int rows = 14;
                int seatsPerRow = 4;
                try {
                    com.fasterxml.jackson.databind.JsonNode rootNode = new com.fasterxml.jackson.databind.ObjectMapper().readTree(trip.getBus().getSeatLayout());
                    if (rootNode.has("rows")) rows = rootNode.get("rows").asInt();
                    if (rootNode.has("seatsPerRow")) seatsPerRow = rootNode.get("seatsPerRow").asInt();
                } catch (Exception e) {}

                char[] letters = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'};
                for (int r = 1; r <= rows; r++) {
                    for (int c = 0; c < seatsPerRow; c++) {
                        if (allSeats.size() >= busTotalSeats) break;
                        String seatNum = r + "" + letters[c];
                        allSeats.add(seatNum);
                    }
                }
            } else {
                for (int i = 1; i <= busTotalSeats; i++) {
                    allSeats.add(String.valueOf(i));
                }
            }
        }

        occupiedSeats.addAll(occupiedSet);
        availableSeats.addAll(allSeats);
        availableSeats.removeAll(occupiedSet);

        // Sort natural/alphabetic order
        availableSeats.sort((s1, s2) -> {
            try {
                return Integer.compare(Integer.parseInt(s1), Integer.parseInt(s2));
            } catch (Exception e) {
                return s1.compareTo(s2);
            }
        });
        occupiedSeats.sort((s1, s2) -> {
            try {
                return Integer.compare(Integer.parseInt(s1), Integer.parseInt(s2));
            } catch (Exception e) {
                return s1.compareTo(s2);
            }
        });

        String busName = trip.getBus().getManufacturer() + " " + trip.getBus().getModel();

        return new TripResponse(
                trip.getId(),
                trip.getRoute().getId(),
                trip.getRoute().getName(),
                trip.getBus().getRegistrationNumber(),
                busName,
                trip.getBus().getSeatLayout(),
                originTerminalName,
                destinationTerminalName,
                departureDatetime,
                arrivalDatetime,
                defaultPrice,
                trip.getStatus(),
                driverName,
                availableSeats,
                occupiedSeats);
    }
}
