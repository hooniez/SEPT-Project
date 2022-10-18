import 'package:flutter/material.dart';
import 'package:frontend/message.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'urls.dart';

// void main() {
//   runApp(const ChatApp());
// }

// class ChatApp extends StatelessWidget {
//   const ChatApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(home: ChatPage());
//   }
// }

class ChatPage extends StatefulWidget {
  final String sender;
  final String receiver;
  const ChatPage({Key? key, required this.sender, required this.receiver})
      : super(key: key);

  @override
  ChatPageState createState() {
    return ChatPageState();
  }
}

final List<String> strings = <String>[];

class ChatPageState extends State<ChatPage> {
  TextEditingController textEdit = TextEditingController();
  late StompClient client;
  List<Message> messages = <Message>[];

  @override
  void initState() {
    super.initState();
    client = StompClient(
        config: StompConfig.SockJS(
      url: 'http://$api:$chat_port/ws',
      onConnect: onConnect,
      onWebSocketError: (dynamic error) => print(error.toString()),
    ));
    client.activate();
  }

  void onConnect(StompFrame frame) {
    print("connected");
    // client.subscribe(destination: '/user/max/queue/msg', callback: onMessage);
    // client.subscribe(destination: '/topic/chat', callback: onMessageTopic);
    client.subscribe(
        destination: '/topic/chat/' + widget.sender, callback: onMessageTopic);
    client.send(destination: '/app/register', body: widget.sender, headers: {});
    print("subscribed and registered");
  }

  void onMessageTopic(StompFrame frame) {
    print(frame.body);
    String json = '${frame.body}';
    Message m = Message.fromJson(jsonDecode(json));
    if (m.from != widget.sender) {
      setState(() {
        messages.add(m);
      });
    }
  }

  void onPrivateMessage(StompFrame frame) {
    print("message");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat!"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: GroupedListView<Message, DateTime>(
                      reverse: true,
                      order: GroupedListOrder.DESC,
                      padding: const EdgeInsets.all(8),
                      elements: messages,
                      groupBy: (message) => DateTime(
                            message.date.year,
                            message.date.month,
                            message.date.day,
                          ),
                      groupHeaderBuilder: (Message message) => SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                DateFormat.yMMMd().format(message.date),
                              ),
                            ),
                          ),
                      itemBuilder: (context, Message message) => Align(
                            alignment: (message.from == widget.sender)
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Card(
                              elevation: 8,
                              color: (message.from == widget.sender)
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  message.text,
                                  style: (message.from == widget.sender)
                                      ? const TextStyle(color: Colors.white)
                                      : const TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ))),
              Form(
                child: TextFormField(
                  decoration:
                      const InputDecoration(labelText: "enter a message"),
                  controller: textEdit,
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: addItemToList,
        child: const Icon(Icons.send),
      ),
    );
  }

  void addItemToList() {
    if (textEdit.text.isNotEmpty) {
      Message message = Message(widget.sender, widget.receiver, textEdit.text);
      setState(() {
        messages.add(message);
      });

      client.send(
          destination: '/app/message',
          body: '{"to": "${message.to}", "text": "${message.text}"}',
          headers: {});

      textEdit.text = '';
    }
  }
}
