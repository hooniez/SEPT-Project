package com.sept_group6.profile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sept_group6.profile.controllers.DoctorProfileController;
import com.sept_group6.profile.dao.DoctorRepository;
import com.sept_group6.profile.model.Doctor;
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
// import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.Optional;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(controllers = DoctorProfileController.class)
@AutoConfigureMockMvc(addFilters = false)
class DoctorProfileControllerTests {

        @Autowired
        private MockMvc mockMvc;
        @Autowired
        private ObjectMapper objectMapper;
        @MockBean
        private DoctorRepository doctorRepository;

        // @MockBean
        // private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Test
    public void testUpdateDoctorAccepted() throws Exception {
        Doctor doctor1 = new Doctor(1L,"doc@docdoc.doc", "doc",
                "l", "2002-02-02", "doc", "0000",
                "history here");

        Mockito.when(doctorRepository.findByEmail("doc@docdoc.doc")).thenReturn(Optional.of(doctor1));
        Mockito.when(doctorRepository.save(doctor1)).thenReturn(doctor1);
        MockHttpServletRequestBuilder mockRequest =
                MockMvcRequestBuilders.put(
                                "/doctor/profile").
                        contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(doctor1));
        mockMvc.perform(mockRequest)
                .andExpect(status().isAccepted());
    }

        @Test
        public void testUpdateDoctorBadRequest() throws Exception {
            Doctor doctor1 = new Doctor(1L,"doc@docdoc.doc", "doc",
                    "l", "2002-02-02", "doc", "0000", "history");
            Doctor doctor2 = null;
            Mockito.when(doctorRepository.findByEmail("doc@docdoc.doc")).thenReturn(Optional.empty());
            Mockito.when(doctorRepository.save(doctor1)).thenReturn(doctor1);
            MockHttpServletRequestBuilder mockRequest =
                    MockMvcRequestBuilders.put(
                                    "/doctor/profile").
                            contentType(MediaType.APPLICATION_JSON)
                            .content(objectMapper.writeValueAsString(doctor1));
            mockMvc.perform(mockRequest)
                    .andExpect(status().isBadRequest());
        }

}