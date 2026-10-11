import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/provider/repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc({required AuthRepository repository})
      : _repository = repository,
        super(AuthInitial()) {
    on<EmailSignUpRequested>(_onEmailSignUpRequested);
    on<EmailSignInRequested>(_onEmailSignInRequested);
    on<PhoneOtpRequested>(_onPhoneOtpRequested);
    on<PhoneOtpVerified>(_onPhoneOtpVerified);
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onEmailSignUpRequested(
      EmailSignUpRequested event,
      Emitter<AuthState> emit,
      ) async {
    print('1. Event keldi: ${event.email}');
    emit(AuthLoading());
    print('2. Loading emit qilindi');
    emit(AuthLoading());
    try {
      final user = await _repository.registerWithEmail(
        email: event.email,
        password: event.password,
      );
      print('3. User keldi: ${user.id}');
      emit(AuthSuccess(user));
      print('4. Success emit qilindi');
    } catch (e) {
      print('XATOLIK: $e');
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onEmailSignInRequested(
      EmailSignInRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      final user = await _repository.loginWithEmail(
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onPhoneOtpRequested(
      PhoneOtpRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      await _repository.requestPhoneOtp(event.phone);
      emit(AuthOtpSent(event.phone));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onPhoneOtpVerified(
      PhoneOtpVerified event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      final user = await _repository.confirmPhoneOtp(
        phone: event.phone,
        otp: event.otp,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event,
      Emitter<AuthState> emit,
      ) async {
    await _repository.signOut();
    emit(AuthInitial());
  }
}