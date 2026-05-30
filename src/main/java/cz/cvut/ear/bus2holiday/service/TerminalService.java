package cz.cvut.ear.bus2holiday.service;

import cz.cvut.ear.bus2holiday.dao.TerminalRepository;
import cz.cvut.ear.bus2holiday.model.Terminal;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class TerminalService {
    private final TerminalRepository terminalRepository;

    public TerminalService(TerminalRepository terminalRepository) {
        this.terminalRepository = terminalRepository;
    }

    @Transactional(readOnly = true)
    public List<Terminal> findAll() {
        return terminalRepository.findAll();
    }
}
