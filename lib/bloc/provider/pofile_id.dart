

import 'package:shared_preferences/shared_preferences.dart';
import 'package:trim_app/bloc/provider/repository/profile_repository.dart';
import 'package:uuid/uuid.dart';

Future<String> getOrCreateProfileId() async {
  final prefs = await SharedPreferences.getInstance();
  String? id = prefs.getString('profile_id');
  if (id == null) {
    id = const Uuid().v4();
    await prefs.setString('profile_id', id);
  }
  return id;
}