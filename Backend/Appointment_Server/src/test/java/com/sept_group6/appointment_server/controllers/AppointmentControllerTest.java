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
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;

@WebMvcTest(controllers = AppointmentController.class)
@ExtendWith(SpringExtension.class)
public class AppointmentControllerTest {
        private static final Logger logger = LogManager.getLogger("Test");
        @Autowired
        private MockMvc mockMvc;

        // @Autowired
        // private ObjectMapper objectMapper;

        @MockBean
        private AppointmentRepository appointmentRepository;
        @MockBean
        private PatientRepository patientRepository;
        @MockBean
        private DoctorRepository doctorRepository;
        Patient patient = new Patient(1L, "JamesSmith@gmail.com", "James",
                        "Smit", "01/01/1981", "1234", "0452013654",
                        "None.");
        Doctor doctor = new Doctor(1L, "JohnDoe@gmail.com", "John",
                        "Doe", "01/01/1990", "1234", "0498582854", "None");
        Doctor anotherDoctor = new Doctor(2L, "JohnyArk@gmail.com", "Johny",
                        "Ark", "01/01/1990", "1234", "0498582854", "None");
        Appointment bookedAppointment = new Appointment(1L, patient, doctor, LocalTime.parse("12:00:00"),
                        LocalTime.parse("13:00:00"),
                        LocalDate.parse("01/01/2022", DateTimeFormatter.ofPattern("MM/dd/yyyy")),
                        true);
        Appointment unbookedAppointment = new Appointment(2L, null, doctor, LocalTime.parse("12:00:00"),
                        LocalTime.parse("13:00:00"),
                        LocalDate.parse("01/01/2022", DateTimeFormatter.ofPattern("MM/dd/yyyy")),
                        false);
        Appointment anotherUnbookedAppointment = new Appointment(3L, null, anotherDoctor, LocalTime.parse("12:00:00"),
                        LocalTime.parse("13:00:00"),
                        LocalDate.parse("01/01/2022", DateTimeFormatter.ofPattern("MM/dd/yyyy")),
                        false);
        Optional<List<Appointment>> appointments = Optional
                        .of(List.of(bookedAppointment, unbookedAppointment, anotherUnbookedAppointment));

        @Test
        void testGetAppointment_returnsBookedAppointment() throws Exception {
                Mockito.when(appointmentRepository.findByPatientEmail(patient.getEmail()))
                                .thenReturn(appointments);

                MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.get(
                                "/appointment/").contentType(MediaType.APPLICATION_JSON)
                                .param("email", patient.getEmail())
                                .param("usertype", "patient");

                mockMvc.perform(mockRequest)
                                .andExpect(status().isAccepted())
                                .andExpect(jsonPath("$", Matchers.hasSize(3)));
        }

        @Test
        void testGetUnbookedAppointment_returnsAppointmentList() throws Exception {
                Mockito.when(appointmentRepository.findByAppointmentbooked(false))
                                .thenReturn(Optional.of(appointments.get().stream()
                                                .filter(appointment -> !appointment.isAppointmentbooked())
                                                .collect(Collectors.toList())));

                MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.get(
                                "/appointment/all");

                mockMvc.perform(mockRequest)
                                .andExpect(status().isAccepted())
                                .andExpect(jsonPath("$", Matchers.hasSize(2)));
        }

        @Test
        void testMakeAppointment_returnsBookedAppointment() throws Exception {
                Mockito.when(appointmentRepository.findById(anotherUnbookedAppointment.getId()))
                                .thenReturn(Optional.of(anotherUnbookedAppointment));
                Mockito.when(patientRepository.findByEmail(patient.getEmail()))
                                .thenReturn(patient);
                Mockito.when(appointmentRepository.save(anotherUnbookedAppointment))
                                .thenReturn(anotherUnbookedAppointment);

                String json = "{\"id\":3, \"patientName\":\"JamesSmith@gmail.com\"}";
                MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.put(
                                "/appointment").contentType(MediaType.APPLICATION_JSON)
                                .content(json);

                mockMvc.perform(mockRequest)
                                .andExpect(status().isAccepted())
                                .andExpect(jsonPath("$.doctorName", Matchers.is(
                                                anotherDoctor.getFirstname() + " " + anotherDoctor.getLastname())));

        }

        // @Test
        // void testMakeAppointment_returnsUnbookedAppointment() throws Exception {
        // Mockito.when(doctorRepository.findByEmail(doctor.getEmail()))
        // .thenReturn(doctor);
        // Mockito.when(appointmentRepository.save(newAppointment))
        // .thenReturn(unbookedAppointment);

        // String json = "{\"date\":\"2022-03-26\",
        // \"starttime\":\"08:25\",\"endtime\":\"08:55\",
        // \"doctorName\":\"JohnDoe@gmail.com\"}";
        // MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.put(
        // "/appointment/").contentType(MediaType.APPLICATION_JSON)
        // .content(json);

        // mockMvc.perform(mockRequest)
        // .andExpect(status().isAccepted())
        // .andExpect(jsonPath("$", Matchers.hasSize(1)))
        // .andExpect(jsonPath("$.doctorName", Matchers.is(
        // doctor.getFirstname() + " " + doctor.getLastname())))
        // .andExpect(jsonPath("$[0].appointmentBooked", Matchers.is(false)));
        // ;
        // }

}
