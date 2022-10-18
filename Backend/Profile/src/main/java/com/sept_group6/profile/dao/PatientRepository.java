package com.sept_group6.profile.dao;

import com.sept_group6.profile.model.Patient;

import java.util.Optional;

public interface PatientRepository extends UserRepository<Patient> {
    // Optional<Patient> findByEmailAndPassword(String email, String password);

    // boolean existsByEmail(String Email);
}