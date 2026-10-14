
class Subscriptions {
  final String id;
  final String image;
  final String title;
  final String podcastCount;
  final double rating;
  final double? latitude;
  final double? longitude;
  double? calculatedDistance;
  bool isEnabled;

  Subscriptions({
    required this.id,
    required this.image,
    required this.title,
    required this.podcastCount,
    this.rating = 4.8,
    this.latitude,
    this.longitude,
    this.calculatedDistance,
    this.isEnabled = false,
  });

  factory Subscriptions.fromJson(Map<String, dynamic> json) {
    return Subscriptions(
      id: json['id']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      title: json['title']?.toString() ?? json['name']?.toString() ?? '',
      podcastCount: json['podcastCount']?.toString() ?? json['address']?.toString() ?? '',
      rating: double.tryParse(json['rating']?.toString() ?? '4.8') ?? 4.8,
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : (json['lat'] != null ? double.tryParse(json['lat'].toString()) : null),
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : (json['lng'] != null ? double.tryParse(json['lng'].toString()) : null),
      isEnabled: json['isEnabled'] == true || json['isFavorite'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'address': podcastCount,
      'podcastCount': podcastCount,
      'rating': rating,
      'latitude': latitude,
      'longitude': longitude,
      'isEnabled': isEnabled,
    };
  }

  Subscriptions copyWith({
    String? id,
    String? image,
    String? title,
    String? podcastCount,
    double? rating,
    double? latitude,
    double? longitude,
    double? calculatedDistance,
    bool? isEnabled,
  }) {
    return Subscriptions(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      podcastCount: podcastCount ?? this.podcastCount,
      rating: rating ?? this.rating,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      calculatedDistance: calculatedDistance ?? this.calculatedDistance,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
