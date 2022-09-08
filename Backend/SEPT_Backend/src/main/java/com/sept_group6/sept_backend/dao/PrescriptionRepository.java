package com.sept_group6.sept_backend.dao;

import org.springframework.data.repository.CrudRepository;
import com.sept_group6.sept_backend.model.Prescription;

public interface PrescriptionRepository extends CrudRepository<Prescription, Integer> {

}