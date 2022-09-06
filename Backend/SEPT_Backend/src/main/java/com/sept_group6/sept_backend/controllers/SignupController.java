package com.sept_group6.sept_backend.controllers;

import java.net.URI;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import org.springframework.web.bind.annotation.CrossOrigin;

import com.sept_group6.sept_backend.dao.PatientRepository;
import com.sept_group6.sept_backend.model.Patient;

/*TODO: turn this resfful */
@RestController
@RequestMapping(path = "/signup")
public class SignupController {

        private static final Logger logger = LogManager.getLogger("Backend");

        @Autowired
        private PatientRepository patientRepository;

        // /* not need for signup at the moment */
        // @GetMapping(path = "", produces = "application/json")
        // public Users getUsers() {
        // logger.info("signup - get");
        // return new Users();
        // }

        @PutMapping(path = "", consumes = "application/json", produces = "application/json")
        public ResponseEntity<Object> addUser(
                        @RequestHeader(name = "X-COM-PERSIST", required = false) String headerPersist,
                        @RequestHeader(name = "X-COM-LOCATION", required = false, defaultValue = "AUS") String headerLocation,
                        @RequestBody Patient newPatient)
                        throws Exception {
                logger.info("signup - put");
                // Generate resource id
                Integer id = userDao.getNumOfUsers() + 1;
                logger.info(id);
                user.setId(id);

                // add resource
                userDao.addUser(user);
                logger.info(userDao.getNumOfUsers());

                // create resource location
                URI location = ServletUriComponentsBuilder.fromCurrentRequest()
                                .path("/{id}")
                                .buildAndExpand(user.getId())
                                .toUri();

                // // Send location in response
                return ResponseEntity.created(location).build();
        }
}
