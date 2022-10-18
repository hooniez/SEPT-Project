package com.sept_group6.appointment_server.exception;

public class WrongAppoinementException extends Exception {
    public WrongAppoinementException() {
        super("Wrong Appointment ID!");
    }
}
