import 'package:trim_app/features/chat/data/models/message_model.dart';
import 'package:trim_app/core/services/message_service.dart';

class MessageRepository {
  final MessageService _service;

  MessageRepository({MessageService? service})
    : _service = service ?? MessageService();

  Future<String> createConversation(String salonId) {
    return _service.getOrCreateConversation(salonId);
  }

  Stream<List<Message>> watchMessages(String conversationId) {
    return _service.watchMessages(conversationId);
  }

  Future<void> sendMessage({
    required String conversationId,
    required String message,
  }) {
    return _service.sendMessage(
      conversationId: conversationId,
      message: message,
    );
  }
}
