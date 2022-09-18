package com.sept_group6.appointment_server.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

import java.time.LocalDate;
import java.time.LocalTime;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AppointmentView {
    private Long id;
    private LocalDate date;
    private LocalTime starttime;
    private LocalTime endtime;
    private String patientName;
    private String doctorName;
    private boolean appointmentbooked;

    // public AppointmentView(Appointment appointment) {
    // id = appointment.getId();
    // date = appointment.getDate();
    // starttime = appointment.getStarttime();
    // endtime = appointment.getEndtime();
    // patientName = appointment.getPatient().getFirstname() + " " +
    // appointment.getDoctor().getLastname();
    // appointmentbooked = appointment.isAppointmentbooked();

    // }

}
