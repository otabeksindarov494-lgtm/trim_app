import 'package:flutter_bloc/flutter_bloc.dart';
import '../provider/repository/salon_repository.dart';
import 'salon_event.dart';
import 'salon_state.dart';

class SalonBloc extends Bloc<SalonEvent, SalonState> {
  final SalonRepository _repository;

  SalonBloc({required SalonRepository repository})
  : _repository = repository,
  super(SalonInitial()) {
    on<SalonsRequested>(_onSalonsRequested);
  }
  Future<void> _onSalonsRequested(
      SalonsRequested event,
      Emitter<SalonState> emit,
      ) async {
    emit(SalonLoading());
    try {
      final salons = await _repository.fetchSalons();
      emit(SalonLoaded(salons));
    }catch (e) {
      emit(SalonError(e.toString()));
    }
  }
}