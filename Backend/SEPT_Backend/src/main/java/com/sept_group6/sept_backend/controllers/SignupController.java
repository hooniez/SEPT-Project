package com.sept_group6.sept_backend.controllers;

import java.net.URI;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.sept_group6.sept_backend.dao.UserDAO;
import com.sept_group6.sept_backend.model.Users;
import com.sept_group6.sept_backend.model.User;

/*TODO: turn this resfful */
@RestController
@RequestMapping(path = "/signup")
public class SignupController {

    private static final Logger logger = LogManager.getLogger("Backend");

    @Autowired
    private UserDAO userDao;

    /* not need for signup at the moment */
    // @GetMapping(path = "", produces = "application/json")
    // public Users getUsers() {
    // return new Users();
    // }

    @PostMapping(path = "", consumes = "application/json", produces = "application/json")
    public ResponseEntity<Object> addUser(
            @RequestHeader(name = "X-COM-PERSIST", required = false) String headerPersist,
            @RequestHeader(name = "X-COM-LOCATION", required = false, defaultValue = "AUS") String headerLocation,
            @RequestBody User user)
            throws Exception {
        logger.info("signup");
        // Generate resource id
        Integer id = userDao.getNumOfUsers() + 1;
        user.setId(id);

        // add resource
        userDao.addUser(user);
        logger.info(userDao.getNumOfUsers());

        // Create resource location
        URI location = ServletUriComponentsBuilder.fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(user.getId())
                .toUri();

        // Send location in response
        return ResponseEntity.created(location).build();
    }
}
