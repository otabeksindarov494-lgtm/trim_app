
class Subscriptions {
  final String id;          // <- shu kerak
  final String image;
  final String title;
  final String podcastCount;
  bool isEnabled;

  Subscriptions({
    required this.id,
    required this.image,
    required this.title,
    required this.podcastCount,
    this.isEnabled = false,
  });

  factory Subscriptions.fromJson(Map<String, dynamic> json) {
    return Subscriptions(
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      podcastCount: json['address'] ?? '',
    );
  }
}
