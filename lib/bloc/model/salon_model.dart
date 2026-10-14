

class SalonModel {
  final String id;
  final String name;
  final String address;
  final double distance;
  final double rating;
  final String image;
  final double? latitude;
  final double? longitude;

  SalonModel({
    this.id = '',
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
    required this.image,
    this.latitude,
    this.longitude,
  });

  factory SalonModel.fromJson(Map<String, dynamic> json) {
    return SalonModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? json['title']?.toString() ?? '',
      address: json['address']?.toString() ?? json['podcastCount']?.toString() ?? '',
      distance: double.tryParse(json['distance']?.toString() ?? '0') ?? 0,
      rating: double.tryParse(json['rating']?.toString() ?? '4.8') ?? 4.8,
      image: json['image']?.toString() ?? '',
      latitude: json['latitude'] != null ? double.tryParse(json['latitude'].toString()) : null,
      longitude: json['longitude'] != null ? double.tryParse(json['longitude'].toString()) : null,
    );
  }
}