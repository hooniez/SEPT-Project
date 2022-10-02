package com.sept_group6.sept_backend.security;

// import com.sept_group6.sept_backend.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import com.sept_group6.sept_backend.model.User;
import org.hibernate.Hibernate;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class JwtAuthenticationFilter extends OncePerRequestFilter {

    @Autowired
    private JwtTokenProvider tokenProvider;

    @Autowired
    private JwtUserDetailsService jwtUserDetailsService;

    private static final Logger logger = LogManager.getLogger("Backend");

    @Override
    protected void doFilterInternal(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
            FilterChain filterChain) throws ServletException, IOException {

        try {

            String jwt = getJWTFromRequest(httpServletRequest);

            if (StringUtils.hasText(jwt) && tokenProvider.validateToken(jwt)) {
                Long userUid = tokenProvider.getUserUidFromJWT(jwt);
                String userType = tokenProvider.getUserTypeFromJWT(jwt);
                JwtUserDetails userDetails = jwtUserDetailsService.loadUserByIdAndUserType(userUid,
                        userType);

                UsernamePasswordAuthenticationToken authentication = new CustomAuthenticationToken(
                        userDetails, null, userType, Collections.emptyList());

                authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(httpServletRequest));
                SecurityContextHolder.getContext().setAuthentication(authentication);

            }

        } catch (Exception ex) {
            logger.error("Could not set user authentication in security context", ex);
        }

        filterChain.doFilter(httpServletRequest, httpServletResponse);

    }

    private String getJWTFromRequest(HttpServletRequest request) {
        String bearerToken = request.getHeader(SecurityConstant.HEADER_STRING);

        if (StringUtils.hasText(bearerToken) && bearerToken.startsWith(SecurityConstant.TOKEN_PREFIX)) {
            return bearerToken.substring(7, bearerToken.length());
        }

        return null;
    }
}