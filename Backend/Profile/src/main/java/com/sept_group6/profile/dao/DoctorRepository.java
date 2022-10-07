package com.sept_group6.profile.dao;

import com.sept_group6.profile.model.Doctor;
import com.sept_group6.profile.model.Patient;

import java.util.Optional;

public interface DoctorRepository extends UserRepository<Doctor> {
    // Optional<Doctor> findByEmailAndPassword(String email, String password);

    // boolean existsByEmail(String Email);
}