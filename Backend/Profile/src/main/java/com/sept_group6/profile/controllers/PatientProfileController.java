package com.sept_group6.profile.controllers;

// security
import com.sept_group6.profile.exception.ResourceNotFoundException;
import com.sept_group6.profile.model.Doctor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

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
@RequestMapping(path="/patient/profile")
public class PatientProfileController {
    private static final Logger logger = LogManager.getLogger("Backend");
    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @PutMapping(path="", consumes="application/json", produces="application/json")
    public ResponseEntity<?> updateInfo(@RequestBody Patient patientEdit) {
        System.out.println("Reached endpoint");
        Patient patient =
                patientRepository.findByEmail(patientEdit.getEmail());

        if(patientRepository.existsByEmail(patientEdit.getEmail())) {
            if(patientEdit.getPassword().equals(patient.getPassword())) {
                System.out.println("Password did not change");
                patientEdit.setPassword(patientEdit.getPassword());
            } else {
                patientEdit.setPassword(bCryptPasswordEncoder.encode(patientEdit.getPassword()));
                System.out.println("Password changed");
            }
            patientEdit.setUid(patient.getUid());
            patientRepository.save(patientEdit);
            return ResponseEntity.accepted().build();
        } else {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping(path="/{id}", produces="application/json")
    public ResponseEntity<Patient> getPatientById(@PathVariable("id") Long id) {
        System.out.println("**** In get Patient by Id ****");
        Patient accountData = patientRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Patient with id: " + id +" not found."));
        return new ResponseEntity<>(accountData,HttpStatus.OK);
    }


}
