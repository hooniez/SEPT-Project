package com.sept_group6.symptom.exception;

import java.util.Objects;

public class GetRootException {
    public static Throwable getRootException(Throwable throwable) {
        Objects.requireNonNull(throwable);
        Throwable rootCause = throwable;
        while (rootCause.getCause() != null && rootCause.getCause() != rootCause) {
            rootCause = rootCause.getCause();
        }
        return rootCause;
    }
}
