class ProfileModel {
  final String id;
  final String name;
  final String nickName;
  final String birthday;
  final String email;
  final String phone;
  final String? gender;

  ProfileModel({
    required this.id,
    required this.name,
    required this.nickName,
    required this.birthday,
    required this.email,
    required this.phone,
    this.gender,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      nickName: json['nickName'] ?? '',
      birthday: json['birthday'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      gender: json['gender'],
    );
  }
}
