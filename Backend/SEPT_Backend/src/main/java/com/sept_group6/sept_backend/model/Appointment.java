package com.sept_group6.sept_backend.model;

import java.time.LocalDate;
import java.time.LocalTime;

public class Appointment {
    private Integer id;
    private Integer patientid;
    private Integer doctorid;
    private LocalTime starttime;
    private LocalTime endtime;
    private LocalDate date;
    private boolean appointmentbooked;


    public Integer getid() {
        return id;
    }

    public Integer getPatientid() {
        return patientid;
    }

    public Integer getDoctorid() {
        return doctorid;
    }

    public LocalTime getStarttime() {
        return starttime;
    }

    public LocalTime getEndtime() {
        return endtime;
    }

    public LocalDate getDate() {
        return date;
    }

    public boolean setAppointmentbooked() {
        return appointmentbooked;
    }

    public void setid(Integer id) {
        this.id = id;
    }
    
    public void setPatientid(Integer patientid) {
        this.patientid = patientid;
    }
    
    public void setDoctorid(Integer doctorid) {
        this.doctorid = doctorid;
    }
    
    public void setStarttime(LocalTime starttime) {
        this.starttime = starttime;
    }
    
    public void setEndtime(LocalTime endtime) {
        this.endtime = endtime;
    }
    
    public void setDate(LocalDate date) {
        this.date = date;
    }
    
    public void setAppointmentbooked(boolean appointmentbooked) {
        this.appointmentbooked = appointmentbooked;
    }

}
