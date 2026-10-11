import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class EmailSignUpRequested extends AuthEvent {
  final String email;
  final String password;

  const EmailSignUpRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class EmailSignInRequested extends AuthEvent {
  final String email;
  final String password;

  const EmailSignInRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class PhoneOtpRequested extends AuthEvent {
  final String phone;

  const PhoneOtpRequested(this.phone);

  @override
  List<Object?> get props => [phone];
}

class PhoneOtpVerified extends AuthEvent {
  final String phone;
  final String otp;

  const PhoneOtpVerified({
    required this.phone,
    required this.otp,
  });

  @override
  List<Object?> get props => [phone, otp];
}

class SignOutRequested extends AuthEvent {}