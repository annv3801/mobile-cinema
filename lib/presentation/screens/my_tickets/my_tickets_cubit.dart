import 'package:bloc/bloc.dart';
import 'package:cinemax/application/enums/booking_status.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/response/booking/booking_response.dart';
import 'package:cinemax/domain/repositories/booking_repository.dart';
import 'package:equatable/equatable.dart';

part 'my_tickets_state.dart';

class MyTicketsCubit extends Cubit<MyTicketsState> {
  MyTicketsCubit() : super(const MyTicketsState());

  final _bookingRepository = getIt<BookingRepository>();

  Future<void> getListBookings(BookingStatus status) async {
    try {
      emit(state.copyWith(getListBookingStatus: LoadStatus.loading));

      final response = await _bookingRepository.getListBookings(1, status: status);

      if (response.isRight) {
        emit(state.copyWith(
          getListBookingStatus: LoadStatus.success,
          listBookings: response.right.data,
          currentPage: response.right.currentPage,
          hasNextPage: response.right.currentPage < response.right.lastPage,
        ));
        return;
      }

      emit(state.copyWith(
        getListBookingStatus: LoadStatus.failure,
        getListBookingMessage: response.left,
      ));
    } catch (error) {
      emit(state.copyWith(
        getListBookingStatus: LoadStatus.failure,
        getListBookingMessage: error.toMessage,
      ));
    }
  }

  Future<void> getMoreListBookings(BookingStatus status) async {
    try {
      if (!state.hasNextPage || state.getMoreListBookingStatus == LoadStatus.loading) return;

      emit(state.copyWith(getMoreListBookingStatus: LoadStatus.loading));

      final response = await _bookingRepository.getListBookings(state.currentPage + 1, status: status);

      if (response.isRight) {
        emit(state.copyWith(
          getMoreListBookingStatus: LoadStatus.success,
          listBookings: [...state.listBookings, ...response.right.data],
          currentPage: response.right.currentPage,
          hasNextPage: response.right.currentPage < response.right.lastPage,
        ));
        return;
      }

      emit(state.copyWith(getMoreListBookingStatus: LoadStatus.failure));
    } catch (error) {
      emit(state.copyWith(getMoreListBookingStatus: LoadStatus.failure));
    }
  }
}
