package com.sept_group6.appointment_server.model;

import lombok.AllArgsConstructor;
import lombok.ToString;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import javax.persistence.*;

@Entity
@ToString(callSuper = true)
@Getter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
public class Doctor extends User {

    private String certificate;

    public Doctor(long uid, String email, String firstname, String lastname, String dob, String password,
            String mobilenumber, String certificate) {
        super(uid, email, firstname, lastname, dob, password, mobilenumber);
        this.certificate = certificate;
    }

}