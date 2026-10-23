import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trim_app/features/salon/data/models/subscription_model.dart';

class SalonService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const List<String> allowedSalons = ['Uncle Chill', 'Genesis', 'Santander'];

  bool _isAllowed(String? title) {
    if (title == null) return false;
    final lower = title.toLowerCase();
    return allowedSalons.any((a) => a.toLowerCase() == lower);
  }

  Future<List<Subscriptions>> getSalons() async {
    final snapshot = await _firestore.collection('salons').get();

    if (snapshot.docs.isEmpty) {
      await _seedDefaultSalons();
      final newSnapshot = await _firestore.collection('salons').get();
      return _mapAndFilterDocs(newSnapshot.docs);
    }

    for (var doc in snapshot.docs) {
      final title = doc.data()['title']?.toString();
      if (!_isAllowed(title)) {
        await doc.reference.delete();
      }
    }

    final updatedSnapshot = await _firestore.collection('salons').get();
    return _mapAndFilterDocs(updatedSnapshot.docs);
  }

  Stream<List<Subscriptions>> getSalonsStream() {
    return _firestore.collection('salons').snapshots().map((snapshot) {
      return _mapAndFilterDocs(snapshot.docs);
    });
  }

  List<Subscriptions> _mapAndFilterDocs(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    return docs
        .where((doc) => _isAllowed(doc.data()['title']?.toString()))
        .map((doc) {
      final data = Map<String, dynamic>.from(doc.data());
      data['id'] = doc.id;
      return Subscriptions.fromJson(data);
    }).toList();
  }

  Future<void> toggleFavorite(String salonId, bool currentStatus) async {
    if (salonId.isEmpty) return;
    await _firestore.collection('salons').doc(salonId).update({
      'isEnabled': !currentStatus,
    });
  }

  Future<void> _seedDefaultSalons() async {
    final defaultSalons = [
      {
        'title': 'Uncle Chill',
        'address': 'ТЦ Зарафшан, Матбуотчилар, 17',
        'podcastCount': 'ТЦ Зарафшан, Матбуотчилар, 17',
        'rating': 4.8,
        'image': 'assets/images/img_23.png',
        'latitude': 41.311081,
        'longitude': 69.240562,
        'isEnabled': true,
      },
      {
        'title': 'Genesis',
        'address': 'Массив Буюк Ипак Йули, 45а',
        'podcastCount': 'Массив Буюк Ипак Йули, 45а',
        'rating': 4.9,
        'image': 'assets/images/img_27.png',
        'latitude': 41.325500,
        'longitude': 69.328000,
        'isEnabled': true,
      },
      {
        'title': 'Santander',
        'address': 'Улица Фурката, 2а',
        'podcastCount': 'Улица Фурката, 2а',
        'rating': 4.7,
        'image': 'assets/images/img_28.png',
        'latitude': 41.303000,
        'longitude': 69.248000,
        'isEnabled': true,
      },
    ];

    for (var salon in defaultSalons) {
      await _firestore.collection('salons').add(salon);
    }
  }
}
