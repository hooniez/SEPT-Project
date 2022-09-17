package com.sept_group6.appointment_server.controllers;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.sept_group6.appointment_server.dao.*;
import com.sept_group6.appointment_server.model.*;

import java.util.Optional;
import java.util.List;

@RestController
@RequestMapping(path = "/appointment")
public class AppointmentController {
    private static final Logger logger = LogManager.getLogger("Backend");
    @Autowired
    private PatientRepository patientRepository;
    @Autowired
    private DoctorRepository doctorRepository;
    @Autowired
    private AppointmentRepository appointmentRepository;

    @GetMapping("/")
    public ResponseEntity<?> loginUser(@RequestParam("email") String email, @RequestParam("usertype") String usertype) {
        Optional<List<Appointment>> appointments;
        if (usertype.equals("patient")) {
            appointments = appointmentRepository.findByPatientEmail(email);
        } else {
            appointments = appointmentRepository.findByDoctorEmail(email);
        }
        logger.info(appointments);
        if (appointments.isPresent()) {

            return ResponseEntity.accepted().body(appointments.get());
        } else {
            return ResponseEntity.badRequest().build();
        }
    }

    // @PutMapping(path = "/signup", consumes = "application/json", produces =
    // "application/json")
    // public ResponseEntity<?> addUser(@RequestBody Patient newPatient)
    // throws Exception {
    // logger.info(newPatient);

    // // add resource
    // Patient patient = patientRepository.save(newPatient);

    // return ResponseEntity.accepted().body(patient);

    // }
}
