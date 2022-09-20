package com.sept_group6.symptom.controllers;

import com.sept_group6.symptom.dao.SymptomRepository;
import com.sept_group6.symptom.model.Symptom;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.*;

@RestController
@RequestMapping()
public class SymptomController {
    private static final Logger logger = LogManager.getLogger("Backend");
    @Autowired
    private SymptomRepository symptomRepository;

    @GetMapping("/getsymptom")
    public ResponseEntity<?> getSymptom(@RequestParam("email") String email) {
        List<Symptom> symptom =
                symptomRepository.findAllByEmail(email);
        return ResponseEntity.accepted().body(symptom);
    }

    @DeleteMapping("/deletesymptom")
    public void deleteSymptom(@RequestParam("id") int id) {
        symptomRepository.deleteById(id);
    }

    @PutMapping(path = "/addsymptom", consumes="application/json", produces =
            "application/json")
    public ResponseEntity<?> addSymptom(@RequestBody Symptom newSymptom)
            throws Exception {
        logger.info(newSymptom);

        // add resource
        Symptom symptom = symptomRepository.save(newSymptom);

        return ResponseEntity.accepted().body(symptom);

    }
}

