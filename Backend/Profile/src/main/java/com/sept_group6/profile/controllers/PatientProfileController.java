package com.sept_group6.profile.controllers;

import com.sept_group6.profile.dao.PatientRepository;
import com.sept_group6.profile.model.Patient;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping(path="/profile")
public class PatientProfileController {
    private static final Logger logger = LogManager.getLogger("Backend");
    @Autowired
    private PatientRepository patientRepository;


    @PutMapping(path="", consumes="application/json", produces="application/json")
    public ResponseEntity<?> updateInfo(@RequestBody Patient patientEdit,
                                        @PathVariable("email") String email) {

        Optional<Patient> patient =
                patientRepository.findByEmail(patientEdit.getEmail());

        if (patient.isPresent()) {
            patientRepository.save(patientEdit);
            return ResponseEntity.accepted().build();
        } else {
            return ResponseEntity.badRequest().build();
        }
    }
}
