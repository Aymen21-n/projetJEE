package com.fitness.tracker.services;

import com.fitness.tracker.entities.User;

public interface UserService {

    User register(String username, String email, String password);

    User login(String username, String password);

    User findById(Long id);

    User findByUsername(String username);
}
