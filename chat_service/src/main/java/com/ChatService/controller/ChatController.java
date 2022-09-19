package com.ChatService.controller;

import org.springframework.stereotype.Controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.context.event.EventListener;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;
import org.springframework.web.socket.messaging.SessionConnectEvent;
import com.ChatService.model.Message;
import com.ChatService.model.Connection;

@Controller
public class ChatController {

    private ArrayList<Connection> connections = new ArrayList<Connection>();

    @MessageMapping("/register")
    public Message greeting(Message message, Principal principal) throws Exception {
        System.out.println(principal.getName());
        Thread.sleep(1000); // simulated delay
        return new Message("us", "registered");
    }

    @EventListener
    public void onDisconnect(SessionDisconnectEvent event) {
        String session = event.getUser().getName();

        for (Connection con : connections) {
            if (con.getSessionId() == session) {
                connections.remove(con);
                break;
            }
        }
        System.out.print("user disconnected: ");
        System.out.println(session);
    }

    @EventListener
    public void onConnect(SessionConnectEvent event) {
        connections.add(new Connection(event.getUser().getName()));

        System.out.print("user connected: ");
        System.out.println(event.getUser().getName());
    }
}