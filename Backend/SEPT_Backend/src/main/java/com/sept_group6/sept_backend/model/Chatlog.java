package com.sept_group6.sept_backend.model;

import java.time.LocalDate;

public class Chatlog {
    private Integer id;
    private Integer patientid;
    private Integer doctorid;
    private LocalDate date;
    private Integer messagehistory;

    public Integer getid() {
        return id;
    }

    public Integer getPatientid() {
        return patientid;
    }

    public Integer getDoctorid() {
        return doctorid;
    }

    public LocalDate getDate() {
        return date;
    }

    public Integer getMessagehistory() {
        return messagehistory;
    }


    public void setid (Integer id) {
        this.id = id;
    }

    public void setPatientid (Integer patientid) {
        this.patientid = patientid;
    }

    public void setDoctorid (Integer doctorid) {
        this.doctorid = doctorid;
    }

    public void setDate (LocalDate date) {
        this.date = date;
    }

    public void setMessagehistory (Integer messagehistory) {
        this.messagehistory = messagehistory;
    }
}
