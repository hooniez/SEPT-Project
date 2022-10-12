package com.sept_group6.sept_backend.dao;

import com.sept_group6.sept_backend.model.Patient;

import java.util.Optional;

public interface PatientRepository extends UserRepository<Patient> {
    // Optional<Patient> findByEmailAndPassword(String email, String password);

    // boolean existsByEmail(String Email);
}