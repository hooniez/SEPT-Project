package com.ChatService.dao;

import com.ChatService.model.Patient;

import java.util.Optional;

public interface PatientRepository extends UserRepository<Patient> {
    // Optional<Patient> findByEmailAndPassword(String email, String password);

    // boolean existsByEmail(String Email);
}