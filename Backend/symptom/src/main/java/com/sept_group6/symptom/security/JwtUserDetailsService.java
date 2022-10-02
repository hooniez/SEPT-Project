package com.sept_group6.symptom.security;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import com.sept_group6.symptom.dao.PatientRepository;
import com.sept_group6.symptom.dao.DoctorRepository;
import com.sept_group6.symptom.dao.UserRepository;
import com.sept_group6.symptom.model.Doctor;
import com.sept_group6.symptom.model.User;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class JwtUserDetailsService implements UserDetailsService {
    private static final Logger logger = LogManager.getLogger("Backend");

    @Autowired
    private PatientRepository patientRepository;
    @Autowired
    private DoctorRepository doctorRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        logger.error("wrong userDetailService");
        new UsernameNotFoundException("User not found");
        return null;
    }

    @Transactional
    public JwtUserDetails loadUserByEmailAndUsertype(String email, String userType) throws UsernameNotFoundException {

        User user;
        if (userType.equals("patient")) {
            user = patientRepository.findByEmail(email).get();
        } else {
            user = doctorRepository.findByEmail(email).get();
        }
        if (user == null)
            new UsernameNotFoundException("User not found");
        return new JwtUserDetails(user.getUid(), user.getEmail(), user.getPassword(), userType);
    }

    @Transactional
    public JwtUserDetails loadUserByIdAndUserType(Long id, String userType) {
        User user;
        if (userType.equals("patient")) {
            user = patientRepository.getById(id);
        } else {
            user = doctorRepository.getById(id);
        }

        if (user == null)
            new UsernameNotFoundException("User not found");
        return new JwtUserDetails(user.getUid(), user.getEmail(), user.getPassword(), userType);
    }
}
