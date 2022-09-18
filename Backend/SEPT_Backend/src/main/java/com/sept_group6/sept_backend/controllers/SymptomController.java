package com.sept_group6.sept_backend.controllers;

import com.sept_group6.sept_backend.dao.SymptomRepository;
import com.sept_group6.sept_backend.model.Symptom;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.*;

import java.util.Optional;

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

