package com.sept_group6.profile.dao;

import com.sept_group6.profile.model.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.NoRepositoryBean;

import java.util.Optional;

@NoRepositoryBean
public interface UserRepository<T extends User> extends CrudRepository<T, Long> {
    Optional<T> findByEmailAndPassword(String email, String password);

    T findByEmail(String email);

    T getById(Long id);

    boolean existsByEmail(String Email);
}