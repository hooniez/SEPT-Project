package com.sept_group6.appointment_server.security;

// https://www.baeldung.com/spring-security-extra-login-fields
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

public class CustomUsernamePasswordAuthenticationFilter extends UsernamePasswordAuthenticationFilter {

    public static final String USERTYPE_KEY = "userType";

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
            throws AuthenticationException {

        if (!request.getMethod().equals("POST")) {
            throw new AuthenticationServiceException("Authentication method not supported: "
                    + request.getMethod());
        }

        CustomAuthenticationToken authRequest = getAuthRequest(request);
        setDetails(request, authRequest);
        return this.getAuthenticationManager().authenticate(authRequest);
    }

    private CustomAuthenticationToken getAuthRequest(HttpServletRequest request) {
        String username = obtainUsername(request);
        String password = obtainPassword(request);
        String userType = obtainUserType(request);

        if (username == null) {
            username = "";
        }
        if (password == null) {
            password = "";
        }
        if (userType == null) {
            userType = "";
        }

        return new CustomAuthenticationToken(username, password, userType);
    }

    private String obtainUserType(HttpServletRequest request) {
        return request.getParameter(USERTYPE_KEY);
    }
}