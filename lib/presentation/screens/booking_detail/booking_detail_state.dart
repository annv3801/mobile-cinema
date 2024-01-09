part of 'booking_detail_cubit.dart';

class BookingDetailState extends Equatable {
  final LoadStatus getBookingDetailStatus;
  final BookingDetailResponse? bookingDetail;
  final String? getBookingDetailMessage;

  // cancel booking
  final LoadStatus cancelBookingStatus;
  final String? cancelBookingMessage;

  const BookingDetailState({
    this.getBookingDetailStatus = LoadStatus.initial,
    this.bookingDetail,
    this.getBookingDetailMessage,

    // cancel booking
    this.cancelBookingStatus = LoadStatus.initial,
    this.cancelBookingMessage,
  });

  BookingDetailState copyWith({
    LoadStatus? getBookingDetailStatus,
    BookingDetailResponse? bookingDetail,
    String? getBookingDetailMessage,

    // cancel booking
    LoadStatus? cancelBookingStatus,
    String? cancelBookingMessage,
  }) {
    return BookingDetailState(
      getBookingDetailStatus: getBookingDetailStatus ?? this.getBookingDetailStatus,
      bookingDetail: bookingDetail ?? this.bookingDetail,
      getBookingDetailMessage: getBookingDetailMessage,

      // cancel booking
      cancelBookingStatus: cancelBookingStatus ?? this.cancelBookingStatus,
      cancelBookingMessage: cancelBookingMessage,
    );
  }

  @override
  List<Object?> get props => [
        getBookingDetailStatus,
        bookingDetail,
        getBookingDetailMessage,

        // cancel booking
        cancelBookingStatus,
        cancelBookingMessage,
      ];
}
