package com.sept_group6.symptom;

//import org.hamcrest.Matchers;
import org.springframework.beans.factory.annotation.Autowired;

import com.sept_group6.symptom.dao.*;
import com.sept_group6.symptom.model.*;
import com.sept_group6.symptom.controllers.*;

import java.util.*;

// for unit test
import org.mockito.Mockito;
import org.springframework.test.web.servlet.MockMvc;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.http.MediaType;
//import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(controllers = SymptomController.class)
class SymptomControllerTests {

    @Autowired
    private MockMvc mockMvc;
    @Autowired
    private ObjectMapper objectMapper;
    @MockBean
    private SymptomRepository symptomRepository;

    @Test
    public void testGetSymptomsAccepted() throws Exception {
        String emailToUse = "lachlanvdk55@gmail.com";
        Symptom symptom1 = new Symptom(1, emailToUse, "Headache");
        Symptom symptom2 = new Symptom(2, emailToUse, "Sore Throat");
        List<Symptom> symptomList = new ArrayList<Symptom>();
        symptomList.add(symptom1);
        symptomList.add(symptom2);

        Mockito.when(symptomRepository.findAllByEmail("lachlanvdk55@gmail.com")).thenReturn(symptomList);
        MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.get(
                                "/getsymptom").contentType(MediaType.APPLICATION_JSON)
                                .param("email", emailToUse);

                mockMvc.perform(mockRequest)
                                .andExpect(status().isAccepted());
    }

    // @Test
    public void testDeleteSymptomsAccepted() throws Exception {
        int idToUse = 1;
        Symptom symptom1 = new Symptom(idToUse, "lachlanvdk55@gmail.com", "Headache");

        Mockito.when(symptomRepository.deleteById(idToUse).doNothing());
        MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.delete(
                                "/deletesymptom").contentType(MediaType.APPLICATION_JSON)
                                .param("id", idToUse);

                mockMvc.perform(mockRequest)
                                .andExpect(status().isAccepted());
    }

    @Test
    public void testAddSymptomsAccepted() throws Exception {
        Symptom symptom1 = new Symptom(1, "lachlanvdk55@gmail.com", "Headache");

        Mockito.when(symptomRepository.save(symptom1)).thenReturn(symptom1);
        MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.put(
                                "/addsymptom").contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(symptom1));
        
                mockMvc.perform(mockRequest)
                                .andExpect(status().isAccepted());
    }
}