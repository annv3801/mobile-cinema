import 'package:cinemax/application/enums/booking_status.dart';
import 'package:cinemax/data/data_sources/api/api_response.dart';
import 'package:cinemax/domain/models/request/booking/create_booking_request.dart';
import 'package:cinemax/domain/models/response/booking/booking_detail_response.dart';
import 'package:cinemax/domain/models/response/booking/booking_response.dart';
import 'package:cinemax/domain/models/response/booking/seat_response.dart';
import 'package:cinemax/domain/models/response/schedulers/scheduler_detail_response.dart';
import 'package:either_dart/either.dart';

abstract class BookingRepository {
  Future<Either<String, List<List<SeatResponse?>>>> getListBookingSeats(int schedulerId);

  Future<Either<String, dynamic>> createBooking(CreateBookingRequest body);

  Future<Either<String, dynamic>> cancelBooking(int id);

  Future<Either<String, ListDataResponse<BookingResponse>>> getListBookings(int currentPage, {BookingStatus? status});

  Future<Either<String, BookingDetailResponse>> getBookingDetail(int bookingId);

  Future<Either<String, SchedulerDetailResponse>> getSchedulerDetail(int schedulerId);

  Future<Either<String, Uri>> createVnPayPayment(double amount);
}