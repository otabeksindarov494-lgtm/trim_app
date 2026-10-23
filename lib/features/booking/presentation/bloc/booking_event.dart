import 'package:equatable/equatable.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class BookingSubmitted extends BookingEvent {
  final String salonId;
  final String? masterId;
  final String? serviceId;
  final DateTime bookingDate;
  final String bookingTime;

  const BookingSubmitted({
    required this.salonId,
    this.masterId,
    this.serviceId,
    required this.bookingDate,
    required this.bookingTime,
  });

  @override
  List<Object?> get props =>
      [salonId, masterId, serviceId, bookingDate, bookingTime];
}
