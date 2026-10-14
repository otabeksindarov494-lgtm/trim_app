import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trim_app/bloc/model/subscription_model.dart';

class SalonService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Subscriptions>> getSalons() async {
    final snapshot = await _firestore.collection('salons').get();

    return snapshot.docs.map((doc) {
      final data = Map<String, dynamic>.from(doc.data());
      data['id'] = doc.id;
      return Subscriptions.fromJson(data);
    }).toList();
  }
}
