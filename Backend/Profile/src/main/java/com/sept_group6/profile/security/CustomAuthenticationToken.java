package com.sept_group6.profile.security;

// https://www.baeldung.com/spring-security-extra-login-fields
import java.util.Collection;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

public class CustomAuthenticationToken extends UsernamePasswordAuthenticationToken {

    private String userType;

    public CustomAuthenticationToken(Object principal, Object credentials, String userType) {
        super(principal, credentials);
        this.userType = userType;
        // super.setAuthenticated(false);
    }

    public CustomAuthenticationToken(Object principal, Object credentials, String userType,
            Collection<? extends GrantedAuthority> authorities) {
        super(principal, credentials, authorities);
        this.userType = userType;
        // super.setAuthenticated(true); // must use super, as we override
    }

    public String getUserType() {
        return this.userType;
    }
}