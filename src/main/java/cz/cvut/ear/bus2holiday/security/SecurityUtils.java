package cz.cvut.ear.bus2holiday.security;

import cz.cvut.ear.bus2holiday.exception.UnauthorizedException;
import cz.cvut.ear.bus2holiday.security.model.UserDetails;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

@Component
public class SecurityUtils {

    public Long getCurrentUserId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated()) {
            throw new UnauthorizedException("Not authenticated");
        }

        UserDetails userDetails = (UserDetails) auth.getPrincipal();
        return userDetails.getUser().getId();
    }

    public boolean hasRole(String role) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return auth.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals(role));
    }
}
