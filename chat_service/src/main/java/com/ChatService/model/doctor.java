package com.ChatService.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor

public class doctor {
    @Id
    private String email;
    private String firstname;
    private String lastname;
    private String dob;
    private String password;
    private String mobilenumber;
    private String certificate;
}


