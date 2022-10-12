package com.ChatService.dao;

import org.springframework.data.repository.CrudRepository;
import com.ChatService.model.Doctor;

public interface DoctorRepository extends CrudRepository<Doctor, Long> {

}