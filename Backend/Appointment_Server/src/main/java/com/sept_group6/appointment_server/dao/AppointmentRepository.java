package com.sept_group6.appointment_server.dao;

import org.springframework.data.repository.CrudRepository;
import java.util.Optional;
import java.util.List;

import com.sept_group6.appointment_server.model.Appointment;

public interface AppointmentRepository extends CrudRepository<Appointment, Long> {
    Optional<List<Appointment>> findByPatientEmail(String patientEmail);

    Optional<List<Appointment>> findByDoctorEmail(String patientEmail);
}