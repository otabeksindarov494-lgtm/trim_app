
import 'package:equatable/equatable.dart';

abstract class SalonEvent extends Equatable {
  const SalonEvent();

  @override
  List<Object?> get props => [];
}

class SalonsRequested extends SalonEvent {}
