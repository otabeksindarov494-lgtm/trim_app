

class Booking {
  final String id;
  final String salonId;
  final String? masterId;
  final String? serviceId;
  final DateTime bookingDate;
  final String bookingTime;
  final String status;

  Booking({
    required this.id,
    required this.salonId,
    this.masterId,
    this.serviceId,
    required this.bookingDate,
    required this.bookingTime,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      salonId: json['salon_id'],
      masterId: json['master_id'],
      serviceId: json['service_id'],
      bookingDate: DateTime.parse(json['booking_date']),
      bookingTime: json['booking_time'],
      status: json['status'],
    );
  }
}