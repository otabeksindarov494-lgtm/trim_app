import 'package:trim_app/bloc/model/salon_model.dart';
import 'package:trim_app/bloc/model/subscription_model.dart';
import '../../service/api_service.dart';
import '../../service/salon_service.dart';

class SalonRepository {
  final SalonService _service;

  SalonRepository({SalonService? service})
  : _service = service ?? SalonService();

  Future<List<Subscriptions>> fetchSalons() async {
    return _service.getSalons();
  }
}