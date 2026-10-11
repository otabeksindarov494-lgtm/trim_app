import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../provider/repository/booking_repository.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository _repository;

  BookingBloc({required BookingRepository repository})
      : _repository = repository,
        super(BookingInitial()) {
    on<BookingSubmitted>(_onBookingSubmitted);
  }

  Future<void> _onBookingSubmitted(
      BookingSubmitted event,
      Emitter<BookingState> emit,
      ) async {
    emit(BookingLoading());

    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      emit(const BookingFailure('Foydalanuvchi tizimga kirmagan'));
      return;
    }

    try {
      final booking = await _repository.book(
        userId: userId,
        salonId: event.salonId,
        masterId: event.masterId,
        serviceId: event.serviceId,
        bookingDate: event.bookingDate,
        bookingTime: event.bookingTime,
      );
      emit(BookingSuccess(booking));
    } catch (e) {
      emit(BookingFailure(e.toString()));
    }
  }
}