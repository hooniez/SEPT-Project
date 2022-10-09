// package com.sept_group6.appointment_server.controllers;

// import org.apache.logging.log4j.LogManager;
// import org.apache.logging.log4j.Logger;
// import org.aspectj.lang.annotation.Before;
// import org.hamcrest.Matchers;
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.http.ResponseEntity;
// import org.springframework.security.test.context.support.WithMockUser;
// import org.springframework.security.test.context.support.WithSecurityContext;
// import org.springframework.web.bind.annotation.*;
// import org.springframework.web.context.WebApplicationContext;

// import com.sept_group6.appointment_server.dao.*;
// import com.sept_group6.appointment_server.model.*;

// import java.util.Optional;
// import java.util.List;
// import java.util.stream.Collectors;
// import java.lang.annotation.Retention;
// import java.lang.annotation.RetentionPolicy;
// import java.time.LocalDate;
// import java.time.format.DateTimeFormatter;
// import java.time.LocalTime;

// // for unit test
// import org.mockito.Mockito;
// import org.springframework.test.web.servlet.MockMvc;
// import com.fasterxml.jackson.databind.ObjectMapper;

// import
// org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
// import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
// import org.springframework.boot.test.context.SpringBootTest;
// import org.springframework.boot.test.mock.mockito.MockBean;
// import org.mockito.ArgumentMatchers;
// import org.springframework.test.context.ContextConfiguration;
// import org.springframework.test.context.junit.jupiter.SpringExtension;
// import org.springframework.test.context.web.WebAppConfiguration;
// import org.junit.jupiter.api.BeforeAll;
// import org.junit.jupiter.api.BeforeEach;
// import org.junit.jupiter.api.Test;
// import org.junit.jupiter.api.extension.ExtendWith;
// import
// org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
// import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
// import org.springframework.test.web.servlet.setup.MockMvcBuilders;
// import org.springframework.http.MediaType;
// import static
// org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
// import static
// org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
// import static
// org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
// import static org.mockito.ArgumentMatchers.any;
// import static
// org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;

// // security
// import org.springframework.mock.web.MockHttpSession;
// import com.sept_group6.appointment_server.security.CustomAuthenticationToken;

// import org.springframework.security.core.Authentication;
// import org.springframework.security.core.context.SecurityContext;
// import org.springframework.security.core.context.SecurityContextHolder;
// import
// org.springframework.security.web.context.HttpSessionSecurityContextRepository;

// // @WebMvcTest(controllers = AppointmentController.class)
// @ExtendWith(SpringExtension.class)
// // @ContextConfiguration(locations = { "classpath:/test/BeanConfig.xml" })
// @WebAppConfiguration
// @SpringBootTest
// @WithMockCustomUser(userType = "patient")
// // @AutoConfigureMockMvc(addFilters = false)
// public class AppointmentControllerTest {
// private static final Logger logger = LogManager.getLogger("Test");

// @Autowired
// private WebApplicationContext context;

// // @Autowired
// private MockMvc mockMvc;

// @BeforeEach
// public void setup() {
// mockMvc = MockMvcBuilders
// .webAppContextSetup(context)
// .apply(springSecurity())
// .build();
// }

// // @BeforeEach
// // public void setup() {
// // mockMvc = MockMvcBuilders
// // .webAppContextSetup(context)
// // .apply(springSecurity())
// // .build();
// // }

// // @Autowired
// // private ObjectMapper objectMapper;

// // @Autowired
// // private WebApplicationContext context;

// @MockBean
// private AppointmentRepository appointmentRepository;
// @MockBean
// private PatientRepository patientRepository;

// Patient patient = new Patient(1L, "JamesSmith@gmail.com", "James",
// "Smit", "01/01/1981", "1234", "0452013654",
// "None.");
// Doctor doctor = new Doctor(1L, "JohnDoe@gmail.com", "John",
// "Doe", "01/01/1990", "1234", "0498582854", "None");
// Doctor anotherDoctor = new Doctor(2L, "JohnyArk@gmail.com", "Johny",
// "Ark", "01/01/1990", "1234", "0498582854", "None");
// Appointment bookedAppointment = new Appointment(1L, patient, doctor,
// LocalTime.parse("12:00:00"),
// LocalTime.parse("13:00:00"),
// LocalDate.parse("01/01/2022", DateTimeFormatter.ofPattern("MM/dd/yyyy")),
// true);
// Appointment unbookedAppointment = new Appointment(2L, null, doctor,
// LocalTime.parse("12:00:00"),
// LocalTime.parse("13:00:00"),
// LocalDate.parse("01/01/2022", DateTimeFormatter.ofPattern("MM/dd/yyyy")),
// false);
// Appointment anotherUnbookedAppointment = new Appointment(3L, null,
// anotherDoctor, LocalTime.parse("12:00:00"),
// LocalTime.parse("13:00:00"),
// LocalDate.parse("01/01/2022", DateTimeFormatter.ofPattern("MM/dd/yyyy")),
// false);
// Optional<List<Appointment>> appointments = Optional
// .of(List.of(bookedAppointment, unbookedAppointment,
// anotherUnbookedAppointment));

