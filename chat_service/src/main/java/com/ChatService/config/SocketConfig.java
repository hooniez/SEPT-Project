package com.ChatService.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import com.ChatService.UserHandshakeHandler;

@Configuration
@EnableWebSocketMessageBroker
public class SocketConfig implements WebSocketMessageBrokerConfigurer {
    
    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
      config.enableSimpleBroker("/topic", "/user");
      config.setApplicationDestinationPrefixes("/app");
      config.setUserDestinationPrefix("/user");
    }
  
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
      registry.addEndpoint("/ws")
              .setHandshakeHandler(new UserHandshakeHandler())
              .setAllowedOriginPatterns("*")
              .withSockJS();
    }
}
