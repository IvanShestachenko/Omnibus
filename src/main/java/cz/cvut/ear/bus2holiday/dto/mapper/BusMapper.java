package cz.cvut.ear.bus2holiday.dto.mapper;

import cz.cvut.ear.bus2holiday.dto.response.BusResponse;
import cz.cvut.ear.bus2holiday.model.Bus;

import org.springframework.stereotype.Component;

@Component
public class BusMapper {
    public BusResponse toResponse(Bus bus) {
        return new BusResponse(
                bus.getId(),
                bus.getRegistrationNumber(),
                bus.getModel(),
                bus.getManufacturer(),
                bus.getYear(),
                bus.getTotalSeats(),
                bus.getStatus());
    }
}
