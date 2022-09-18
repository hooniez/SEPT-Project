package com.sept_group6.appointment_server.dao;

import org.springframework.data.repository.CrudRepository;

import com.sept_group6.appointment_server.model.Doctor;
import com.sept_group6.appointment_server.model.Patient;

import java.util.Optional;

public interface DoctorRepository extends CrudRepository<Doctor, Integer> {
    Optional<Doctor> findByEmailAndPassword(String email, String password);
}