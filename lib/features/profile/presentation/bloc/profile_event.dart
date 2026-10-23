import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  final String profileId;

  const LoadProfile({required this.profileId});

  @override
  List<Object?> get props => [profileId];
}

class UpdateProfile extends ProfileEvent {
  final String profileId;
  final String name;
  final String nickName;
  final String birthday;
  final String email;
  final String phone;
  final String? gender;

  const UpdateProfile({
    required this.profileId,
    required this.name,
    required this.nickName,
    required this.birthday,
    required this.email,
    required this.phone,
    this.gender,
  });

  @override
  List<Object?> get props =>
      [profileId, name, nickName, birthday, email, phone, gender];
}
