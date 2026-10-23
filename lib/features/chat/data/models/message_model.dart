class Message {
  final String id;
  final String conversationId;
  final String senderId;
  final String message;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.message,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      conversationId: json['conversation_id'],
      senderId: json['sender_id'],
      message: json['message'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
