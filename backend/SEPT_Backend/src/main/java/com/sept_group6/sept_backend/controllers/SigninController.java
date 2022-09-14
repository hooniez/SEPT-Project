package com.sept_group6.sept_backend.controllers;

import com.sept_group6.sept_backend.dao.PatientRepository;
import com.sept_group6.sept_backend.model.Patient;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping(path="/signin")
public class SigninController {
    private static final Logger logger = LogManager.getLogger("Backend");
    @Autowired
    private PatientRepository patientRepository;

    @GetMapping("")
    public ResponseEntity<?> loginUser(@RequestParam("email") String email,
                                       @RequestParam("password") String password) {

        Optional<Patient> patient =
                patientRepository.findByEmailAndPassword(email, password);

       if (patient.isPresent()) {
           return ResponseEntity.accepted().body(patient.get());
       } else {
           return ResponseEntity.badRequest().build();
       }
    }
}
