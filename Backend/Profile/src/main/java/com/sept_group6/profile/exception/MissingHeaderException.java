package com.sept_group6.profile.exception;

public class MissingHeaderException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    public MissingHeaderException(String exception) {
        super(exception);
    }
}