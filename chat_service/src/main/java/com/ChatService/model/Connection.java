package com.ChatService.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class Connection {
    private String username;
    private String sessionId;

    public Connection(String sessionId) {
        this.sessionId = sessionId;
    }
}
