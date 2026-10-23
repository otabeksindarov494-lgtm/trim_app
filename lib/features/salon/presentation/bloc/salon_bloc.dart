import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim_app/features/salon/data/repositories/salon_repository.dart';
import 'salon_event.dart';
import 'salon_state.dart';

class SalonBloc extends Bloc<SalonEvent, SalonState> {
  final SalonRepository _repository;

  SalonBloc({required SalonRepository repository})
      : _repository = repository,
        super(SalonInitial()) {
    on<SalonsRequested>(_onSalonsRequested);
    on<ToggleFavoriteRequested>(_onToggleFavoriteRequested);
  }

  Future<void> _onSalonsRequested(
    SalonsRequested event,
    Emitter<SalonState> emit,
  ) async {
    emit(SalonLoading());
    try {
      final salons = await _repository.fetchSalons();
      emit(SalonLoaded(salons));
    } catch (e) {
      emit(SalonError(e.toString()));
    }
  }

  Future<void> _onToggleFavoriteRequested(
    ToggleFavoriteRequested event,
    Emitter<SalonState> emit,
  ) async {
    try {
      await _repository.toggleFavorite(event.salonId, event.currentStatus);
      final salons = await _repository.fetchSalons();
      emit(SalonLoaded(salons));
    } catch (e) {
      // keep current state or show error
    }
  }
}
