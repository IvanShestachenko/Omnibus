package cz.cvut.ear.bus2holiday.controller;

import cz.cvut.ear.bus2holiday.dto.mapper.BusMapper;
import cz.cvut.ear.bus2holiday.dto.response.BusResponse;
import cz.cvut.ear.bus2holiday.model.Bus;
import cz.cvut.ear.bus2holiday.model.enums.BusStatus;
import cz.cvut.ear.bus2holiday.service.BusService;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/buses")
public class BusController {

    private final BusService busService;
    private final BusMapper busMapper;

    public BusController(BusService busService, BusMapper busMapper) {
        this.busService = busService;
        this.busMapper = busMapper;
    }

    @GetMapping
    public ResponseEntity<List<BusResponse>> getAllBuses() {
        return ResponseEntity.ok(busService.findAll().stream().map(busMapper::toResponse).toList());
    }

    @GetMapping("/{id}")
    public ResponseEntity<BusResponse> getBus(@PathVariable Long id) {
        return ResponseEntity.ok(busMapper.toResponse(busService.findById(id)));
    }

    @PostMapping
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<BusResponse> createBus(@RequestBody Bus bus) {
        Bus created = busService.create(bus);
        return ResponseEntity.created(URI.create("/api/buses/" + created.getId()))
                .body(busMapper.toResponse(created));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<BusResponse> updateBus(@PathVariable Long id, @RequestBody Bus bus) {
        return ResponseEntity.ok(busMapper.toResponse(busService.update(id, bus)));
    }

    @PatchMapping("/{id}/status")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<Void> updateBusStatus(
            @PathVariable Long id, @RequestBody BusStatus status) {
        busService.updateStatus(id, status);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<Void> deleteBus(@PathVariable Long id) {
        busService.delete(id);
        return ResponseEntity.noContent().build();
    }
}
