package com.sept_group6.sept_backend.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Prescription {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private Integer patientid;
    private String prescriptiondetails;
    private String prescriptioninstructions;

    public Integer getId() {
        return id;
    }

    public Integer getPatientid() {
        return patientid;
    }

    public String getPrescriptiondetails() {
        return prescriptiondetails;
    }

    public String getPrescriptioninstructions() {
        return prescriptioninstructions;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setPatientid(Integer patientid) {
        this.patientid = patientid;
    }

    public void setPrescriptiondetails(String prescriptiondetails) {
        this.prescriptiondetails = prescriptiondetails;
    }

    public void setPrescriptioninstructions(String prescriptioninstructions) {
        this.prescriptioninstructions = prescriptioninstructions;
    }
}
