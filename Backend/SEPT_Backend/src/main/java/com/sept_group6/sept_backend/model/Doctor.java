package com.sept_group6.sept_backend.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
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
    private String certificate;

    public String toString() {
        return " email= " + email + " firstName= " + firstname + " lastName= " + lastname +
                " dob= " + dob + " password= " + password + " mobileNumber= " + mobilenumber + " certificate= " + certificate;
    }

}