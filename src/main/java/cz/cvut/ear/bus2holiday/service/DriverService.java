package cz.cvut.ear.bus2holiday.service;

import cz.cvut.ear.bus2holiday.dao.DriverRepository;
import cz.cvut.ear.bus2holiday.dao.TripRepository;
import cz.cvut.ear.bus2holiday.dao.UserRepository;
import cz.cvut.ear.bus2holiday.model.Driver;
import cz.cvut.ear.bus2holiday.model.Trip;
import cz.cvut.ear.bus2holiday.model.User;

import jakarta.persistence.EntityNotFoundException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DriverService {

    private final DriverRepository driverRepository;
    private final UserRepository userRepository;
    private final TripRepository tripRepository;

    public DriverService(
            DriverRepository driverRepository,
            UserRepository userRepository,
            TripRepository tripRepository) {
        this.driverRepository = driverRepository;
        this.userRepository = userRepository;
        this.tripRepository = tripRepository;
    }

    @Transactional(readOnly = true)
    public List<Driver> findAll() {
        return driverRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Driver findById(Long id) {
        return driverRepository
                .findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Driver not found with id: " + id));
    }

    @Transactional
    public Driver create(Driver driver) {
        if (driver.getUser() != null && driver.getUser().getId() != null) {
            User user =
                    userRepository
                            .findById(driver.getUser().getId())
                            .orElseThrow(() -> new EntityNotFoundException("User not found"));
            driver.setUser(user);
            driver.setUserId(user.getId());
        }
        return driverRepository.save(driver);
    }

    @Transactional
    public Driver update(Long id, Driver driverData) {
        Driver existing = findById(id);
        existing.setLicenseNumber(driverData.getLicenseNumber());
        existing.setLicenseExpiry(driverData.getLicenseExpiry());
        existing.setAvailable(driverData.isAvailable());
        return driverRepository.save(existing);
    }

    @Transactional
    public void updateAvailability(Long id, boolean isAvailable) {
        Driver driver = findById(id);
        driver.setAvailable(isAvailable);
        driverRepository.save(driver);
    }

    @Transactional(readOnly = true)
    public List<Trip> getTrips(Long driverId) {
        return tripRepository.findByDriverUserId(driverId);
    }
}
