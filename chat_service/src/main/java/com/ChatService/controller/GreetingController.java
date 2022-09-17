package com.ChatService.controller;

import org.springframework.stereotype.Controller;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;

import com.ChatService.model.Message;

@Controller
public class GreetingController {
    @MessageMapping("/hello")
    @SendTo("/topic/greetings")
    public Message greeting(Message message) throws Exception {
        System.out.println("got a message!");
        System.out.println(message.getText());
        Thread.sleep(1000); // simulated delay
        return new Message("us", "hello!");
    }
  
}
