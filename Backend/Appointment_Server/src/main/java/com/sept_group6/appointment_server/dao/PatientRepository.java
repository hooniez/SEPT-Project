package com.sept_group6.appointment_server.dao;

import org.springframework.data.repository.CrudRepository;

import com.sept_group6.appointment_server.model.Patient;

import java.util.Optional;

public interface PatientRepository extends CrudRepository<Patient, Long> {
    Optional<Patient> findByEmailAndPassword(String email, String password);
}