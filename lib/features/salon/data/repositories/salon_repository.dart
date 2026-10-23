import 'package:trim_app/features/salon/data/models/subscription_model.dart';
import 'package:trim_app/core/services/salon_service.dart';

class SalonRepository {
  final SalonService _service;

  SalonRepository({SalonService? service})
      : _service = service ?? SalonService();

  Future<List<Subscriptions>> fetchSalons() async {
    return _service.getSalons();
  }

  Stream<List<Subscriptions>> watchSalons() {
    return _service.getSalonsStream();
  }

  Future<void> toggleFavorite(String salonId, bool currentStatus) async {
    return _service.toggleFavorite(salonId, currentStatus);
  }
}
