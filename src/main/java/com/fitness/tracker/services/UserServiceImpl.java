package com.fitness.tracker.services;

import com.fitness.tracker.entities.User;
import com.fitness.tracker.repositories.UserRepository;
import java.time.LocalDateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public User register(String username, String email, String password) {
        String cleanUsername = username == null ? "" : username.trim();
        String cleanEmail = email == null ? "" : email.trim().toLowerCase();

        if (cleanUsername.isEmpty()) {
            throw new IllegalArgumentException("Username is required.");
        }
        if (cleanEmail.isEmpty()) {
            throw new IllegalArgumentException("Email is required.");
        }
        if (password == null || password.isEmpty()) {
            throw new IllegalArgumentException("Password is required.");
        }
        if (userRepository.existsByUsername(cleanUsername)) {
            throw new IllegalArgumentException("Username already exists.");
        }
        if (userRepository.existsByEmail(cleanEmail)) {
            throw new IllegalArgumentException("Email already exists.");
        }

        User user = new User();
        user.setUsername(cleanUsername);
        user.setEmail(cleanEmail);
        user.setPassword(password);
        user.setCreatedAt(LocalDateTime.now());
        return userRepository.save(user);
    }

    @Override
    public User login(String username, String password) {
        if (username == null || password == null) {
            return null;
        }
        return userRepository.findByUsername(username.trim())
                .filter(user -> password.equals(user.getPassword()))
                .orElse(null);
    }

    @Override
    public User findById(Long id) {
        if (id == null) {
            return null;
        }
        return userRepository.findById(id).orElse(null);
    }

    @Override
    public User findByUsername(String username) {
        if (username == null) {
            return null;
        }
        return userRepository.findByUsername(username.trim()).orElse(null);
    }
}
