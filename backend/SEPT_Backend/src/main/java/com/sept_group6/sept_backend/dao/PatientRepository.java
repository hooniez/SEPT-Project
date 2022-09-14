package com.sept_group6.sept_backend.dao;

import org.springframework.data.repository.CrudRepository;
import com.sept_group6.sept_backend.model.Patient;

import java.util.Optional;

public interface PatientRepository extends CrudRepository<Patient, Long> {
    Optional<Patient> findByEmailAndPassword(String email, String password);
}