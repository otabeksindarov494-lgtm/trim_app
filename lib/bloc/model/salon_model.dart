

class SalonModel {
  final String name;
  final String address;
  final double distance;
  final double rating;
  final String image;

  SalonModel({
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
    required this.image,
  });

  factory SalonModel.fromJson(Map<String, dynamic> json) {
    return SalonModel(
      name: json['name']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      distance: double.tryParse(
        json['distance']?.toString() ?? '0',
      ) ??
          0,

      rating: double.tryParse(
        json['rating']?.toString() ?? '0',
      ) ??
          0,

      image: json['image']?.toString() ?? '',
    );
  }
}