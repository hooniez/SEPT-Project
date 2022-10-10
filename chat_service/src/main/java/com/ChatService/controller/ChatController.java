package com.ChatService.controller;

import org.springframework.stereotype.Controller;

import java.security.Principal;
import java.util.ArrayList;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.user.SimpUserRegistry;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;
import org.springframework.web.socket.messaging.SessionConnectEvent;
import com.ChatService.model.Message;
import com.ChatService.model.Connection;

@Controller
public class ChatController {

    @Autowired
    private SimpMessagingTemplate template;
    @Autowired
    private SimpUserRegistry userRegistry;

    private ArrayList<Connection> connections = new ArrayList<Connection>();

    @MessageMapping("/message")
    public void greeting(Message message, Principal principal) throws Exception {
        System.out.print("Message from: ");
        System.out.println(principal.getName());
        System.out.println(message.getText());

        for (Connection con : connections) {
            if (con.getSessionId().equals(principal.getName())) {
                message.setFrom(con.getUsername());
            }
        }

        for (Connection con : connections) {
            if (con.getUsername().equals(message.getTo())) {
                System.out.print(con.getUsername());
                System.out.println(" found! Now sending message back");
                System.out.println("topic/chat/" + con.getUsername());
                template.convertAndSend("/topic/chat/" + con.getUsername(), message);
                System.out.println("message sent to user");
            }
        }
        
        System.out.println("sent!");
    }

    @MessageMapping("/register")
    public void register(String userName, Principal principal) throws Exception {
        for (Connection con : connections) {
            if (con.getSessionId().equals(principal.getName())) {
                con.setUsername(userName);
                System.out.print(userName);
                System.out.print(" registered to: ");
                System.out.println(principal.getName());
                System.out.println(userRegistry.getUsers());
                return;
            }
        }

        System.out.println("could not register");
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