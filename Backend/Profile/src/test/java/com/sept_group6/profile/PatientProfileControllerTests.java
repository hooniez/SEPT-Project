package com.sept_group6.profile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sept_group6.profile.controllers.PatientProfileController;
import com.sept_group6.profile.dao.PatientRepository;
import com.sept_group6.profile.model.Doctor;
import com.sept_group6.profile.model.Patient;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import java.util.Optional;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@WebMvcTest(controllers = PatientProfileController.class)
@AutoConfigureMockMvc(addFilters = false)
class PatientProfileControllerTests {

        @Autowired
        private MockMvc mockMvc;
        @Autowired
        private ObjectMapper objectMapper;
        @MockBean
        private PatientRepository patientRepository;
        @MockBean
        private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Test
    public void testUpdatePatientAccepted() throws Exception {
        Patient patient1 = new Patient(1L,"cal@calcal.cal", "cal",
                "l", "2002-02-02", "cal", "0000",
                "history here");

        Mockito.when(patientRepository.findByEmail("cal@calcal.cal")).thenReturn(Optional.of(patient1));
        Mockito.when(patientRepository.save(patient1)).thenReturn(patient1);
        Mockito.when(patientRepository.existsByEmail("cal@calcal.cal")).thenReturn(true);
        MockHttpServletRequestBuilder mockRequest =
                MockMvcRequestBuilders.put(
                                "/patient/profile").
                        contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(patient1));
        mockMvc.perform(mockRequest)
                .andExpect(status().isAccepted());
    }

        @Test
        public void testUpdatePatientBadRequest() throws Exception {
            Patient patient1 = new Patient(1L,"cal@calcal.cal", "cal",
                    "l", "2002-02-02", "cal", "0000",
                    "history here");
            Patient patient2 = null;
            Mockito.when(patientRepository.findByEmail("cal@calcal.cal")).thenReturn(Optional.empty());
            Mockito.when(patientRepository.save(patient1)).thenReturn(patient1);
            MockHttpServletRequestBuilder mockRequest =
                    MockMvcRequestBuilders.put(
                                    "/patient/profile").
                            contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(patient1));
            mockMvc.perform(mockRequest)
                    .andExpect(status().isBadRequest());
        }

    @Test
    public void testGetPatientAccepted() throws Exception {
        long patientId = 1;
        Patient patient1 = new Patient(1,"cal@calcal.cal", "cal",
                "l", "2002-02-02", "cal", "0000",
                "history here");
        Mockito.when(patientRepository.findById(patientId)).thenReturn(Optional.of(patient1));
        MockHttpServletRequestBuilder mockRequest =
                MockMvcRequestBuilders.get(
                                "/patient/profile/1").
                        contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(patient1));
        mockMvc.perform(mockRequest)
                .andExpect(status().isOk());
    }

}