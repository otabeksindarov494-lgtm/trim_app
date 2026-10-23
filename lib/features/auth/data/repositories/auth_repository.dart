import 'package:firebase_auth/firebase_auth.dart';
import 'package:trim_app/core/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository({AuthService? authService})
      : _authService = authService ?? AuthService();

  Future<User> registerWithEmail({
    required String email,
    required String password,
  }) async {
    final credential = await _authService.signUpWithEmail(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('Ro\'yxatdan o\'tishda xatolik yuz berdi');
    }
    return user;
  }

  Future<User> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final credential = await _authService.signInWithEmail(
      email: email,
      password: password,
    );

    final user = credential.user;
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
    final user = _authService.currentUser;
    if (user == null) {
      throw Exception('Kod noto\'g\'ri yoki muddati o\'tgan');
    }
    return user;
  }

  Future<void> signOut() => _authService.signOut();
}
