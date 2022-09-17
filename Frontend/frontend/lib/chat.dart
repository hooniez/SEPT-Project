import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'dart:convert';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ChatPage());
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  ChatPageState createState() {
    return ChatPageState();
  }
}

void onConnect(StompFrame frame) {
  print("connected");
}

class ChatPageState extends State<ChatPage> {
  TextEditingController textEdit = TextEditingController();
  StompClient client = StompClient(
      config: StompConfig.SockJS(
    url: 'http://localhost:8080/ws',
    onConnect: onConnect,
    onWebSocketError: (dynamic error) => print(error.toString()),
  ));

  List<String> messageList = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    client.activate();
    client.send(
        destination: '/app/hello', body: "You're a big cunt <3", headers: {});
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat!"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(
                child: TextFormField(
                  decoration:
                      const InputDecoration(labelText: "enter a message"),
                  controller: textEdit,
                ),
              ),
              StreamBuilder(
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                  );
                },
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => {}),
        child: const Icon(Icons.send),
      ),
    );
  }
}
