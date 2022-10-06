package com.sept_group6.profile.security;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
@EnableGlobalMethodSecurity(securedEnabled = true, jsr250Enabled = true, prePostEnabled = true)
public class SecurityConfig {

    @Autowired
    private JwtAuthenticationEntryPoint unauthorizedHandler;

    @Autowired
    private JwtUserDetailsService jwtUserDetailsService;

    @Autowired
    private CustomUserDetailsAuthenticationProvider authenticationProvider;

    private final AuthenticationConfiguration configuration;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Bean
    AuthenticationManager authenticationManager() throws Exception {
        return configuration.getAuthenticationManager();
    }

    @Bean
    public JwtAuthenticationFilter jwtAuthenticationFilter() {
        return new JwtAuthenticationFilter();
    }

    // @Bean
    // public CustomUsernamePasswordAuthenticationFilter authenticationFilter()
    // throws Exception {
    // CustomUsernamePasswordAuthenticationFilter filter =
    // filter.setAuthenticationManager(authenticationManager());
    // // filter.setAuthenticationFailureHandler(failureHandler());
    // return new CustomUsernamePasswordAuthenticationFilter();
    // }

    // @Autowired
    // void configure(AuthenticationManagerBuilder builder) throws Exception {
    // builder.userDetailsService(jwtUserDetailsService).passwordEncoder(bCryptPasswordEncoder());
    // }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        AuthenticationManagerBuilder authenticationManagerBuilder = http
                .getSharedObject(AuthenticationManagerBuilder.class);
        authenticationManagerBuilder.userDetailsService(jwtUserDetailsService)
                .passwordEncoder(bCryptPasswordEncoder);
        AuthenticationManager authenticationManager = authenticationManagerBuilder.build();

        http.cors().and().csrf().disable()
                .exceptionHandling().authenticationEntryPoint(unauthorizedHandler).and()
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                // .headers().frameOptions().sameOrigin() // To enable H2 Database
                // .and()
                .authorizeRequests()
                .antMatchers(
                        "/",
                        "/favicon.ico",
                        "/**/*.png",
                        "/**/*.gif",
                        "/**/*.svg",
                        "/**/*.jpg",
                        "/**/*.html",
                        "/**/*.css",
                        "/**/*.js")
                .permitAll()
                .antMatchers(SecurityConstant.SIGNUP_URLS).permitAll()
                .antMatchers(SecurityConstant.SIGNIN_URLS).permitAll()
                // .antMatchers("/api/users/**").permitAll()
                // .antMatchers(SecurityConstant.H2_URL).permitAll()
                .anyRequest().authenticated()
                .and()
                .authenticationManager(authenticationManager)
                .authenticationProvider(authenticationProvider);

        http.addFilterBefore(jwtAuthenticationFilter(), CustomUsernamePasswordAuthenticationFilter.class);
        return http.build();
    }
}
