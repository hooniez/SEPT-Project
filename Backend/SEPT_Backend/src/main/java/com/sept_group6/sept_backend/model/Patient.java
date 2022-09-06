package com.sept_group6.sept_backend.model;

import java.time.LocalDate;

public class Patient {
    private Integer id;
    private String email;
    private String firstName;
    private String middleName;
    private String lastName;
    private LocalDate dob;
    private String password;
    private String mobileNumber;
    private String healthInformation;
    private String medicalHistory;

    public Patient(Integer id, String email, String firstName, String middleName, String lastName,
        LocalDate dob, String password, String mobileNumber, String healthInformation, String medicalHistory) {
        
        this.id = id;
        this.email = email;
        this.firstName = firstName;
        this.middleName = middleName;
        this.lastName = lastName;
        this.dob = dob;
        this.password = password;
        this.mobileNumber = mobileNumber;
        this.healthInformation = healthInformation;
        this.medicalHistory = medicalHistory;
    }

    public Integer getid() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getMiddleName() {
        return middleName;
    }

    public String getLastName() {
        return lastName;
    }

    public LocalDate getDob() {
        return dob;
    }

    public String getPassword() {
        return password;
    }

    public String getMobileNumber() {
        return mobileNumber;
    }

    public String getHealthInformation() {
        return healthInformation;
    }

    public String getmedicalHistory() {
        return medicalHistory;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    public void setHealthInformation(String healthInformation) {
        this.healthInformation = healthInformation;
    }

    public void setmedicalHistory(String medicalHistory) {
        this.medicalHistory = medicalHistory;
    }
}
