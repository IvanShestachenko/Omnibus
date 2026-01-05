package cz.cvut.ear.bus2holiday.controller;

import cz.cvut.ear.bus2holiday.dto.mapper.DriverMapper;
import cz.cvut.ear.bus2holiday.dto.response.DriverResponse;
import cz.cvut.ear.bus2holiday.exception.ForbiddenException;
import cz.cvut.ear.bus2holiday.model.Driver;
import cz.cvut.ear.bus2holiday.model.Trip;
import cz.cvut.ear.bus2holiday.security.SecurityUtils;
import cz.cvut.ear.bus2holiday.service.DriverService;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/drivers")
public class DriverController {

    private final DriverService driverService;
    private final SecurityUtils securityUtils;
    private final DriverMapper driverMapper;

    public DriverController(
            DriverService driverService, SecurityUtils securityUtils, DriverMapper driverMapper) {
        this.driverService = driverService;
        this.securityUtils = securityUtils;
        this.driverMapper = driverMapper;
    }

    @GetMapping
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<List<DriverResponse>> getAllDrivers() {
        return ResponseEntity.ok(
                driverService.findAll().stream().map(driverMapper::toResponse).toList());
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_DRIVER')")
    public ResponseEntity<DriverResponse> getDriver(@PathVariable Long id) {
        // Driver can see only themselves? Or any driver?
        // Let's assume Drivers can see other drivers basic info is okay, or restrict.
        // Spec says GET /api/drivers/{id} without restriction note, but broadly usually secured.
        // Let's restrict to ADMIN or SELF.
        Long currentUserId = securityUtils.getCurrentUserId();
        if (!securityUtils.hasRole("ROLE_ADMIN") && !id.equals(currentUserId)) {
            throw new ForbiddenException("Access denied");
        }
        return ResponseEntity.ok(driverMapper.toResponse(driverService.findById(id)));
    }

    @GetMapping("/me/trips")
    @PreAuthorize("hasRole('ROLE_DRIVER')")
    public ResponseEntity<List<Trip>> getMyTrips() {
        Long currentUserId = securityUtils.getCurrentUserId();
        return ResponseEntity.ok(driverService.getTrips(currentUserId));
    }

    @GetMapping("/{id}/trips")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<List<Trip>> getDriverTrips(@PathVariable Long id) {
        return ResponseEntity.ok(driverService.getTrips(id));
    }

    @PostMapping
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<DriverResponse> createDriver(@RequestBody Driver driver) {
        Driver created = driverService.create(driver);
        return ResponseEntity.created(URI.create("/api/drivers/" + created.getUserId()))
                .body(driverMapper.toResponse(created));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<DriverResponse> updateDriver(
            @PathVariable Long id, @RequestBody Driver driver) {
        return ResponseEntity.ok(driverMapper.toResponse(driverService.update(id, driver)));
    }

    @PatchMapping("/{id}/availability")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_DRIVER')")
    public ResponseEntity<Void> updateAvailability(
            @PathVariable Long id, @RequestBody boolean isAvailable) {
        Long currentUserId = securityUtils.getCurrentUserId();
        if (!securityUtils.hasRole("ROLE_ADMIN") && !id.equals(currentUserId)) {
            throw new ForbiddenException("Access denied");
        }
        driverService.updateAvailability(id, isAvailable);
        return ResponseEntity.noContent().build();
    }
}
