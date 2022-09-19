package com.sept_group6.appointment_server.controllers;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hamcrest.Matchers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.sept_group6.appointment_server.dao.*;
import com.sept_group6.appointment_server.model.*;

import java.util.Optional;
import java.util.List;
import java.util.stream.Collectors;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.LocalTime;

// for unit test
import org.mockito.Mockito;
import org.springframework.test.web.servlet.MockMvc;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.http.MediaType;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(controllers = AppointmentController.class)
@ExtendWith(SpringExtension.class)
public class AppointmentControllerTest {
        private static final Logger logger = LogManager.getLogger("Test");
        @Autowired
        private MockMvc mockMvc;

        // @Autowired
        // private ObjectMapper objectMapper;

        @MockBean
        private AppointmentRepository AppointmentRepository;
        // @MockBean
        // private AppointmentRepository PatientRepository;
        // @MockBean
        // private AppointmentRepository DoctorRepository;
        Patient patient = new Patient(1L, "JamesSmith@gmail.com", "James", "Smit", "01/01/1981", "1234", "0452013654",
                        "None.");
        Doctor doctor = new Doctor(1L, "Johndoe@gmail.com", "John", "Doe", "01/01/1990", "1234", "0498582854", "None");
        Appointment appointment = new Appointment((Integer) 1, patient, doctor, LocalTime.parse("12:00:00"),
                        LocalTime.parse("13:00:00"),
                        LocalDate.parse("01/01/2022", DateTimeFormatter.ofPattern("MM/dd/yyyy")),
                        true);

        @Test
        void testgetAppointment_returnsAppointmentList() throws Exception {
                Mockito.when(AppointmentRepository.findByPatientEmail(patient.getEmail()))
                                .thenReturn(Optional.of(List.of(appointment)));

                MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.get(
                                "/appointment/").contentType(MediaType.APPLICATION_JSON)
                                .param("email", patient.getEmail())
                                .param("usertype", "patient");

                mockMvc.perform(mockRequest)
                                .andExpect(status().isAccepted())
                                .andExpect(jsonPath("$", Matchers.hasSize(1)))
                                .andExpect(
                                                jsonPath("$[0].doctorName", Matchers.is(
                                                                doctor.getFirstname() + " " + doctor.getLastname())));
        }

}
