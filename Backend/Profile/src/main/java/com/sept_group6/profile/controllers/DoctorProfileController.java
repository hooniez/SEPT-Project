package com.sept_group6.profile.controllers;

import com.sept_group6.profile.dao.DoctorRepository;
import com.sept_group6.profile.model.Doctor;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping(path = "/doctor/profile")
public class DoctorProfileController {
    private static final Logger logger = LogManager.getLogger("Backend");
    @Autowired
    private DoctorRepository doctorRepository;

    @PutMapping(path = "", consumes = "application/json", produces = "application/json")
    public ResponseEntity<?> updateInfo(@RequestBody Doctor doctorEdit) {
        System.out.println("Reached endpoint");
        Optional<Doctor> doctor = doctorRepository.findByEmail(doctorEdit.getEmail());

        if (doctor.isPresent()) {
            doctorRepository.save(doctorEdit);
            return ResponseEntity.accepted().build();
        } else {
            return ResponseEntity.badRequest().build();
        }
    }
}
