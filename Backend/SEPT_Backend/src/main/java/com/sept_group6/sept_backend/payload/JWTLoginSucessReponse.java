package com.sept_group6.sept_backend.payload;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class JWTLoginSucessReponse {
    private boolean success;
    private String token;

}