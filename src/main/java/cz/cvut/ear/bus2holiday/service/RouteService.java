package cz.cvut.ear.bus2holiday.service;

import cz.cvut.ear.bus2holiday.dao.RouteRepository;
import cz.cvut.ear.bus2holiday.dao.RouteStopRepository;
import cz.cvut.ear.bus2holiday.model.Route;
import cz.cvut.ear.bus2holiday.model.RouteStop;

import jakarta.persistence.EntityNotFoundException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

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
}
