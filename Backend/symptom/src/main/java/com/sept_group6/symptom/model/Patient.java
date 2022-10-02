package com.sept_group6.symptom.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import lombok.experimental.SuperBuilder;

import java.time.LocalDate;

import javax.persistence.*;

@Entity
@Getter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class Patient extends User {

    private String medicalhistory;

    public Patient(long uid, String email, String firstname, String lastname, String dob, String password,
            String mobilenumber, String medicalhistory) {
        super(uid, email, firstname, lastname, dob, password, mobilenumber);
        this.medicalhistory = medicalhistory;
    }

}
