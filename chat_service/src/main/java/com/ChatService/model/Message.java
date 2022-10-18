package com.ChatService.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class Message {

    private String from;
    private String to;
    private String text;

    public Message(String to, String text) {
        this.to = to;
        this.text = text;
    }
}
