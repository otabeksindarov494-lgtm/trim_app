

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trim_app/bloc/model/message_model.dart';

class MessageService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String> getOrCreateConversation(String salonId) async {
    final userId = _supabase.auth.currentUser!.id;

    final existing = await _supabase
    .from('conversations')
    .select()
    .eq('user_id', userId)
    .eq('salon_id', salonId)
    .maybeSingle();

    if(existing != null) {
      return existing['id'];
    }
    final created = await _supabase
    .from('conversations')
    .insert({'user_id': userId, 'salon_id': salonId})
    .select()
    .single();

    return created['id'];
  }

  Stream<List<Message>> watchMessages(String conversationId) {
    return _supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('conversation_id', conversationId)
        .order('created_at')
        .map((row) => row.map((e) => Message.fromJson(e)).toList());
  }
  Future<void> sendMessage({
    required String conversationId,
    required String message,
}) async {
    final userId = _supabase.auth.currentUser!.id;

    await _supabase.from('messages').insert({
      'conversation_id': conversationId,
      'sender_id': userId,
      'message': message,
    });
  }
}