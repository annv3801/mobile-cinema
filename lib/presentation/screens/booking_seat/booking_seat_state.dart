part of 'booking_seat_cubit.dart';

class BookingSeatState extends Equatable {
  final LoadStatus getListBookingSeatsStatus;
  final List<List<SeatResponse?>> listBookingSeats;
  final String? getListBookingSeatsMessage;
  final List<SeatResponse> listBookedSeats;
  final double totalPrice;
  final List<TicketResponse> listTicketsType;

  const BookingSeatState({
    this.getListBookingSeatsStatus = LoadStatus.initial,
    this.listBookingSeats = const [],
    this.getListBookingSeatsMessage,
    this.listBookedSeats = const [],
    this.totalPrice = 0,
    this.listTicketsType = const [],
  });

  BookingSeatState copyWith({
    LoadStatus? getListBookingSeatsStatus,
    List<List<SeatResponse?>>? listBookingSeats,
    String? getListBookingSeatsMessage,
    List<SeatResponse>? listBookedSeats,
    double? totalPrice,
    List<TicketResponse>? listTicketsType,
  }) {
    return BookingSeatState(
      getListBookingSeatsStatus: getListBookingSeatsStatus ?? this.getListBookingSeatsStatus,
      listBookingSeats: listBookingSeats ?? this.listBookingSeats,
      getListBookingSeatsMessage: getListBookingSeatsMessage ?? this.getListBookingSeatsMessage,
      listBookedSeats: listBookedSeats ?? this.listBookedSeats,
      totalPrice: totalPrice ?? this.totalPrice,
      listTicketsType: listTicketsType ?? this.listTicketsType,
    );
  }

  @override
  List<Object?> get props => [
        getListBookingSeatsStatus,
        listBookingSeats,
        getListBookingSeatsMessage,
        listBookedSeats,
        totalPrice,
        listTicketsType,
      ];
}
