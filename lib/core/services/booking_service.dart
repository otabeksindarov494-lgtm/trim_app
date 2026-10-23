import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trim_app/features/booking/data/models/booking_model.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Booking> createBooking({
    required String userId,
    required String salonId,
    String? masterId,
    String? serviceId,
    required DateTime bookingDate,
    required String bookingTime,
  }) async {
    final data = <String, dynamic>{
      'user_id': userId,
      'salon_id': salonId,
      'master_id': masterId,
      'service_id': serviceId,
      'booking_date': bookingDate.toIso8601String().split('T').first,
      'booking_time': bookingTime,
      'status': 'pending',
      'created_at': FieldValue.serverTimestamp(),
    };

    final docRef = await _firestore.collection('bookings').add(data);
    final docSnapshot = await docRef.get();
    final resultData = Map<String, dynamic>.from(docSnapshot.data() ?? {});
    resultData['id'] = docRef.id;
    if (resultData['booking_date'] == null) {
      resultData['booking_date'] = bookingDate.toIso8601String().split('T').first;
    }

    return Booking.fromJson(resultData);
  }
}
