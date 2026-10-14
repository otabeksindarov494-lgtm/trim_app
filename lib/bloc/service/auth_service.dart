import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Email orqali ro'yxatdan o'tish
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Email orqali kirish
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Telefon raqamga OTP (bir martalik kod) yuborish
  Future<void> sendOtpToPhone(
    String phone, {
    PhoneVerificationCompleted? verificationCompleted,
    PhoneVerificationFailed? verificationFailed,
    PhoneCodeSent? codeSent,
    PhoneCodeAutoRetrievalTimeout? codeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: verificationCompleted ?? (PhoneAuthCredential c) {},
      verificationFailed: verificationFailed ?? (FirebaseAuthException e) {},
      codeSent: codeSent ?? (String id, int? token) {},
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout ?? (String id) {},
    );
  }

  // Foydalanuvchi kiritgan OTP kodni tekshirish
  Future<UserCredential> verifyPhoneOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    return await _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
