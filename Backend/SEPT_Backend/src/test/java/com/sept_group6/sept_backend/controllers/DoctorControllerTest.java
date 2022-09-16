package com.sept_group6.sept_backend.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sept_group6.sept_backend.dao.DoctorRepository;
import com.sept_group6.sept_backend.model.Doctor;
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
@WebMvcTest(controllers = DoctorController.class)
@ExtendWith(SpringExtension.class)
public class DoctorControllerTest {

    private static final Logger logger = LogManager.getLogger("Test");
    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockBean
    private DoctorRepository doctorRepository;

    Doctor doctor = new Doctor("johndoe@gmail.com", "John", "Doe", "01" +
            "/01/1990", "1234", "0498582854", "None");

    @Test
    void loginDoctor_returns200_IfLoggedIn() throws Exception {
        Mockito.when(doctorRepository.findByEmailAndPassword("johndoe@gmail" +
                ".com", "1234")).thenReturn(Optional.of(doctor));

        MockHttpServletRequestBuilder mockRequest =
                MockMvcRequestBuilders.get(
                                "/doctor/signin").
                        contentType(MediaType.APPLICATION_JSON)
                                .param("email", doctor.getEmail())
                                        .param("password",
                                                doctor.getPassword());

        mockMvc.perform(mockRequest)
                .andExpect(status().isOk());
    }
    @Test
    void addDoctor_returns200_IfRegistered() throws Exception {


        Mockito.when(doctorRepository.save(doctor)).thenReturn(doctor);

        MockHttpServletRequestBuilder mockRequest =
                MockMvcRequestBuilders.post(
                                "/doctor/signup").
                        contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(doctor));

        mockMvc.perform(mockRequest)
                .andExpect(status().isOk());

    }
}
