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
import java.util.stream.Collectors;

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

    @GetMapping("")
    public ResponseEntity<?> getAppointment(@RequestParam("email") String email,
            @RequestParam("usertype") String usertype) {
        // logger.info(email + " " + usertype);
        Optional<List<Appointment>> appointments;
        if (usertype.equals("patient")) {
            appointments = appointmentRepository.findByPatientEmail(email);
        } else {
            appointments = appointmentRepository.findByDoctorEmail(email);
        }
        logger.info(appointments);
        if (appointments.isPresent()) {
            var appointmentViews = appointments.get().stream().map(Appointment::createView)
                    .collect(Collectors.toList());
            return ResponseEntity.accepted().body(appointmentViews);
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
