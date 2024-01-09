import 'package:cinemax/application/constants/app_constants.dart';
import 'package:cinemax/application/enums/booking_status.dart';
import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/data/data_sources/api/api_client_provider.dart';
import 'package:cinemax/data/data_sources/api/api_response.dart';
import 'package:cinemax/data/data_sources/storages/shared_preferences.dart';
import 'package:cinemax/domain/models/request/booking/create_booking_request.dart';
import 'package:cinemax/domain/models/request/booking/create_vnpay_payment_request.dart';
import 'package:cinemax/domain/models/request/booking/get_list_bookings_request.dart';
import 'package:cinemax/domain/models/response/booking/booking_detail_response.dart';
import 'package:cinemax/domain/models/response/booking/booking_response.dart';
import 'package:cinemax/domain/models/response/booking/seat_response.dart';
import 'package:cinemax/domain/models/response/schedulers/scheduler_detail_response.dart';
import 'package:cinemax/domain/repositories/booking_repository.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:either_dart/either.dart';

class BookingRepositoryImpl extends BookingRepository {
  final _apiClient = ApiClientProvider.apiClient;

  @override
  Future<Either<String, List<List<SeatResponse?>>>> getListBookingSeats(int schedulerId) async {
    try {
      final response = await _apiClient!.getListBookingSeats(schedulerId);

      if (response.success) {
        if (response.data?.isEmpty ?? true) {
          return Left(tr("errorTitle"));
        }

        final List<String> rows = [];
        for (var i = 0; i < response.data!.length; i++) {
          if (response.data![i].row != null && !rows.contains(response.data![i].row!)) {
            rows.add(response.data![i].row!);
          }
        }
        rows.sort();

        int maxColumn = 0;
        for (var i = 0; i < rows.length; i++) {
          final data = response.data!.where((item) => item.row == rows[i]).toList();
          if (data.length > maxColumn) {
            maxColumn = data.length;
          }
        }

        final List<List<SeatResponse?>> result = [];
        for (var i = 0; i < rows.length; i++) {
          final listOriginalData = response.data!.where((item) => item.row == rows[i]).toList();
          listOriginalData.sort((a, b) => int.parse(a.column).compareTo(int.parse(b.column)));
          final List<SeatResponse?> data = [];

          for (var j = 0; j < maxColumn; j++) {
            final bookingSeat = listOriginalData.firstWhereOrNull(
              (item) => item.row == rows[i] && int.parse(item.column) == j,
            );
            data.add(bookingSeat);
          }

          result.add(data);
        }

        return Right(result);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, dynamic>> createBooking(CreateBookingRequest body) async {
    try {
      final response = await _apiClient!.createBooking(body);

      if (response.success) {
        return Right(response.data);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, dynamic>> cancelBooking(int id) async {
    try {
      final response = await _apiClient!.cancelBooking(id);

      if (response.success) {
        return Right(response.data);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, ListDataResponse<BookingResponse>>> getListBookings(int currentPage, {BookingStatus? status}) async {
    try {
      final accountId = await SharedPreferencesHelper.getIntValue(SharedPreferencesHelper.accountId);
      final sortByFields = [
        const SortByFieldsRequest(colName: 'createdTime', sortDirection: 'DESC'),
      ];

      final request = GetListBookingsRequest(
        accountId: accountId ?? 0,
        currentPage: currentPage,
        pageSize: AppConstants.pageSize,
        sortByFields: sortByFields,
        status: status,
      );
      final response = await _apiClient!.getListBookings(request);

      if (response.success && response.data != null) {
        if (response.data!.data.isNotEmpty) {
          return Right(response.data!);
        }

        return Left(tr("listBookingsIsEmpty"));
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, BookingDetailResponse>> getBookingDetail(int bookingId) async {
    try {
      final response = await _apiClient!.getBookingDetail(bookingId);

      if (response.success && response.data != null) {
        return Right(response.data!);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, SchedulerDetailResponse>> getSchedulerDetail(int schedulerId) async {
    try {
      final response = await _apiClient!.getSchedulerDetail(schedulerId);

      if (response.success && response.data != null) {
        return Right(response.data!);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, Uri>> createVnPayPayment(double amount) async {
    try {
      final body = CreateVnPayPaymentRequest(amount: amount);

      final response = await _apiClient!.createVnPayPayment(body);
      final url = Uri.parse(response);

      if (url.isAbsolute) {
        return Right(url);
      }

      return Left(response);
    } catch (error) {
      return Left(error.toMessage);
    }
  }
}
