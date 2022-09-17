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
    private Integer id;
    private LocalDate date;
    private LocalTime starttime;
    private LocalTime endtime;
    private String patientName;
    private String doctorName;
    private boolean appointmentbooked;

}
