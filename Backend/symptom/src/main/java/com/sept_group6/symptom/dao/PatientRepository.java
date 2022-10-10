package com.sept_group6.symptom.dao;

import com.sept_group6.symptom.model.Patient;

import java.util.Optional;

public interface PatientRepository extends UserRepository<Patient> {
    // Optional<Patient> findByEmailAndPassword(String email, String password);

    // boolean existsByEmail(String Email);
}