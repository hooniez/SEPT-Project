package com.sept_group6.appointment_server.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

import javax.persistence.*;

import java.time.LocalDate;
import java.time.LocalTime;

import com.sept_group6.appointment_server.model.AppointmentView;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Appointment {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    @ManyToOne
    @JoinColumn(name = "patientEmail", referencedColumnName = "email")
    private Patient patient;
    @ManyToOne
    @JoinColumn(name = "doctorEmail", referencedColumnName = "email")
    private Doctor doctor;

    private LocalTime starttime;
    private LocalTime endtime;
    private LocalDate date;
    private boolean appointmentbooked;

    public AppointmentView createView() {
        return new AppointmentView(id, date, starttime, endtime,
                patient.getFirstname() + " " + patient.getLastname(),
                doctor.getFirstname() + " " + doctor.getLastname(), appointmentbooked);
    }
}
