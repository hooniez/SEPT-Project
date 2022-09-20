package com.sept_group6.symptom.controllers;

import com.sept_group6.symptom.dao.SymptomRepository;
import com.sept_group6.symptom.model.Symptom;
import com.sept_group6.symptom.exception.*;
import org.springframework.transaction.TransactionSystemException;
import javax.validation.ConstraintViolationException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.*;

@RestController
@RequestMapping()
public class SymptomController {
    @Autowired
    private SymptomRepository symptomRepository;

    @GetMapping("/getsymptom")
    public ResponseEntity<?> getSymptom(@RequestParam("email") String email) {
        try {
            List<Symptom> symptom = symptomRepository.findAllByEmail(email);
            return ResponseEntity.accepted().body(symptom);
        }catch (ConstraintViolationException e) {
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

    @DeleteMapping("/deletesymptom")
    public void deleteSymptom(@RequestParam("id") int id) {
        try {
            if(symptomRepository.existsById(id)) {
                symptomRepository.deleteById(id);
            }
            else {
                throw new UserNotFoundException("There is no sypmtom with this id.");
            }
        } catch (UserNotFoundException e) {
            ResponseEntity.badRequest().body(e.getMessage());
        } catch (ConstraintViolationException e) {
            String errorMessage = "";
            for (var error : e.getConstraintViolations()) {
                errorMessage += error.getMessage() + "\n";
            }
            ResponseEntity.badRequest().body(errorMessage);
        } catch (TransactionSystemException e) {
            ConstraintViolationException causeException = (ConstraintViolationException) GetRootException
                    .getRootException(e);
            String errorMessage = "";
            for (var error : causeException.getConstraintViolations()) {
                errorMessage += error.getMessage() + "\n";
            }
            ResponseEntity.badRequest().body(errorMessage);
        }
    }

    @PutMapping(path = "/addsymptom", consumes="application/json", produces = "application/json")
    public ResponseEntity<?> addSymptom(@RequestBody Symptom newSymptom) {
        try {
            Symptom symptom = symptomRepository.save(newSymptom);
            return ResponseEntity.accepted().body(symptom);
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

