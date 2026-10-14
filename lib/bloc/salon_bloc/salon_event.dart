
import 'package:equatable/equatable.dart';

abstract class SalonEvent extends Equatable {
  const SalonEvent();

  @override
  List<Object?> get props => [];
}

class SalonsRequested extends SalonEvent {}

class ToggleFavoriteRequested extends SalonEvent {
  final String salonId;
  final bool currentStatus;

  const ToggleFavoriteRequested({required this.salonId, required this.currentStatus});

  @override
  List<Object?> get props => [salonId, currentStatus];
}
