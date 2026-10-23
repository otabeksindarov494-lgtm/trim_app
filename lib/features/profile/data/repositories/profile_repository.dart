import 'package:trim_app/features/profile/data/models/profile_model.dart';
import 'package:trim_app/core/services/api_service.dart';

class ProfileRepository {
  final ApiService _service;

  ProfileRepository({ApiService? service})
      : _service = service ?? ApiService();

  Future<ProfileModel> fetchProfile(String profileId) {
    return _service.getProfile(profileId);
  }

  Future<void> saveProfile({
    required String profileId,
    required String name,
    required String nickName,
    required String birthday,
    required String email,
    required String phone,
    String? gender,
  }) async {
    if (name.trim().isEmpty) {
      throw Exception('Ismni kiriting');
    }

    await _service.updateProfile(
      profileId: profileId,
      name: name,
      nickName: nickName,
      birthday: birthday,
      email: email,
      phone: phone,
      gender: gender,
    );
  }
  Future<void> createProfile({
    required String profileId,
    required String email,
  }) async {
    await _service.createProfile(
      profileId: profileId,
      email: email,
    );
  }
}
