package com.ChatService.controller;

import org.springframework.stereotype.Controller;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.util.HtmlUtils;

import com.ChatService.model.Message;

@Controller
public class GreetingController {
    @MessageMapping("/hello")
    @SendTo("/topic/greetings")
    public Message greeting(Message message) throws Exception {
      Thread.sleep(1000); // simulated delay
      return new Message("us", "hello!");
    }
  
}
