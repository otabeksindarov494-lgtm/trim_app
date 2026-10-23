import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trim_app/features/chat/data/models/message_model.dart';

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getOrCreateConversation(String salonId) async {
    final userId = _auth.currentUser!.uid;

    final existing = await _firestore
        .collection('conversations')
        .where('user_id', isEqualTo: userId)
        .where('salon_id', isEqualTo: salonId)
        .limit(1)
        .get();

    if (existing.docs.isNotEmpty) {
      return existing.docs.first.id;
    }

    final created = await _firestore.collection('conversations').add({
      'user_id': userId,
      'salon_id': salonId,
      'created_at': FieldValue.serverTimestamp(),
    });

    return created.id;
  }

  Stream<List<Message>> watchMessages(String conversationId) {
    return _firestore
        .collection('messages')
        .where('conversation_id', isEqualTo: conversationId)
        .orderBy('created_at')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = Map<String, dynamic>.from(doc.data());
              data['id'] = doc.id;
              if (data['created_at'] is Timestamp) {
                data['created_at'] =
                    (data['created_at'] as Timestamp).toDate().toIso8601String();
              } else if (data['created_at'] == null) {
                data['created_at'] = DateTime.now().toIso8601String();
              }
              return Message.fromJson(data);
            }).toList());
  }

  Future<void> sendMessage({
    required String conversationId,
    required String message,
  }) async {
    final userId = _auth.currentUser!.uid;

    await _firestore.collection('messages').add({
      'conversation_id': conversationId,
      'sender_id': userId,
      'message': message,
      'created_at': FieldValue.serverTimestamp(),
    });
  }
}
