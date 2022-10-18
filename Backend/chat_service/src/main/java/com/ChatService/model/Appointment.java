package com.ChatService.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

import javax.persistence.*;

import java.time.LocalDate;
import java.time.LocalTime;

import com.sept_group6.appointment_server.model.AppointmentView;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Appointment {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "patientUid", referencedColumnName = "uid")
    private Patient patient;
    @ManyToOne
    @JoinColumn(name = "doctorUid", referencedColumnName = "uid")
    private Doctor doctor;

    private LocalTime starttime;
    private LocalTime endtime;
    private LocalDate date;
    private boolean appointmentbooked;

    public AppointmentView createView() {
        String patientName;
        String doctorName;
        if (patient != null) {
            patientName = patient.getFirstname() + " " + patient.getLastname();
        } else {
            patientName = "";
        }
        if (doctor != null) {
            doctorName = doctor.getFirstname() + " " + doctor.getLastname();
        } else {
            doctorName = "";
        }

        return new AppointmentView(id, date, starttime, endtime, patientName, doctorName, appointmentbooked);
    }

}
