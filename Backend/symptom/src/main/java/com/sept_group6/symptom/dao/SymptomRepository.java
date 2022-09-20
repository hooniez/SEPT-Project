package com.sept_group6.symptom.dao;

import org.springframework.data.repository.CrudRepository;
import com.sept_group6.symptom.model.Symptom;

import java.util.*;

public interface SymptomRepository extends CrudRepository<Symptom, Integer> {
    List<Symptom> findAllByEmail(String email);
    void deleteById(int id);
    boolean existsByEmail(String email);
    boolean existsById(int id);
}