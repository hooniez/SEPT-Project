package com.sept_group6.appointment_server.controllers;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.sept_group6.appointment_server.dao.*;
import com.sept_group6.appointment_server.model.*;
import com.sept_group6.appointment_server.security.CustomAuthenticationToken;

import java.util.Optional;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping(path = "/availability")
public class AvailabilityController {
    private static final Logger logger = LogManager.getLogger("Backend");

    @Autowired
    private DoctorRepository doctorRepository;
    @Autowired
    private AppointmentRepository appointmentRepository;

    // get all unbooked appointments
    @GetMapping("")
    public ResponseEntity<?> getUnbookedAppointment() {
        // logger.info(email + " " + usertype);
        Optional<List<Appointment>> appointments;
        // select all unbooked appointments
        appointments = appointmentRepository.findByAppointmentbooked(false);
        logger.info(appointments);
        if (appointments.isPresent()) {
            var appointmentViews = appointments.get().stream().map(Appointment::createView)
                    .collect(Collectors.toList());
            return ResponseEntity.accepted().body(appointmentViews);
        } else {
            return ResponseEntity.badRequest().build();
        }

    }

    // create a unbooked appointment
    @PostMapping("")
    public ResponseEntity<?> makeAppointment(@RequestBody AppointmentView newView,
            CustomAuthenticationToken authentication) {

        // logger.info(email + " " + usertype);

        if (!authentication.getUserType().equals("doctor")) {
            return ResponseEntity.badRequest().body("User type must be doctor!");
        }
        // patient name is email here
        String patientEmail = newView.getPatientName();
        if (patientEmail == null || patientEmail.isEmpty()) {
            // doctor create a new entry
            Appointment newAppointment = new Appointment();
            logger.info(newView);
            // doctor name is email here
            newAppointment.setDoctor(doctorRepository.findByEmail(newView.getDoctorName()));
            newAppointment.setDate(newView.getDate());
            newAppointment.setStarttime(newView.getStarttime());
            newAppointment.setEndtime(newView.getEndtime());
            newAppointment.setAppointmentbooked(false);
            Appointment savedAppointment = appointmentRepository.save(newAppointment);
            AppointmentView savedView = savedAppointment.createView();
            return ResponseEntity.accepted().body(savedView);
        }
        return ResponseEntity.badRequest().build();

    }
}
