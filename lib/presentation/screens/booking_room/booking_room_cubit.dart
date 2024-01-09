import 'package:bloc/bloc.dart';
import 'package:cinemax/application/constants/app_constants.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/application/utils/utils.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/response/cinemas/cinema_detail_response.dart';
import 'package:cinemax/domain/models/response/schedulers/scheduler_cinema_response.dart';
import 'package:cinemax/domain/repositories/cinemas_repository.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'booking_room_state.dart';

class BookingRoomCubit extends Cubit<BookingRoomState> {
  BookingRoomCubit() : super(BookingRoomState(bookingDate: DateTime.now()));

  final _cinemasRepository = getIt<CinemasRepository>();

  Future<void> getCinemaDetail(int cinemaId) async {
    try {
      emit(state.copyWith(getCinemaDetailStatus: LoadStatus.loading));

      final response = await _cinemasRepository.getCinemaDetail(cinemaId);

      if (response.isRight) {
        final locationBytes = await Utils.getBytesFromAsset(
          Assets.images.imgLocation.path,
          AppConstants.markerSize.w.toInt(),
        );

        final marker = Marker(
          markerId: const MarkerId("targetPosition"),
          icon: BitmapDescriptor.fromBytes(locationBytes!),
          position: LatLng(response.right.latitude, response.right.longitude),
        );

        emit(state.copyWith(
          getCinemaDetailStatus: LoadStatus.success,
          cinemaDetail: response.right,
          markers: [marker],
          isFavorite: response.right.isFavorite,
        ));
        return;
      }

      emit(state.copyWith(getCinemaDetailStatus: LoadStatus.failure, getCinemaDetailMessage: response.left));
    } catch (e) {
      emit(state.copyWith(getCinemaDetailStatus: LoadStatus.failure, getCinemaDetailMessage: e.toMessage));
    }
  }

  void getListBookingDate() {
    final List<DateTime> listBookingDate = [];
    final now = DateTime.now();
    for (var i = 0; i < 7; i++) {
      listBookingDate.add(DateTime(now.year, now.month, now.day + i));
    }

    emit(state.copyWith(listBookingDate: listBookingDate));
  }

  void onChangeBookingDate(DateTime bookingDate) {
    emit(state.copyWith(bookingDate: bookingDate));
  }

  void onChangeSchedulerId(int schedulerId) {
    emit(state.copyWith(schedulerId: schedulerId));
  }

  Future<void> getSchedulerByMovie({required int cinemaId, required int movieId}) async {
    try {
      emit(state.copyWith(getSchedulerDataStatus: LoadStatus.loading));
      final response = await _cinemasRepository.getSchedulerByMovie(cinemaId, movieId: movieId, date: state.bookingDate);

      if (response.isRight) {
        emit(state.copyWith(getSchedulerDataStatus: LoadStatus.success, schedulerData: response.right));
        return;
      }

      emit(state.copyWith(
        getSchedulerDataStatus: LoadStatus.failure,
        getSchedulerDataMessage: response.left,
      ));
    } catch (error) {
      emit(state.copyWith(
        getSchedulerDataStatus: LoadStatus.failure,
        getSchedulerDataMessage: error.toMessage,
      ));
    }
  }
}
