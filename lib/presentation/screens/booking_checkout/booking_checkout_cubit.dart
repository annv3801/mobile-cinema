import 'package:bloc/bloc.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/application/enums/payment_method.dart';
import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/request/booking/create_booking_request.dart';
import 'package:cinemax/domain/models/response/booking/seat_response.dart';
import 'package:cinemax/domain/models/response/schedulers/scheduler_detail_response.dart';
import 'package:cinemax/domain/repositories/booking_repository.dart';
import 'package:equatable/equatable.dart';

part 'booking_checkout_state.dart';

class BookingCheckoutCubit extends Cubit<BookingCheckoutState> {
  BookingCheckoutCubit() : super(const BookingCheckoutState());

  final _bookingRepository = getIt<BookingRepository>();

  Future<void> getSchedulerDetail(int schedulerId) async {
    try {
      emit(state.copyWith(getSchedulerStatus: LoadStatus.loading));

      final response = await _bookingRepository.getSchedulerDetail(schedulerId);

      if (response.isRight) {
        emit(state.copyWith(
          getSchedulerStatus: LoadStatus.success,
          schedulerDetail: response.right,
        ));
        return;
      }

      emit(state.copyWith(getSchedulerStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(getSchedulerStatus: LoadStatus.failure));
    }
  }

  Future<void> createVnPayPayment(double amount) async {
    try {
      emit(state.copyWith(createVnPayPaymentStatus: LoadStatus.loading));

      final response = await _bookingRepository.createVnPayPayment(amount);
      response.fold(
        (left) {
          emit(state.copyWith(
            createVnPayPaymentStatus: LoadStatus.failure,
            createVnPayPaymentMessage: left,
          ));
        },
        (right) {
          emit(state.copyWith(
            createVnPayPaymentStatus: LoadStatus.success,
            vnPayPaymentUrl: right,
          ));
        },
      );
    } catch (error) {
      emit(state.copyWith(
        createVnPayPaymentStatus: LoadStatus.failure,
        createVnPayPaymentMessage: error.toMessage,
      ));
    }
  }

  Future<void> createBooking(List<SeatResponse> listBookedSeats) async {
    try {
      emit(state.copyWith(createBookingStatus: LoadStatus.loading));

      double total = 0;
      for (var i = 0; i < listBookedSeats.length; i++) {
        total = total + listBookedSeats[i].ticket.price;
      }

      final body = CreateBookingRequest(
        seatId: listBookedSeats.map((seat) => seat.id).toList(),
        total: total,
        totalBeforeDiscount: total,
        paymentMethod: state.paymentMethod!,
      );

      final response = await _bookingRepository.createBooking(body);

      response.fold(
        (left) {
          emit(state.copyWith(
            createBookingStatus: LoadStatus.failure,
            createBookingMessage: response.left,
          ));
        },
        (right) {
          emit(state.copyWith(createBookingStatus: LoadStatus.success));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        createBookingStatus: LoadStatus.failure,
        createBookingMessage: e.toMessage,
      ));
    }
  }

  void onChangePaymentMethod(PaymentMethod paymentMethod) {
    emit(state.copyWith(paymentMethod: paymentMethod));
  }
}
