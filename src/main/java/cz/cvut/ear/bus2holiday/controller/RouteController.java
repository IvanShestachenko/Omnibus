package cz.cvut.ear.bus2holiday.controller;

import cz.cvut.ear.bus2holiday.dto.mapper.RouteMapper;
import cz.cvut.ear.bus2holiday.dto.response.RouteResponse;
import cz.cvut.ear.bus2holiday.model.Route;
import cz.cvut.ear.bus2holiday.model.RouteStop;
import cz.cvut.ear.bus2holiday.service.RouteService;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/routes")
public class RouteController {

    private final RouteService routeService;
    private final RouteMapper routeMapper;

    public RouteController(RouteService routeService, RouteMapper routeMapper) {
        this.routeService = routeService;
        this.routeMapper = routeMapper;
    }

    @GetMapping
    public ResponseEntity<List<RouteResponse>> getAllRoutes() {
        return ResponseEntity.ok(
                routeService.findAll().stream().map(routeMapper::toResponse).toList());
    }

    @GetMapping("/{id}")
    public ResponseEntity<RouteResponse> getRoute(@PathVariable Long id) {
        return ResponseEntity.ok(routeMapper.toResponse(routeService.findById(id)));
    }

    @PostMapping
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<RouteResponse> createRoute(@RequestBody Route route) {
        Route created = routeService.create(route);
        return ResponseEntity.created(URI.create("/api/routes/" + created.getId()))
                .body(routeMapper.toResponse(created));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<RouteResponse> updateRoute(
            @PathVariable Long id, @RequestBody Route route) {
        return ResponseEntity.ok(routeMapper.toResponse(routeService.update(id, route)));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<Void> deleteRoute(@PathVariable Long id) {
        routeService.delete(id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{id}/stops")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<RouteResponse> addStop(
            @PathVariable Long id, @RequestBody RouteStop stop) {
        routeService.addStop(id, stop);
        Route updatedRoute = routeService.findById(id);
        return ResponseEntity.created(URI.create("/api/routes/" + id))
                .body(routeMapper.toResponse(updatedRoute));
    }

    @DeleteMapping("/{id}/stops/{stopId}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<Void> removeStop(@PathVariable Long id, @PathVariable Long stopId) {
        routeService.removeStop(id, stopId);
        return ResponseEntity.noContent().build();
    }
}
