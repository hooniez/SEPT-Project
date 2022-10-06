package com.sept_group6.profile.dao;

import com.sept_group6.profile.model.Doctor;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface DoctorRepository extends CrudRepository<Doctor, Integer> {
    Optional<Doctor> findByEmail(String email);

}