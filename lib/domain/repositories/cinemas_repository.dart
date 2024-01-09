import 'package:cinemax/data/data_sources/api/api_response.dart';
import 'package:cinemax/domain/models/response/cinemas/cinema_detail_response.dart';
import 'package:cinemax/domain/models/response/cinemas/cinema_response.dart';
import 'package:cinemax/domain/models/response/schedulers/scheduler_cinema_response.dart';
import 'package:either_dart/either.dart';

abstract class CinemasRepository {
  Future<Either<String, CinemaDetailResponse>> getCinemaDetail(int cinemaId);

  Future<Either<String, ListDataResponse<CinemaResponse>>> getListCinemas(int currentPage, {int? movieId});

  Future<Either<String, List<SchedulerCinemaResponse>>> getListSchedulers(int cinemaId, {required DateTime date});

  Future<Either<String, SchedulerDataResponse>> getSchedulerByMovie(
    int cinemaId, {
    required int movieId,
    required DateTime date,
  });

  Future<Either<String, ListDataResponse<CinemaResponse>>> getListFavoriteCinemas(int currentPage, {int? movieId});

  Future<Either<String, dynamic>> favoriteCinema(int cinemaId);
}
