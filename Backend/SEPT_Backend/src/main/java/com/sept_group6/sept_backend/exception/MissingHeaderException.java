package com.sept_group6.sept_backend.exception;

public class MissingHeaderException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    public MissingHeaderException(String exception) {
        super(exception);
    }
}