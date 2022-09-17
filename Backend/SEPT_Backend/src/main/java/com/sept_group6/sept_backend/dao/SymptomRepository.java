package com.sept_group6.sept_backend.dao;

import org.springframework.data.repository.CrudRepository;
import com.sept_group6.sept_backend.model.Symptom;

import java.util.*;

public interface SymptomRepository extends CrudRepository<Symptom, Integer> {
    List<Symptom> findAllByEmail(String email);
}