import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trim_app/bloc/model/profile_model.dart';
class ApiService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<ProfileModel> getProfile(String profileId) async {
    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', profileId)
        .maybeSingle();

    return ProfileModel.fromJson(response!);
  }
  Future<void> createProfile({
    required String profileId,
    required String email,
  }) async {
    await _supabase.from('profiles').insert({
      'id': profileId,
      'email': email,
    });
  }

  Future<void> updateProfile({
    required String profileId,
    required String name,
    required String nickName,
    required String birthday,
    required String email,
    required String phone,
    String? gender,
  }) async {
    final data = <String, dynamic>{
      'name': name,
      'nickName': nickName,
      'email': email,
      'phone': phone,
    };

    if (birthday.isNotEmpty) data['birthday'] = birthday;
    if (gender != null) data['gender'] = gender;

    await _supabase.from('profiles').update(data).eq('id', profileId);
  }
  Future<List<Map<String, dynamic>>> getSalons() async {
    final response = await _supabase
        .from('salon')
        .select();

    return List<Map<String, dynamic>>.from(response);
  }
}