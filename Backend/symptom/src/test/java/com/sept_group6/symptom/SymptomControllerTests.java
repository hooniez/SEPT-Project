package com.sept_group6.symptom;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hamcrest.Matchers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.sept_group6.symptom.dao.*;
import com.sept_group6.symptom.model.*;
import com.sept_group6.symptom.controllers.*;

import java.util.*;

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

@WebMvcTest(controllers = SymptomController.class)
class ProfileControllerTests {

    @Autowired
    private MockMvc mockMvc;
    @Autowired
    private ObjectMapper objectMapper;
    @MockBean
    private SymptomRepository patientRepository;

    @Test
    public void testGetSymptomsAccepted() throws Exception {
        String emailToUse = "lachlanvdk55@gmail.com";
        Symptom symptom1 = new Symptom(1, emailToUse, "Headache");
        Symptom symptom2 = new Symptom(2, emailToUse, "Sore Throat");
        List<Symptom> symptomList = new ArrayList<Symptom>();
        symptomList.add(symptom1);
        symptomList.add(symptom2);

        Mockito.when(patientRepository.findAllByEmail("lachlanvdk55@gmail.com")).thenReturn(symptomList);
        MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.get(
                                "/getsymptom").contentType(MediaType.APPLICATION_JSON)
                                .param("email", emailToUse);

                mockMvc.perform(mockRequest)
                                .andExpect(status().isAccepted())
                                .andExpect(jsonPath("$", Matchers.hasSize(2)));
    }

    @Test
    public void testAddSymptomsAccepted() throws Exception {
        Symptom symptom1 = new Symptom(1, "knockoz55@gmail.com", "Bleeding Badly");
    }

    @Test
    public void testDeleteSymptomsAccepted() throws Exception {

    }

}