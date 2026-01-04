package cz.cvut.ear.bus2holiday.dto.mapper;

import cz.cvut.ear.bus2holiday.dto.response.DriverResponse;
import cz.cvut.ear.bus2holiday.model.Driver;

import org.springframework.stereotype.Component;

@Component
public class DriverMapper {
    public DriverResponse toResponse(Driver driver) {
        return new DriverResponse(
                driver.getUserId(),
                driver.getUser().getFirstName(),
                driver.getUser().getLastName(),
                driver.getUser().getEmail(),
                driver.getLicenseNumber(),
                driver.isAvailable());
    }
}
