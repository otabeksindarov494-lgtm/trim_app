import 'package:trim_app/features/booking/data/models/booking_model.dart';
import 'package:trim_app/core/services/booking_service.dart';

class BookingRepository {
  final BookingService _service;

  BookingRepository({BookingService? service})
      : _service = service ?? BookingService();

  Future<Booking> book({
    required String userId,
    required String salonId,
    String? masterId,
    String? serviceId,
    required DateTime bookingDate,
    required String bookingTime,
  }) async {
    return await _service.createBooking(
      userId: userId,
      salonId: salonId,
      masterId: masterId,
      serviceId: serviceId,
      bookingDate: bookingDate,
      bookingTime: bookingTime,
    );
  }
}
