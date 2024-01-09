import 'package:bloc/bloc.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/response/booking/booking_detail_response.dart';
import 'package:cinemax/domain/repositories/booking_repository.dart';
import 'package:equatable/equatable.dart';

part 'booking_detail_state.dart';

class BookingDetailCubit extends Cubit<BookingDetailState> {
  BookingDetailCubit() : super(const BookingDetailState());

  final _bookingRepository = getIt<BookingRepository>();

  Future<void> getBookingDetail(int bookingId) async {
    try {
      emit(state.copyWith(getBookingDetailStatus: LoadStatus.loading));
      final response = await _bookingRepository.getBookingDetail(bookingId);
      response.fold(
        (left) {
          emit(state.copyWith(
            getBookingDetailStatus: LoadStatus.failure,
            getBookingDetailMessage: left,
          ));
        },
        (right) {
          emit(state.copyWith(
            getBookingDetailStatus: LoadStatus.success,
            bookingDetail: right,
          ));
        },
      );
    } catch (error) {
      emit(state.copyWith(getBookingDetailStatus: LoadStatus.failure));
    }
  }

  Future<void> cancelBooking(int bookingId) async {
    try {
      emit(state.copyWith(cancelBookingStatus: LoadStatus.loading));
      final response = await _bookingRepository.cancelBooking(bookingId);

      response.fold(
        (left) {
          emit(state.copyWith(
            cancelBookingStatus: LoadStatus.failure,
            cancelBookingMessage: left,
          ));
        },
        (right) {
          emit(state.copyWith(cancelBookingStatus: LoadStatus.success));
        },
      );
    } catch (error) {
      emit(state.copyWith(
        cancelBookingStatus: LoadStatus.failure,
        cancelBookingMessage: error.toMessage,
      ));
    }
  }
}
