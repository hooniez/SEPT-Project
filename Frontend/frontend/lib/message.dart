class Message {
  final String to;
  final String text;
  final String from;

  Message(this.from, this.to, this.text);

  Map toJson() => {
        'to': to,
        'text': text,
      };

  factory Message.fromJson(dynamic json) {
    return Message(
        json['from'] as String, json['to'] as String, json['text'] as String);
  }
}
