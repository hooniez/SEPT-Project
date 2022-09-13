package com.sept_group6.sept_backend.model;

import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Patient {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private String email;
    private String firstname;
    private String middlename;
    private String lastname;
    private LocalDate dob;
    private String password;
    private String mobilenumber;
    private String healthinformation;
    private String medicalhistory;

    public Patient(Integer id, String email, String firstNameBigLol, String middleName, String lastName,
        LocalDate dob, String password, String mobileNumber, String healthInformation, String medicalHistory) {

        this.id = id;
        this.email = email;
        this.firstname = firstNameBigLol;
        this.middlename = middleName;
        this.lastname = lastName;
        this.dob = dob;
        this.password = password;
        this.mobilenumber = mobileNumber;
        this.healthinformation = healthInformation;
        this.medicalhistory = medicalHistory;
    }

    public Integer getid() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public String getFirstName() {
        return firstname;
    }

    public String getMiddleName() {
        return middlename;
    }

    public String getLastName() {
        return lastname;
    }

    public LocalDate getDob() {
        return dob;
    }

    public String getPassword() {
        return password;
    }

    public String getMobileNumber() {
        return mobilenumber;
    }

    public String getHealthInformation() {
        return healthinformation;
    }

    public String getmedicalHistory() {
        return medicalhistory;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setFirstName(String firstName) {
        this.firstname = firstName;
    }

    public void setMiddleName(String middleName) {
        this.middlename = middleName;
    }

    public void setLastName(String lastName) {
        this.lastname = lastName;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobilenumber = mobileNumber;
    }

    public void setHealthInformation(String healthInformation) {
        this.healthinformation = healthInformation;
    }

    public void setmedicalHistory(String medicalHistory) {
        this.medicalhistory = medicalHistory;
    }

    public String toString() {
        return "id= " + id + "email= " + email + "firstName= " + firstname + "middleName= " + middlename + "lastName= " + lastname + "dob= " + dob + "password= " + password + "mobileNumber= " + mobilenumber + "healthInformation= " + healthinformation + "medicalHistory= " + medicalhistory;
    }

}
