package cz.cvut.ear.bus2holiday.service;

import cz.cvut.ear.bus2holiday.dao.UserRepository;
import cz.cvut.ear.bus2holiday.exception.ForbiddenException;
import cz.cvut.ear.bus2holiday.model.User;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepo;

    @Transactional(readOnly = true)
    public List<User> findAll() {
        return userRepo.findAll();
    }

    @Transactional(readOnly = true)
    public User findById(Long id) {
        return userRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + id));
    }

    @Transactional
    public User update(
            Long id,
            String firstName,
            String lastName,
            String phone,
            Long currentUserId,
            boolean isAdmin) {
        User user = findById(id);

        if (!user.getId().equals(currentUserId) && !isAdmin) {
            throw new ForbiddenException("You can only update your own profile");
        }

        if (firstName != null) user.setFirstName(firstName);
        if (lastName != null) user.setLastName(lastName);
        if (phone != null) user.setPhone(phone);

        return userRepo.save(user);
    }

    @Transactional
    public void delete(Long id) {
        User user = findById(id);
        userRepo.delete(user);
    }
}
