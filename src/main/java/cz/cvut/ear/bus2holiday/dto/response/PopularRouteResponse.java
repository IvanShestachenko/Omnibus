package cz.cvut.ear.bus2holiday.dto.response;

import java.math.BigDecimal;

public record PopularRouteResponse(
        String from,
        String to,
        BigDecimal price,
        String fromCountry,
        String toCountry
) {}
