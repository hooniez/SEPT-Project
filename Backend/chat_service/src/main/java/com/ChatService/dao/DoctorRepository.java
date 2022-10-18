package com.ChatService.dao;

import com.sept_group6.appointment_server.model.Doctor;

import java.util.Optional;

public interface DoctorRepository extends UserRepository<Doctor> {
    // Optional<Doctor> findByEmailAndPassword(String email, String password);

    // boolean existsByEmail(String Email);
}