package com.sept_group6.symptom.dao;

import com.sept_group6.symptom.model.Doctor;

import java.util.Optional;

public interface DoctorRepository extends UserRepository<Doctor> {
    // Optional<Doctor> findByEmailAndPassword(String email, String password);

    // boolean existsByEmail(String Email);
}