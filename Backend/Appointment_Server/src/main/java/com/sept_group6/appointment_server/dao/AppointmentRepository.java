package com.sept_group6.appointment_server.dao;

import org.springframework.data.repository.CrudRepository;
import java.util.Optional;

import com.sept_group6.appointment_server.model.Appointment;

public interface AppointmentRepository extends CrudRepository<Appointment, Long> {
    Optional<Appointment> findByPatientEmail(String patientEmail);

    Optional<Appointment> findByDoctorEmail(String patientEmail);
}