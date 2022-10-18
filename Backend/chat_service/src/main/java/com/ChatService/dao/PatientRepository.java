package com.ChatService.dao;

import org.springframework.data.repository.CrudRepository;
import com.ChatService.model.Patient;
import org.springframework.stereotype.Repository;

@Repository
public interface PatientRepository extends CrudRepository<Patient, Long> {

}