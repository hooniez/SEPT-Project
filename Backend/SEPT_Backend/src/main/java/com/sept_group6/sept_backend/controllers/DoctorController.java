package com.sept_group6.sept_backend.controllers;

import com.sept_group6.sept_backend.dao.DoctorRepository;
import com.sept_group6.sept_backend.model.Doctor;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

// security
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import com.sept_group6.sept_backend.payload.LoginRequest;
import com.sept_group6.sept_backend.security.JwtTokenProvider;
import com.sept_group6.sept_backend.security.CustomAuthenticationToken;
import com.sept_group6.sept_backend.payload.JWTLoginSucessReponse;
import static com.sept_group6.sept_backend.security.SecurityConstant.TOKEN_PREFIX;

// exception handling
import com.sept_group6.sept_backend.exception.EmailAlreadyExistsException;
import com.sept_group6.sept_backend.exception.GetRootException;
import com.sept_group6.sept_backend.exception.WrongUserTypeException;

import org.springframework.transaction.TransactionSystemException;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;

@RestController
@RequestMapping(path = "/doctor")
public class DoctorController {
    private static final Logger logger = LogManager.getLogger("Backend");

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private JwtTokenProvider tokenProvider;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @PostMapping("/signin")
    public ResponseEntity<?> loginUser(@Valid @RequestBody LoginRequest loginRequest) {

        try {
            String userType = loginRequest.getUserType();
            if (!userType.equals("doctor")) {
                throw new WrongUserTypeException("User type must be patient!");
            }

            // throws exception if authentication doesn't pass
            Authentication authentication = authenticationManager.authenticate(
                    new CustomAuthenticationToken(
                            loginRequest.getEmail(),
                            loginRequest.getPassword(),
                            userType)

            );

            SecurityContextHolder.getContext().setAuthentication(authentication);
            String jwt = TOKEN_PREFIX + tokenProvider.generateToken(authentication);
            HttpHeaders responseHeaders = new HttpHeaders();
            responseHeaders.set("Authorization", jwt);

            Doctor doctor = doctorRepository.findByEmail(authentication.getName());

            return ResponseEntity.accepted().headers(responseHeaders).body(doctor);
        } catch (WrongUserTypeException | AuthenticationException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
        // String email = loginPatient.getEmail();
        // String password = loginPatient.getPassword();

        // Optional<Doctor> doctor = doctorRepository.findByEmailAndPassword(email,
        // password);

        // if (doctor.isPresent()) {
        // return ResponseEntity.accepted().body(doctor.get());
        // } else {
        // return ResponseEntity.badRequest().build();
        // }
    }

    @PostMapping(path = "/signup", consumes = "application/json", produces = "application/json")
    public ResponseEntity<?> addUser(@RequestBody Doctor newDoctor)
            throws Exception {
        logger.info(newDoctor);
        try {
            // add resource
            if (doctorRepository.existsByEmail(newDoctor.getEmail())) {
                throw new EmailAlreadyExistsException("Email already exists.");
            }
            newDoctor.setPassword(bCryptPasswordEncoder.encode(newDoctor.getPassword()));
            Doctor doctor = doctorRepository.save(newDoctor);

            return ResponseEntity.accepted().body(doctor);
        } catch (EmailAlreadyExistsException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (ConstraintViolationException e) {
            String errorMessage = "";
            for (var error : e.getConstraintViolations()) {
                errorMessage += error.getMessage() + "\n";
            }
            return ResponseEntity.badRequest().body(errorMessage);
        } catch (TransactionSystemException e) {
            ConstraintViolationException causeException = (ConstraintViolationException) GetRootException
                    .getRootException(e);
            String errorMessage = "";
            for (var error : causeException.getConstraintViolations()) {
                errorMessage += error.getMessage() + "\n";
            }
            return ResponseEntity.badRequest().body(errorMessage);
        }

    }
}
