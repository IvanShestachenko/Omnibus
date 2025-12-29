package cz.cvut.ear.bus2holiday.utils;

import cz.cvut.ear.bus2holiday.model.enums.UserRole;

public final class Constants {

    /** Default user role. */
    public static final UserRole DEFAULT_ROLE = UserRole.user;

    /** Username login form parameter. */
    public static final String USERNAME_PARAM = "username";

    private Constants() {
        throw new AssertionError();
    }
}
