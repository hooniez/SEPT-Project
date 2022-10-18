package com.example.admin.dao;

import org.springframework.data.repository.CrudRepository;
import com.example.admin.model.Admin;

import java.util.Optional;

public interface AdminRepository extends CrudRepository<Admin, Long> {
    Optional<Admin> findByEmailAndPassword(String email, String password);

    boolean existsByEmail(String Email);
}