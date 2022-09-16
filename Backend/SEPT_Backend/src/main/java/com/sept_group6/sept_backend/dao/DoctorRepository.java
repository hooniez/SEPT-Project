package com.sept_group6.sept_backend.dao;

import com.sept_group6.sept_backend.model.Patient;
import org.springframework.data.repository.CrudRepository;
import com.sept_group6.sept_backend.model.Doctor;

import java.util.Optional;

public interface DoctorRepository extends CrudRepository<Doctor, Integer> {
    Optional<Doctor> findByEmailAndPassword(String email, String password);
}