package com.ChatService.dao;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.ChatService.model.Doctor;

@Repository
public interface DoctorRepository extends CrudRepository<Doctor, Long> {

}