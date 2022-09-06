package com.sept_group6.sept_backend.model;

import java.time.LocalDate;

public class Patient {
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

    public Integer getid() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public String getFirstname() {
        return firstname;
    }

    public String getMiddlename() {
        return middlename;
    }

    public String getLastname() {
        return lastname;
    }

    public LocalDate getDob() {
        return dob;
    }

    public String getPassword() {
        return password;
    }

    public String getMobilenumber() {
        return mobilenumber;
    }

    public String getHealthinformation() {
        return healthinformation;
    }

    public String getMedicalhistory() {
        return medicalhistory;
    }

    public void setid(Integer id) {
        this.id = id;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public void setMiddlename(String middlename) {
        this.middlename = middlename;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setMobilenumber(String mobilenumber) {
        this.mobilenumber = mobilenumber;
    }

    public void setHealthinformation(String healthinformation) {
        this.healthinformation = healthinformation;
    }

    public void setMedicalhistory(String medicalhistory) {
        this.medicalhistory = medicalhistory;
    }
}
