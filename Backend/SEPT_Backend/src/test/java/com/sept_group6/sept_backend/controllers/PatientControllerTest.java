package com.sept_group6.sept_backend.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sept_group6.sept_backend.dao.PatientRepository;
import com.sept_group6.sept_backend.model.Patient;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import java.util.Optional;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
@WebMvcTest(controllers = PatientController.class)
public class PatientControllerTest {

    private static final Logger logger = LogManager.getLogger("Test");
    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockBean
    private PatientRepository patientRepository;

    Patient patient = new Patient("johndoe@gmail.com", "John", "Doe", "01" +
            "/01/1990", "1234", "0498582854", "None");

    @Test
    void loginPatient_returns200_IfLoggedIn() throws Exception {
        Mockito.when(patientRepository.findByEmailAndPassword("johndoe@gmail" +
                ".com", "1234")).thenReturn(Optional.of(patient));

        MockHttpServletRequestBuilder mockRequest =
                MockMvcRequestBuilders.get(
                                "/patient/signin").
                        contentType(MediaType.APPLICATION_JSON)
                        .param("email", patient.getEmail())
                        .param("password",
                                patient.getPassword());

        mockMvc.perform(mockRequest)
                .andExpect(status().isOk());
    }

    @Test
    void addPatient_returns200_IfRegistered() throws Exception {


        Mockito.when(patientRepository.save(patient)).thenReturn(patient);

        MockHttpServletRequestBuilder mockRequest =
                MockMvcRequestBuilders.post(
                                "/patient/signup").
                        contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(patient));

        mockMvc.perform(mockRequest)
                .andExpect(status().isOk());
    }

}
