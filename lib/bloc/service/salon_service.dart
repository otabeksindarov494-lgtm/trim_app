

import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trim_app/bloc/model/subscription_model.dart';

class SalonService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Subscriptions>> getSalons() async {
    final response = await _supabase.from('salons').select();

    return (response as List)
    .map((json) => Subscriptions.fromJson(json))
    .toList();
  }
}