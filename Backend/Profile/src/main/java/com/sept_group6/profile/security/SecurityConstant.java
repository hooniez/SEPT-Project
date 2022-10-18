package com.sept_group6.profile.security;

public class SecurityConstant {
    public static final String SIGN_UP_URLS = "/**/signin";
    // public static final String H2_URL = "/h2-console/**";
    // secret key
    public static final String SECRET = "SecretKeyToGenJWTs";
    public static final String TOKEN_PREFIX = "Bearer ";
    public static final String HEADER_STRING = "Authorization";
    public static final long EXPIRATION_TIME = 1800_000; // 30 minutes
}
