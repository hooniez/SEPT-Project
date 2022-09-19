package com.sept_group6.profile.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Doctor {

    @Id
    private String email;
    private String firstname;
    private String lastname;

    private String dob;
    private String password;
    private String mobilenumber;
    private String medicalhistory;

    public String toString() {
        return " email= " + email + " firstName= " + firstname + " lastName= " + lastname +
                " dob= " + dob + " password= " + password + " mobileNumber= " + mobilenumber + " medicalHistory= " + medicalhistory;
    }

}
