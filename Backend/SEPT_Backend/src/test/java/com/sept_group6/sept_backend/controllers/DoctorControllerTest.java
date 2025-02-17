package com.sept_group6.sept_backend.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sept_group6.sept_backend.dao.DoctorRepository;
import com.sept_group6.sept_backend.model.Doctor;
import com.sept_group6.sept_backend.payload.LoginRequest;
import com.sept_group6.sept_backend.security.CustomAuthenticationToken;
import com.sept_group6.sept_backend.security.JwtTokenProvider;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import java.util.Optional;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.mockito.ArgumentMatchers.any;

// security
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;

@WebMvcTest(controllers = DoctorController.class)
@ExtendWith(SpringExtension.class)
@AutoConfigureMockMvc(addFilters = false)
public class DoctorControllerTest {

        private static final Logger logger = LogManager.getLogger("Test");
        @Autowired
        private MockMvc mockMvc;

        @Autowired
        private ObjectMapper objectMapper;

        @MockBean
        private DoctorRepository doctorRepository;

        @MockBean
        private JwtTokenProvider tokenProvider;

        @MockBean
        private BCryptPasswordEncoder bCryptPasswordEncoder;

        @MockBean
        private AuthenticationManager authenticationManager;

        LoginRequest loginRequest = new LoginRequest("111@111.com", "12345656775", "doctor");

        @Test
        void loginDoctor_returns200_IfLoggedIn() throws Exception {
                
                Authentication authentication = Mockito.mock(Authentication.class);
                Mockito.when(authenticationManager.authenticate(any(CustomAuthenticationToken.class))).thenReturn(authentication);
               
                MockHttpServletRequestBuilder mockRequest =
                        MockMvcRequestBuilders.post(
                                        "/doctor/signin").
                                contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(loginRequest));

                mockMvc.perform(mockRequest)
                        .andExpect(status().isAccepted());
        }

        @Test
        void logiDoctor_returns400_IfUnSuccessful() throws Exception {                
                AuthenticationException authenticationException = Mockito.mock(AuthenticationException.class);
                Mockito.when(authenticationManager.authenticate(any(CustomAuthenticationToken.class))).thenThrow(authenticationException);

                MockHttpServletRequestBuilder mockRequest =
                        MockMvcRequestBuilders.post(
                                        "/doctor/signin").
                                contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(loginRequest));

                mockMvc.perform(mockRequest)
                        .andExpect(status().isBadRequest());
        }

        @Test
        void addDoctor_returns200_IfRegistered() throws Exception {
                Doctor doctor = new Doctor(1L, "johndoe@gmail.com", "John", "Doe", "01" +
                        "/01/1990", "1234", "0498582854", "None");
                Mockito.when(doctorRepository.existsByEmail(doctor.getEmail())).thenReturn(false);
                Mockito.when(doctorRepository.save(doctor)).thenReturn(doctor);
                MockHttpServletRequestBuilder mockRequest =
                        MockMvcRequestBuilders.post(
                                "/doctor/signup").
                                contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(doctor));
                mockMvc.perform(mockRequest)
                .andExpect(status().isAccepted());
        }
}
