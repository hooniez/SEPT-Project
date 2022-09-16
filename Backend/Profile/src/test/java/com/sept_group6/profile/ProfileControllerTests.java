    package com.sept_group6.profile;

    import com.sept_group6.profile.controllers.PatientProfileController;
    import com.sept_group6.profile.dao.PatientRepository;
    import com.sept_group6.profile.model.Patient;
    import org.junit.Before;
    import org.junit.Test;
    import org.junit.jupiter.api.BeforeEach;
    import org.junit.runner.RunWith;
    import org.mockito.Mock;
    import org.mockito.Mockito;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
    import org.springframework.boot.test.context.SpringBootTest;
    import org.springframework.boot.test.mock.mockito.MockBean;
    import org.springframework.test.context.junit4.SpringRunner;
    import org.springframework.test.web.servlet.MockMvc;
    import org.springframework.util.Assert;

    import java.util.Optional;

    import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
    import static org.mockito.AdditionalAnswers.returnsFirstArg;
    import static org.mockito.Mockito.*;
    import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

    //@RunWith(SpringRunner.class)
    @WebMvcTest(PatientProfileController.class)
    @SpringBootTest
    public class ProfileControllerTests {

        @Autowired
        private MockMvc mockMvc;

        @Mock
        private PatientRepository patientRepository;

        PatientProfileController controller;

        @Test
        public void testUpdatePatient() throws Exception {

            Patient patient1 = new Patient("cal@calcal.cal","cal","l","2002-02-02","cal","0000","history here");

            Mockito.when(patientRepository.findByEmail("cal@calcal.cal")).then(returnsFirstArg());

            assertThat(controller.updateInfo(patient1)).isNotNull();

        }
    }

    //    @Autowired
    //    PatientProfileController patientController;
    //    @MockBean
    //    private PatientRepository patientRepository;
    //
    //    Patient patient1;
    //    String patientEmail;
    //
    //    @Before
    //    public void setUp() {
    //        patient1 = new Patient();
    //        patientEmail = "patient1@testpatient.com";
    //        patient1.setEmail(patientEmail);
    //        Mockito.when(patientRepository.findByEmail(patient1.getEmail()))
    //                .thenReturn(patient1);
    //    }
    //
    //    @Test
    //    public void profileUpDateTest() {
    //        Patient patientReturn = patientRepository.findByEmail(patient1.getEmail());
    //        Assert.isTrue(patientReturn.getEmail().equals(patientEmail));
    //    }