package com.ChatService.dao;

import org.springframework.data.repository.CrudRepository;
import com.ChatService.model.Patient;

public interface PatientRepository extends CrudRepository<Patient, Long> {

}