package com.sept_group6.sept_backend.model;

public class User {

    public User() {

    }

    private Integer uid;
    private String firstName;
    private String middleName;
    private String lastName;
    private String email;
    private String DOB;
    private String password;
    private String mobileNumber;
    private String healthInformation;
    private String medicalHistory;

    public User(String firstName, String middleName, String lastName, String email, String DOB, String password,
            String mobileNumber, String healthInformation, String medicalHistory) {
        super();
        this.firstName = firstName;
        this.middleName = middleName;
        this.lastName = lastName;
        this.email = email;
        this.DOB = DOB;
        this.password = password;
        this.mobileNumber = mobileNumber;
        this.healthInformation = healthInformation;
        this.medicalHistory = medicalHistory;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getMiddleName() {
        return middleName;
    }

    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    public String getDOB() {
        return DOB;
    }

    public void setDOB(String DOB) {
        this.DOB = DOB;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    public String gethealthInformation() {
        return healthInformation;
    }

    public void sethealthInformation(String healthInformation) {
        this.healthInformation = healthInformation;
    }

    public String getMedicalHistory() {
        return medicalHistory;
    }

    public void setMedicalHistory(String medicalHistory) {
        this.medicalHistory = medicalHistory;
    }

    public Integer getId() {
        return uid;
    }

    public void setId(Integer uid) {
        this.uid = uid;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "uid=" + uid + ", firstName=" + firstName + ", lastName=" + lastName + ", email=" + email + "]";
    }
}
