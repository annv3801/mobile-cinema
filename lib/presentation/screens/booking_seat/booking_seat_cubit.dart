import 'package:bloc/bloc.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/response/booking/seat_response.dart';
import 'package:cinemax/domain/repositories/booking_repository.dart';
import 'package:equatable/equatable.dart';

part 'booking_seat_state.dart';

class BookingSeatCubit extends Cubit<BookingSeatState> {
  BookingSeatCubit() : super(const BookingSeatState());

  final _bookingRepository = getIt<BookingRepository>();

  Future<void> getListBookingSeats(int schedulerId) async {
    try {
      emit(state.copyWith(getListBookingSeatsStatus: LoadStatus.loading));
      final response = await _bookingRepository.getListBookingSeats(schedulerId);

      response.fold(
        (message) {
          emit(state.copyWith(
            getListBookingSeatsStatus: LoadStatus.failure,
            getListBookingSeatsMessage: message,
          ));
        },
        (result) {
          final List<TicketResponse> listTicketsType = [];
          final data = result.expand((element) => element).toList();

          for (var i = 0; i < data.length; i++) {
            if (data[i] != null && !listTicketsType.any((item) => item.id == data[i]?.ticket.id)) {
              listTicketsType.add(data[i]!.ticket);
            }
          }

          emit(state.copyWith(
            getListBookingSeatsStatus: LoadStatus.success,
            listBookingSeats: result,
            listTicketsType: listTicketsType,
          ));
        },
      );
    } catch (error) {
      emit(state.copyWith(
        getListBookingSeatsStatus: LoadStatus.failure,
        getListBookingSeatsMessage: error.toMessage,
      ));
    }
  }

  void onSelectBookingSeats(SeatResponse seat) {
    if (state.listBookedSeats.any((item) => item.id == seat.id)) {
      final listBookedSeats = state.listBookedSeats.where((item) => item.id != seat.id).toList();
      emit(state.copyWith(listBookedSeats: listBookedSeats));
      return;
    }

    emit(state.copyWith(listBookedSeats: [...state.listBookedSeats, seat]));
  }

  void calculateTotalPrice() {
    double totalPrice = 0;

    for (var i = 0; i < state.listBookedSeats.length; i++) {
      totalPrice = totalPrice + state.listBookedSeats[i].ticket.price;
    }

    emit(state.copyWith(totalPrice: totalPrice));
  }
}
