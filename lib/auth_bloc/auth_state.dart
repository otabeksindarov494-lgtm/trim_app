import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserExtension on User {
  String get id => uid;
}

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthOtpSent extends AuthState {
  final String phone;

  const AuthOtpSent(this.phone);

  @override
  List<Object?> get props => [phone];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
