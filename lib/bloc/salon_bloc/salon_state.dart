import 'package:equatable/equatable.dart';
import 'package:trim_app/bloc/model/subscription_model.dart';

import '../model/salon_model.dart';

abstract class SalonState extends Equatable{
  SalonState();

  @override
  List<Object?> get props => [];
}

class SalonInitial extends SalonState {}

class SalonLoading extends SalonState {}

class SalonLoaded extends SalonState {
  final List<Subscriptions> salons;

  SalonLoaded(this.salons);

  @override
  List<Object?> get props => [salons];
}

class SalonError extends SalonState {
  final String message;

  SalonError(this.message);

  @override
  List<Object?> get props => [message];
}