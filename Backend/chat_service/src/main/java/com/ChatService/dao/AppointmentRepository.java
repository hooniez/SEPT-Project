package com.ChatService.dao;

import org.springframework.data.repository.CrudRepository;
import java.util.Optional;
import java.util.List;

import com.ChatService.model.Appointment;

public interface AppointmentRepository extends CrudRepository<Appointment, Long> {
    Optional<List<Appointment>> findByPatientEmail(String patientEmail);

    Optional<List<Appointment>> findByDoctorEmail(String doctorEmail);

    Optional<List<Appointment>> findByAppointmentbooked(boolean booked);
}