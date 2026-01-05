package cz.cvut.ear.bus2holiday.service;

import cz.cvut.ear.bus2holiday.dao.BusRepository;
import cz.cvut.ear.bus2holiday.model.Bus;
import cz.cvut.ear.bus2holiday.model.enums.BusStatus;

import jakarta.persistence.EntityNotFoundException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BusService {

    private final BusRepository busRepository;

    public BusService(BusRepository busRepository) {
        this.busRepository = busRepository;
    }

    @Transactional(readOnly = true)
    public List<Bus> findAll() {
        return busRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Bus findById(Long id) {
        return busRepository
                .findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Bus not found with id: " + id));
    }

    @Transactional
    public Bus create(Bus bus) {
        bus.setId(null);
        return busRepository.save(bus);
    }

    @Transactional
    public Bus update(Long id, Bus updatedBusData) {
        Bus existingBus = findById(id);

        existingBus.setModel(updatedBusData.getModel());
        existingBus.setRegistrationNumber(updatedBusData.getRegistrationNumber());
        existingBus.setManufacturer(updatedBusData.getManufacturer());
        existingBus.setYear(updatedBusData.getYear());
        existingBus.setTotalSeats(updatedBusData.getTotalSeats());
        existingBus.setSeatLayout(updatedBusData.getSeatLayout());
        existingBus.setStatus(updatedBusData.getStatus());

        return busRepository.save(existingBus);
    }

    @Transactional
    public void updateStatus(Long id, BusStatus status) {
        Bus bus = findById(id);
        bus.setStatus(status);
        busRepository.save(bus);
    }

    @Transactional
    public void delete(Long id) {
        if (!busRepository.existsById(id)) {
            throw new EntityNotFoundException("Bus not found with id: " + id);
        }
        busRepository.deleteById(id);
    }
}
