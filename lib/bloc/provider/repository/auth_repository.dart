import '../../service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository({AuthService? authService})
      : _authService = authService ?? AuthService();

  Future<User> registerWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await _authService.signUpWithEmail(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user == null) {
      throw Exception('Ro\'yxatdan o\'tishda xatolik yuz berdi');
    }
    return user;
  }

  Future<User> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await _authService.signInWithEmail(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user == null) {
      throw Exception('Kirishda xatolik yuz berdi');
    }
    return user;
  }

  Future<void> requestPhoneOtp(String phone) async {
    await _authService.sendOtpToPhone(phone);
  }

  Future<User> confirmPhoneOtp({
    required String phone,
    required String otp,
  }) async {
    final response = await _authService.verifyPhoneOtp(
      phone: phone,
      otp: otp,
    );

    final user = response.user;
    if (user == null) {
      throw Exception('Kod noto\'g\'ri yoki muddati o\'tgan');
    }
    return user;
  }

  Future<void> signOut() => _authService.signOut();
}