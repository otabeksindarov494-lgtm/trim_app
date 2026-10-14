import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trim_app/bloc/model/subscription_model.dart';

class SalonService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Subscriptions>> getSalons() async {
    final snapshot = await _firestore.collection('salons').get();

    if (snapshot.docs.isEmpty) {
      await _seedDefaultSalons();
      final newSnapshot = await _firestore.collection('salons').get();
      return newSnapshot.docs.map((doc) {
        final data = Map<String, dynamic>.from(doc.data());
        data['id'] = doc.id;
        return Subscriptions.fromJson(data);
      }).toList();
    }

    return snapshot.docs.map((doc) {
      final data = Map<String, dynamic>.from(doc.data());
      data['id'] = doc.id;
      return Subscriptions.fromJson(data);
    }).toList();
  }

  Stream<List<Subscriptions>> getSalonsStream() {
    return _firestore.collection('salons').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = Map<String, dynamic>.from(doc.data());
        data['id'] = doc.id;
        return Subscriptions.fromJson(data);
      }).toList();
    });
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
      {
        'title': 'Beauty Unleashed',
        'address': 'Амир Темур шох кўчаси, 108',
        'podcastCount': 'Амир Темур шох кўчаси, 108',
        'rating': 4.9,
        'image': 'assets/images/img_29.png',
        'latitude': 41.332000,
        'longitude': 69.285000,
        'isEnabled': false,
      },
      {
        'title': 'Fade Factory',
        'address': 'Мирабадская улица, 12',
        'podcastCount': 'Мирабадская улица, 12',
        'rating': 4.8,
        'image': 'assets/images/img_30.png',
        'latitude': 41.295000,
        'longitude': 69.280000,
        'isEnabled': false,
      },
      {
        'title': 'Metamorphosis Salon',
        'address': 'Проспект Алишера Навои, 21',
        'podcastCount': 'Проспект Алишера Навои, 21',
        'rating': 4.6,
        'image': 'assets/images/img_31.png',
        'latitude': 41.318000,
        'longitude': 69.260000,
        'isEnabled': false,
      },
    ];

    for (var salon in defaultSalons) {
      await _firestore.collection('salons').add(salon);
    }
  }
}
