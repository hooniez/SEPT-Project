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

    @GetMapping("all")
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

    @PutMapping("")
    public ResponseEntity<?> makeAppointment(@RequestBody AppointmentView newView) {

        // logger.info(email + " " + usertype);

        // two different logics for patient and doctor
        // not the best practice, need to refactor in the future

        // patient name is email here
        String patientEmail = newView.getPatientName();
        if (patientEmail != null && !patientEmail.isEmpty()) {
            logger.info("patient make appointment");
            logger.info(newView);
            // patient updates an existing entry
            Optional<Appointment> appointment;
            appointment = appointmentRepository.findById(newView.getId());
            if (appointment.isPresent()) {
                appointment.get().setPatient(patientRepository.findByEmail(patientEmail));
                appointment.get().setAppointmentbooked(true);
                Appointment savedAppointment = appointmentRepository.save(appointment.get());
                AppointmentView savedView = savedAppointment.createView();
                return ResponseEntity.accepted().body(savedView);
            } else {
                return ResponseEntity.badRequest().build();
            }
        } else {
            // logger.info("doctor make appointment");
            // logger.info(newView.getDoctorName());
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

    }
}
