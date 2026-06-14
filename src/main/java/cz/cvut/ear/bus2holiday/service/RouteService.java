package cz.cvut.ear.bus2holiday.service;

import cz.cvut.ear.bus2holiday.dao.RouteRepository;
import cz.cvut.ear.bus2holiday.dao.RouteStopRepository;
import cz.cvut.ear.bus2holiday.dto.response.PopularRouteResponse;
import cz.cvut.ear.bus2holiday.model.Route;
import cz.cvut.ear.bus2holiday.model.RouteStop;

import jakarta.persistence.EntityNotFoundException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class RouteService {

    private final RouteRepository routeRepository;
    private final RouteStopRepository routeStopRepository;

    public RouteService(RouteRepository routeRepository, RouteStopRepository routeStopRepository) {
        this.routeRepository = routeRepository;
        this.routeStopRepository = routeStopRepository;
    }

    @Transactional(readOnly = true)
    public List<Route> findAll() {
        return routeRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Route findById(Long id) {
        return routeRepository
                .findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Route not found with id: " + id));
    }

    @Transactional
    public Route create(Route route) {
        route.setId(null);
        return routeRepository.save(route);
    }

    @Transactional
    public Route update(Long id, Route routeData) {
        Route existingRoute = findById(id);
        existingRoute.setName(routeData.getName());
        existingRoute.setActive(routeData.isActive());
        return routeRepository.save(existingRoute);
    }

    @Transactional
    public void delete(Long id) {
        if (!routeRepository.existsById(id)) {
            throw new EntityNotFoundException("Route not found with id: " + id);
        }
        routeRepository.deleteById(id);
    }

    @Transactional
    public RouteStop addStop(Long routeId, RouteStop stop) {
        Route route = findById(routeId);
        stop.setRoute(route);
        return routeStopRepository.save(stop);
    }

    @Transactional
    public void removeStop(Long routeId, Long stopId) {
        RouteStop stop =
                routeStopRepository
                        .findById(stopId)
                        .orElseThrow(
                                () ->
                                        new EntityNotFoundException(
                                                "RouteStop not found with id: " + stopId));

        if (!stop.getRoute().getId().equals(routeId)) {
            throw new IllegalArgumentException("Stop does not belong to the specified route");
        }

        routeStopRepository.delete(stop);
    }

    @Transactional(readOnly = true)
    public List<PopularRouteResponse> getPopularRoutes(String userCountry) {
        List<Route> routes = routeRepository.findAll().stream().filter(Route::isActive).toList();
        
        List<PopularRouteResponse> allTrips = new ArrayList<>();
        Set<String> seenPairs = new HashSet<>();
        
        for (Route route : routes) {
            List<RouteStop> sortedStops = new ArrayList<>(route.getStops());
            sortedStops.sort(Comparator.comparingInt(RouteStop::getSequenceOrder));
            
            for (int i = 0; i < sortedStops.size(); i++) {
                for (int j = i + 1; j < sortedStops.size(); j++) {
                    RouteStop stopA = sortedStops.get(i);
                    RouteStop stopB = sortedStops.get(j);
                    
                    if (stopA.getTerminal() == null || stopB.getTerminal() == null) continue;
                    
                    String cityA = stopA.getTerminal().getCity();
                    String cityB = stopB.getTerminal().getCity();
                    
                    if (cityA == null || cityB == null) continue;
                    if (cityA.equalsIgnoreCase(cityB)) continue;
                    
                    BigDecimal price = stopB.getBasePriceFromOrigin()
                            .subtract(stopA.getBasePriceFromOrigin())
                            .abs()
                            .setScale(2, RoundingMode.HALF_UP);
                    
                    if (price.compareTo(BigDecimal.ZERO) <= 0) continue;
                    
                    String countryA = stopA.getTerminal().getCountry();
                    String countryB = stopB.getTerminal().getCountry();
                    
                    if (countryA == null || countryB == null) continue;
                    
                    // 1. Forward connection (stopA -> stopB)
                    String keyForward = cityA.toLowerCase() + "->" + cityB.toLowerCase();
                    if (!seenPairs.contains(keyForward)) {
                        seenPairs.add(keyForward);
                        allTrips.add(new PopularRouteResponse(
                                cityA, cityB, price, countryA, countryB
                        ));
                    }
                    
                    // 2. Backward connection (stopB -> stopA)
                    String keyBackward = cityB.toLowerCase() + "->" + cityA.toLowerCase();
                    if (!seenPairs.contains(keyBackward)) {
                        seenPairs.add(keyBackward);
                        allTrips.add(new PopularRouteResponse(
                                cityB, cityA, price, countryB, countryA
                        ));
                    }
                }
            }
        }
        
        List<PopularRouteResponse> selected = new ArrayList<>();
        
        if (userCountry != null && !userCountry.trim().isEmpty()) {
            final String country = userCountry.trim().toLowerCase();
            List<PopularRouteResponse> domestic = allTrips.stream()
                    .filter(t -> t.fromCountry().toLowerCase().equals(country) && t.toCountry().toLowerCase().equals(country))
                    .toList();
            
            List<PopularRouteResponse> international = allTrips.stream()
                    .filter(t -> t.fromCountry().toLowerCase().equals(country) && !t.toCountry().toLowerCase().equals(country))
                    .toList();
            
            // Take 2 domestic and 2 international
            selected.addAll(domestic.stream().limit(2).toList());
            selected.addAll(international.stream().limit(2).toList());
            
            // Fallback: fill up to 4 with other trips starting from this country
            if (selected.size() < 4) {
                List<PopularRouteResponse> remainingFromCountry = new ArrayList<>();
                domestic.stream().filter(t -> !selected.contains(t)).forEach(remainingFromCountry::add);
                international.stream().filter(t -> !selected.contains(t)).forEach(remainingFromCountry::add);
                
                int limit = 4 - selected.size();
                selected.addAll(remainingFromCountry.stream().limit(limit).toList());
            }
        }
        
        // Fallback or unlogged-in: load defaults
        if (selected.size() < 4) {
            List<PopularRouteResponse> defaults = getUnloggedInTrips(allTrips);
            for (PopularRouteResponse def : defaults) {
                if (selected.size() >= 4) break;
                if (selected.stream().noneMatch(s -> s.from().equalsIgnoreCase(def.from()) && s.to().equalsIgnoreCase(def.to()))) {
                    selected.add(def);
                }
            }
        }
        
        // Double check we have 4, otherwise use backup constants
        if (selected.size() < 4) {
            List<PopularRouteResponse> backups = List.of(
                    new PopularRouteResponse("Prague", "Brno", new BigDecimal("8.36"), "Czech Republic", "Czech Republic"),
                    new PopularRouteResponse("Berlin", "Munich", new BigDecimal("23.41"), "Germany", "Germany"),
                    new PopularRouteResponse("Paris", "Marseille", new BigDecimal("29.93"), "France", "France"),
                    new PopularRouteResponse("Warsaw", "Kraków", new BigDecimal("11.30"), "Poland", "Poland")
            );
            for (PopularRouteResponse backup : backups) {
                if (selected.size() >= 4) break;
                if (selected.stream().noneMatch(s -> s.from().equalsIgnoreCase(backup.from()) && s.to().equalsIgnoreCase(backup.to()))) {
                    selected.add(backup);
                }
            }
        }
        
        return selected.stream().limit(4).toList();
    }
    
    private List<PopularRouteResponse> getUnloggedInTrips(List<PopularRouteResponse> trips) {
        record TargetPair(String from, String to) {}
        List<TargetPair> targetPairs = List.of(
                new TargetPair("Prague", "Brno"),
                new TargetPair("Berlin", "Munich"),
                new TargetPair("Paris", "Marseille"),
                new TargetPair("Warsaw", "Kraków")
        );
        
        List<PopularRouteResponse> selected = new ArrayList<>();
        
        // Find exact matches first
        for (TargetPair pair : targetPairs) {
            trips.stream()
                    .filter(t -> t.from().equalsIgnoreCase(pair.from()) && t.to().equalsIgnoreCase(pair.to()))
                    .findFirst()
                    .ifPresent(selected::add);
        }
        
        // Fallback to finding any trip starting in each country: Czech Republic, Germany, France, Poland
        if (selected.size() < 4) {
            List<String> countries = List.of("Czech Republic", "Germany", "France", "Poland");
            for (String country : countries) {
                if (selected.size() >= 4) break;
                boolean alreadyHasCountry = selected.stream().anyMatch(s -> s.fromCountry().equalsIgnoreCase(country));
                if (alreadyHasCountry) continue;
                
                trips.stream()
                        .filter(t -> t.fromCountry().equalsIgnoreCase(country) && 
                                selected.stream().noneMatch(s -> s.from().equalsIgnoreCase(t.from()) && s.to().equalsIgnoreCase(t.to())))
                        .findFirst()
                        .ifPresent(selected::add);
            }
        }
        
        // Fill up with any available trips
        for (PopularRouteResponse trip : trips) {
            if (selected.size() >= 4) break;
            if (selected.stream().noneMatch(s -> s.from().equalsIgnoreCase(trip.from()) && s.to().equalsIgnoreCase(trip.to()))) {
                selected.add(trip);
            }
        }
        
        return selected;
    }
}
