package com.sept_group6.sept_backend.controllers;

import com.sept_group6.sept_backend.dao.DoctorRepository;
import com.sept_group6.sept_backend.model.Doctor;
import com.sept_group6.sept_backend.model.Patient;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping(path = "/doctor")
public class DoctorController {
    private static final Logger logger = LogManager.getLogger("Backend");

    @Autowired
    private DoctorRepository doctorRepository;

    /* not need for signup at the moment */
    // @GetMapping(path = "", produces = "application/json")
    // public Users getUsers() {
    // return new Users();
    // }

    @GetMapping("/signin")
    public ResponseEntity<?> loginUser(@RequestParam("email") String email,
                                       @RequestParam("password") String password) {

        Optional<Doctor> doctor =
                doctorRepository.findByEmailAndPassword(email, password);

        if (doctor.isPresent()) {
            return ResponseEntity.accepted().body(doctor.get());
        } else {
            return ResponseEntity.badRequest().build();
        }
    }

    @PutMapping(path = "/signup", consumes="application/json", produces =
            "application/json")
    public ResponseEntity<?> addUser(@RequestBody Doctor newDoctor)
            throws Exception {
        logger.info(newDoctor);

        // add resource
        Doctor doctor = doctorRepository.save(newDoctor);

        return ResponseEntity.accepted().body(doctor);

    }
}
