package com.sept_group6.appointment_server.security;

public class SecurityConstant {
    public static final String SIGN_UP_URLS = "/**/signin";
    // public static final String H2_URL = "/h2-console/**";
    // secret key
    public static final String SECRET = "SecretKeyToGenJWTs";
    public static final String TOKEN_PREFIX = "Bearer ";
    public static final String HEADER_STRING = "Authorization";
    public static final long EXPIRATION_TIME = 300_000; // 5 minutes
}