// // public static class MockSecurityContext implements SecurityContext {
// // private static final long serialVersionUID = -1386535243513362694L;

// // private Authentication authentication;

// // public MockSecurityContext(Authentication authentication) {
// // this.authentication = authentication;
// // }

// // @Override
// // public Authentication getAuthentication() {
// // return this.authentication;
// // }

// // @Override
// // public void setAuthentication(Authentication authentication) {
// // this.authentication = authentication;
// // }
// // }
// @Autowired
// WebApplicationContext wac;

// @Test
// @WithMockCustomUser
// void testGetAppointment_returnsAllRelatedAppointment() throws Exception {
// // mockMvc = MockMvcBuilders.webAppContextSetup(wac)
// // .apply(springSecurity())
// // .build();
// // // CustomAuthenticationToken authentication =
// Mockito.mock(CustomAuthenticationToken.class);
// // // MockHttpSession session = new MockHttpSession();
// // // session.setAttribute(
// // // HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY,
// // // new MockSecurityContext(authentication));
// // CustomAuthenticationToken authentication =
// Mockito.mock(CustomAuthenticationToken.class);
// // SecurityContext securityContext = Mockito.mock(SecurityContext.class);
// //
// Mockito.when(securityContext.getAuthentication()).thenReturn(authentication);
// //
// Mockito.when(securityContext.getAuthentication().getPrincipal()).thenReturn("principal");
// // SecurityContextHolder.setContext(securityContext);
// // this.mockMvc = MockMvcBuilders.webAppContextSetup(this.context).build();
// //
// when(SecurityContextHolder.getContext().getAuthentication().getDetails()).thenReturn(mockSimpleUserObject);
// // Mockito.when(authentication.getName()).thenReturn("doctor.getEmail()");
// // Mockito.when(authentication.getUserType()).thenReturn("doctor");
// Mockito.when(appointmentRepository.findByDoctorEmail(doctor.getEmail()))
// .thenReturn(Optional.of(appointments.get().stream()
// .filter(appointment ->
// appointment.getDoctor().getEmail().equals(doctor.getEmail()))
// .collect(Collectors.toList())));
// MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.get(
// "/appointment/").contentType(MediaType.APPLICATION_JSON);

// mockMvc.perform(mockRequest)
// // .with(user(authentication.getPrincipal()))
// .andExpect(status().isAccepted())
// .andExpect(jsonPath("$", Matchers.hasSize(2)));
// }

// @Test
// void testGetUnbookedAppointment_returnsAppointmentList() throws Exception {
// Mockito.when(appointmentRepository.findByAppointmentbooked(false))
// .thenReturn(Optional.of(appointments.get().stream()
// .filter(appointment -> !appointment.isAppointmentbooked())
// .collect(Collectors.toList())));

// MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.get(
// "/appointment");

// mockMvc.perform(mockRequest)
// .andExpect(status().isAccepted())
// .andExpect(jsonPath("$", Matchers.hasSize(2)));
// }

// // @Test
// // void testMakeAppointment_returnsBookedAppointment() throws Exception {
// //
// Mockito.when(appointmentRepository.findById(anotherUnbookedAppointment.getId()))
// // .thenReturn(Optional.of(anotherUnbookedAppointment));
// // Mockito.when(patientRepository.findByEmail(patient.getEmail()))
// // .thenReturn(patient);
// // Mockito.when(appointmentRepository.save(anotherUnbookedAppointment))
// // .thenReturn(anotherUnbookedAppointment);

// // String json = "{\"id\":3, \"patientName\":\"JamesSmith@gmail.com\"}";
// // MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.put(
// // "/appointment").contentType(MediaType.APPLICATION_JSON)
// // .content(json);

// // mockMvc.perform(mockRequest)
// // .andExpect(status().isAccepted())
// // .andExpect(jsonPath("$.doctorName", Matchers.is(
// // anotherDoctor.getFirstname() + " " + anotherDoctor.getLastname())));

// }

// // @Test
// // void testMakeAppointment_returnsUnbookedAppointment() throws Exception {
// // Mockito.when(doctorRepository.findByEmail(doctor.getEmail()))
// // .thenReturn(doctor);
// //
// Mockito.when(appointmentRepository.save(any(Appointment.class))).thenReturn(unbookedAppointment);

// // String json =
// //
// "{\"date\":\"2022-03-26\",\"starttime\":\"08:25\",\"endtime\":\"08:55\",\"doctorName\":\"JohnDoe@gmail.com\"}";
// // MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.put(
// // "/appointment/").contentType(MediaType.APPLICATION_JSON)
// // .content(json);

// // mockMvc.perform(mockRequest)
// // .andExpect(status().isAccepted())
// // .andExpect(jsonPath("$.doctorName", Matchers.is(
// // doctor.getFirstname() + " " + doctor.getLastname())));
// // ;
// // }
