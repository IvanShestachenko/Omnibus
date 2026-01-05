package cz.cvut.ear.bus2holiday.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import cz.cvut.ear.bus2holiday.dao.UserRepository;
import cz.cvut.ear.bus2holiday.exception.ForbiddenException;
import cz.cvut.ear.bus2holiday.model.User;
import cz.cvut.ear.bus2holiday.model.enums.UserRole;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock private UserRepository userRepo;

    @InjectMocks private UserService userService;

    private User testUser;

    @BeforeEach
    void setUp() {
        testUser = new User();
        testUser.setId(1L);
        testUser.setEmail("user@test.com");
        testUser.setFirstName("John");
        testUser.setLastName("Doe");
        testUser.setRole(UserRole.user);
    }

    @Test
    void findById_WhenExists_ShouldReturnUser() {
        when(userRepo.findById(1L)).thenReturn(Optional.of(testUser));

        User result = userService.findById(1L);

        assertEquals("user@test.com", result.getEmail());
        verify(userRepo).findById(1L);
    }

    @Test
    void findById_WhenNotExists_ShouldThrow() {
        when(userRepo.findById(99L)).thenReturn(Optional.empty());

        assertThrows(RuntimeException.class, () -> userService.findById(99L));
    }

    @Test
    void update_BySelf_ShouldSucceed() {
        when(userRepo.findById(1L)).thenReturn(Optional.of(testUser));
        when(userRepo.save(any(User.class))).thenReturn(testUser);

        User result = userService.update(1L, "NewName", null, null, 1L, false);

        assertEquals("NewName", result.getFirstName());
        assertEquals("Doe", result.getLastName());
    }

    @Test
    void update_ByOtherNonAdmin_ShouldThrowForbidden() {
        when(userRepo.findById(1L)).thenReturn(Optional.of(testUser));

        assertThrows(
                ForbiddenException.class,
                () -> userService.update(1L, "Hacker", null, null, 999L, false));
    }

    @Test
    void update_ByAdmin_ShouldSucceed() {
        when(userRepo.findById(1L)).thenReturn(Optional.of(testUser));
        when(userRepo.save(any(User.class))).thenReturn(testUser);

        User result = userService.update(1L, "AdminEdit", null, null, 999L, true);

        assertEquals("AdminEdit", result.getFirstName());
    }

    @Test
    void delete_ShouldCallRepository() {
        when(userRepo.findById(1L)).thenReturn(Optional.of(testUser));

        userService.delete(1L);

        verify(userRepo).delete(testUser);
    }
}
