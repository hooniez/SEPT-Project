package com.sept_group6.appointment_server.controllers;

import com.sept_group6.appointment_server.security.JwtUserDetails;
import com.sept_group6.appointment_server.security.CustomAuthenticationToken;

import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.test.context.support.WithSecurityContextFactory;

public class WithMockCustomUserSecurityContextFactory
        implements WithSecurityContextFactory<WithMockCustomUser> {
    @Override
    public SecurityContext createSecurityContext(WithMockCustomUser customUser) {
        SecurityContext context = SecurityContextHolder.createEmptyContext();

        JwtUserDetails principal = new JwtUserDetails(1L, "user", "password", customUser.userType());
        CustomAuthenticationToken auth = new CustomAuthenticationToken(principal, "password", "patient");
        context.setAuthentication(auth);
        return context;
    }
}