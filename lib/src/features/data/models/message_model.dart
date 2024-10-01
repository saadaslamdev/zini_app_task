class Message {
  final String id;
  final String message;
  final String from;
  final DateTime time;

  Message({required this.id, required this.message, required this.from, required this.time});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'],
      message: json['message'],
      from: json['from'],
      time: DateTime.parse(json['time']),
    );
  }
}
