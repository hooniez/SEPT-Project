package com.sept_group6.sept_backend.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

import javax.persistence.*;

import org.hibernate.query.criteria.internal.PathImplementor;

import java.time.LocalDate;
import java.time.LocalTime;

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
    @Column(name = "email")
    private Patient patient;
    @ManyToOne
    @Column(name = "email")
    private Doctor doctor;

    private LocalTime starttime;
    private LocalTime endtime;
    private LocalDate date;
    private boolean appointmentbooked;

}
