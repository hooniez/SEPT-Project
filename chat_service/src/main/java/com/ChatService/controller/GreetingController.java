package com.ChatService.controller;

import org.springframework.stereotype.Controller;

import java.security.Principal;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;

import com.ChatService.model.Message;

@Controller
public class GreetingController {
    @MessageMapping("/hello")
    @SendTo("/topic/greetings")
    public Message greeting(Message message, Principal principal) throws Exception {
        System.out.print("got a message from: ");
        System.out.println(principal.getName());
        System.out.println(message.getText());
        Thread.sleep(1000); // simulated delay
        return new Message("us", "hello!");
    }
  
}
