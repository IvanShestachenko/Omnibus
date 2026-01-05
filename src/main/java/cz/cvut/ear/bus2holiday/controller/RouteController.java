package cz.cvut.ear.bus2holiday.controller;

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

    public RouteController(RouteService routeService) {
        this.routeService = routeService;
    }

    @GetMapping
    public ResponseEntity<List<Route>> getAllRoutes() {
        return ResponseEntity.ok(routeService.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Route> getRoute(@PathVariable Long id) {
        return ResponseEntity.ok(routeService.findById(id));
    }

    @PostMapping
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<Route> createRoute(@RequestBody Route route) {
        Route created = routeService.create(route);
        return ResponseEntity.created(URI.create("/api/routes/" + created.getId())).body(created);
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<Route> updateRoute(@PathVariable Long id, @RequestBody Route route) {
        return ResponseEntity.ok(routeService.update(id, route));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<Void> deleteRoute(@PathVariable Long id) {
        routeService.delete(id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{id}/stops")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<RouteStop> addStop(@PathVariable Long id, @RequestBody RouteStop stop) {
        RouteStop createdCtx = routeService.addStop(id, stop);
        return ResponseEntity.created(
                        URI.create("/api/routes/" + id + "/stops/" + createdCtx.getId()))
                .body(createdCtx);
    }

    @DeleteMapping("/{id}/stops/{stopId}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<Void> removeStop(@PathVariable Long id, @PathVariable Long stopId) {
        routeService.removeStop(id, stopId);
        return ResponseEntity.noContent().build();
    }
}
