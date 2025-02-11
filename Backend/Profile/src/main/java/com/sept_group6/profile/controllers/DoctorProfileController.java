package com.sept_group6.profile.controllers;

// security
import com.sept_group6.profile.exception.ResourceNotFoundException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.sept_group6.profile.dao.DoctorRepository;
import com.sept_group6.profile.model.Doctor;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping(path="/doctor/profile")
public class DoctorProfileController {
    private static final Logger logger = LogManager.getLogger("Backend");
    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @PutMapping(path="", consumes="application/json", produces="application/json")
    public ResponseEntity<?> updateInfo(@RequestBody Doctor doctorEdit) {
        System.out.println("Reached endpoint _ test");
        Optional<Doctor> doctor =
                doctorRepository.findByEmail(doctorEdit.getEmail());

        if(doctorRepository.existsByEmail(doctorEdit.getEmail())) {
            System.out.println("found_doctor");
            if(doctorEdit.getPassword().equals(doctor.get().getPassword())) {
                System.out.println("Password did not change");
                doctorEdit.setPassword(doctorEdit.getPassword());
            } else {
                System.out.println("Password changed");
                doctorEdit.setPassword(bCryptPasswordEncoder.encode(doctorEdit.getPassword()));
            }
            doctorEdit.setUid(doctor.get().getUid());
            System.out.println("beforeSave");
            doctorRepository.save(doctorEdit);
            return ResponseEntity.accepted().build();
        } else {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping(path="/{id}", produces="application/json")
    public ResponseEntity<Doctor> getDoctorById(@PathVariable("id") Long id) {
        Doctor accountData = doctorRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Doctor with id: " + id +" not found."));
        return new ResponseEntity<>(accountData,HttpStatus.OK);
    }
}
