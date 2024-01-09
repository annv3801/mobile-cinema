import 'package:cinemax/domain/models/response/booking/seat_response.dart';

class BookingCheckoutArguments {
  final int schedulerId;
  final List<SeatResponse> listBookedSeats;

  const BookingCheckoutArguments({required this.schedulerId, required this.listBookedSeats});
}
