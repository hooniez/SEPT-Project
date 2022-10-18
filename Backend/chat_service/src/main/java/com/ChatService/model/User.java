package com.ChatService.model;

import lombok.AllArgsConstructor;
import lombok.experimental.SuperBuilder;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.LocalDate;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

@MappedSuperclass
@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long uid;
    @Email(message = "Email must be valid")
    @NotBlank(message = "Email is required")
    // uniqueness when adding new row needs to be checked in contronller
    @Column(unique = true)
    private String email;
    private String firstname;
    private String lastname;

    private String dob;
    @NotBlank(message = "Password is required")
    private String password;
    private String mobilenumber;

    // public String toString() {
    // return " email= " + email + " firstName= " + firstname + " lastName= " +
    // lastname +
    // " dob= " + dob + " password= " + password + " mobileNumber= " + mobilenumber;
    // }

}
