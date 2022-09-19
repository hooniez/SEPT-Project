import 'dart:convert';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

void onConnect(StompFrame frame) {
  print("connected");
  print("now subscribing");
  client.subscribe(destination: '/topic/greetings', callback: onSubMessage);
  client.send(
      destination: '/app/hello',
      body: '{"from": "me", "text": "Hello world"}',
      headers: {});
  client.send(
      destination: '/app/hello',
      body: '{"from": "me", "text": "this is me"}',
      headers: {});
}

void onSubMessage(StompFrame frame) {
  print(frame.body);
}

final StompClient client = StompClient(
    config: StompConfig.SockJS(
  url: 'http://localhost:8080/ws',
  onConnect: onConnect,
  onWebSocketError: (dynamic error) => print(error.toString()),
));

void main() async {
  client.activate();
}
