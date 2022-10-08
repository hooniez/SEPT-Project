package com.example.admin.controllers;

import com.example.admin.dao.AdminRepository;
import com.example.admin.model.Admin;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

// exception handling

import org.springframework.transaction.TransactionSystemException;
import javax.validation.ConstraintViolationException;

import java.util.Optional;

@RestController
@RequestMapping(path = "/admin")
public class AdminController {
    private static final Logger logger = LogManager.getLogger("Backend");
    @Autowired
    private AdminRepository adminRepository;

    @PostMapping("/signin")
    public ResponseEntity<?> loginAdmin(@RequestBody Admin loginAdmin) {
        String email = loginAdmin.getEmail();
        String password = loginAdmin.getPassword();

        Optional<Admin> admin = adminRepository.findByEmailAndPassword(email,
                password);

        logger.info("working");

        if (admin.isPresent()) {
            logger.info("working");
            return ResponseEntity.accepted().body(admin.get());
        } else {
            logger.info("working");
            return ResponseEntity.badRequest().build();
        }
    }


}
