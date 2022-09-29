class Message {
  String to;
  String text;
  String from;
  late DateTime date;

  Message(this.from, this.to, this.text) {
    date = DateTime.now();
  }

  Map toJson() => {
        'to': to,
        'text': text,
      };

  factory Message.fromJson(dynamic json) {
    return Message(
        json['from'] as String, json['to'] as String, json['text'] as String);
  }
}
