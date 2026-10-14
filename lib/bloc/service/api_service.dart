import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trim_app/bloc/model/profile_model.dart';

class ApiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ProfileModel> getProfile(String profileId) async {
    final doc = await _firestore.collection('profiles').doc(profileId).get();
    if (!doc.exists || doc.data() == null) {
      throw Exception('Profile topilmadi');
    }
    final data = doc.data()!;
    data['id'] = doc.id;
    return ProfileModel.fromJson(data);
  }

  Future<void> createProfile({
    required String profileId,
    required String email,
  }) async {
    await _firestore.collection('profiles').doc(profileId).set({
      'id': profileId,
      'email': email,
    }, SetOptions(merge: true));
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

    await _firestore.collection('profiles').doc(profileId).set(data, SetOptions(merge: true));
  }

  Future<List<Map<String, dynamic>>> getSalons() async {
    final snapshot = await _firestore.collection('salons').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }
}
