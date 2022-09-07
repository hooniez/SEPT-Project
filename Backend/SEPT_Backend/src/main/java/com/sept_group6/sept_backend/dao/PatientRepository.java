package com.sept_group6.sept_backend.dao;

import org.springframework.data.repository.CrudRepository;
import com.sept_group6.sept_backend.model.Patient;

public interface PatientRepository extends CrudRepository<Patient, Integer> {

}