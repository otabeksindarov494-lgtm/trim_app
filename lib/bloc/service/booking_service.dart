import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/booking_model.dart';

class BookingService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Booking> createBooking({
    required String userId,
    required String salonId,
    String? masterId,
    String? serviceId,
    required DateTime bookingDate,
    required String bookingTime,
  }) async {
    final response = await _supabase.from('bookings').insert({
      'user_id': userId,
      'salon_id': salonId,
      'master_id': masterId,
      'service_id': serviceId,
      'booking_date': bookingDate.toIso8601String().split('T').first,
      'booking_time': bookingTime,
      'status': 'pending',
    }).select().single();

    return Booking.fromJson(response);
  }
}