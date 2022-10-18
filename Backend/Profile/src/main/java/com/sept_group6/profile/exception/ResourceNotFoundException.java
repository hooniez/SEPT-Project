// credit https://www.bezkoder.com/spring-boot-controlleradvice-exceptionhandler/
// by bezkoder

package com.sept_group6.profile.exception;

public class ResourceNotFoundException extends RuntimeException {

    private static final long serialVersionUID = 1;

    public ResourceNotFoundException(String msg) {
        super(msg);
    }
}