package com.ChatService;

import java.security.Principal;
import java.util.Map;
import java.util.UUID;

import com.ChatService.model.UserPrincipal;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.DefaultHandshakeHandler;

public class UserHandshakeHandler extends DefaultHandshakeHandler {

    @Override
    protected Principal determineUser(
        ServerHttpRequest request,
        WebSocketHandler wsHandler,
        Map<String, Object> attributes
    ) {
        return new UserPrincipal(UUID.randomUUID().toString());
    }
}
