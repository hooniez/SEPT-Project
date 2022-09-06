package com.sept_group6.sept_backend.model;

public class Doctor {
    private Integer id;
    private String email;
    private String firstname;
    private String middlename;
    private String lastname;
    private String password;
    private String mobilenumber;

    public Doctor(Integer id, String email, String firstname, String middlename, String lastname, String password, String mobilenumber) {
        this.id = id;
        this.email = email;
        this.firstname = firstname;
        this.middlename = middlename;
        this.lastname = lastname;
        this.password = password;
        this.mobilenumber = mobilenumber;
    }


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

    public String getPassword() {
        return password;
    }

    public String getMobilenumber() {
        return mobilenumber;
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

    public void setPassword(String password) {
        this.password = password;
    }

    public void setMobilenumber(String mobilenumber) {
        this.mobilenumber = mobilenumber;
    }

}
