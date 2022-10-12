package com.ChatService.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ChatService.dao.PatientRepository;
import com.ChatService.model.Patient;
import com.ChatService.model.Doctor;
import com.ChatService.dao.DoctorRepository;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.http.ResponseEntity;
import java.util.Optional;

public class ContactController {
    @Autowired
    private PatientRepository patientRepo;
    private DoctorRepository doctorRepo;

    @GetMapping(path="/chat/patient/{stringId}")
    public ResponseEntity<?> getPatient(@PathVariable String stringId) {
        Long id;

        try {
            id = Long.parseLong(stringId);
        } catch ( NumberFormatException e) {
            return ResponseEntity.badRequest().build();
        }
        
        Optional<Patient> patient = patientRepo.findById(id);
        
        if (patient.isPresent()) {
            return ResponseEntity.accepted().body(patient);
        } else {
            return ResponseEntity.badRequest().body("no account found");
        }
    }

    @GetMapping(path="/chat/Patient/all", produces = "application/json")
    public @ResponseBody Iterable<Patient> getAllPatients() {
        return patientRepo.findAll();
    }

    @GetMapping(path="/chat/doctor/{stringId}")
    public ResponseEntity<?> getDoctor(@PathVariable String stringId) {
        Long id;

        try {
            id = Long.parseLong(stringId);
        } catch ( NumberFormatException e) {
            return ResponseEntity.badRequest().build();
        }
        
        Optional<Doctor> doctor = doctorRepo.findById(id);
        
        if (doctor.isPresent()) {
            return ResponseEntity.accepted().body(doctor);
        } else {
            return ResponseEntity.badRequest().body("no account found");
        }
    }

    @GetMapping(path="/chat/doctor/all", produces = "application/json")
    public @ResponseBody Iterable<Doctor> getAllDoctors() {
        return doctorRepo.findAll();
    }
}
