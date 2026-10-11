import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Email orqali ro'yxatdan o'tish
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  // Email orqali kirish
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Telefon raqamga OTP (bir martalik kod) yuborish
  Future<void> sendOtpToPhone(String phone) async {
    await _supabase.auth.signInWithOtp(phone: phone);
  }

  // Foydalanuvchi kiritgan OTP kodni tekshirish
  Future<AuthResponse> verifyPhoneOtp({
    required String phone,
    required String otp,
  }) async {
    return await _supabase.auth.verifyOTP(
      type: OtpType.sms,
      phone: phone,
      token: otp,
    );
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  User? get currentUser => _supabase.auth.currentUser;

  get user => null;
}