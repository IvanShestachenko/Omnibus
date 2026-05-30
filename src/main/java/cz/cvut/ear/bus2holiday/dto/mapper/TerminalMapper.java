package cz.cvut.ear.bus2holiday.dto.mapper;

import cz.cvut.ear.bus2holiday.dto.response.TerminalResponse;
import cz.cvut.ear.bus2holiday.model.Terminal;
import org.springframework.stereotype.Component;

@Component
public class TerminalMapper {
    public TerminalResponse toResponse(Terminal terminal) {
        return new TerminalResponse(
            terminal.getId(),
            terminal.getName(),
            terminal.getCity(),
            terminal.getCountry()
        );
    }
}
