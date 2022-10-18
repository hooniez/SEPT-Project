package com.ChatService.model;

import java.security.Principal;

public class UserPrincipal implements Principal {
    String name;

    public UserPrincipal(String name) {
        this.name = name;
    }

    @Override
    public String getName() {
        return name;
    }
}