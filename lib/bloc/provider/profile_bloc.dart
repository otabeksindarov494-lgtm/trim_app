import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim_app/bloc/provider/repository/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;

  ProfileBloc({required ProfileRepository repository})
      : _repository = repository,
        super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
  }

  Future<void> _onLoadProfile(
      LoadProfile event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileLoading());
    try {
      final profile = await _repository.fetchProfile(event.profileId);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
      UpdateProfile event,
      Emitter<ProfileState> emit,
      ) async {
    print('2. Bloc: UpdateProfile keldi');
    emit(ProfileLoading());
    print('3. Bloc: ProfileUpdating chiqarildi');
    try {
      await _repository.saveProfile(
        profileId: event.profileId,
        name: event.name,
        nickName: event.nickName,
        birthday: event.birthday,
        email: event.email,
        phone: event.phone,
        gender: event.gender,
      );
      final profile =
      await _repository.fetchProfile(event.profileId);
      print('4. Bloc: so\'rov tugadi');
      emit(ProfileLoaded(profile));
    } catch (e) {
      print('XATO: $e');
      emit(ProfileError(e.toString()));
    }
  }
}