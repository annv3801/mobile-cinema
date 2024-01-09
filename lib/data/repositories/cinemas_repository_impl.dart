import 'package:cinemax/application/constants/app_constants.dart';
import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/data/data_sources/api/api_client_provider.dart';
import 'package:cinemax/data/data_sources/api/api_response.dart';
import 'package:cinemax/domain/models/request/cinemas/favorite_cinema_request.dart';
import 'package:cinemax/domain/models/request/cinemas/get_list_cinemas_request.dart';
import 'package:cinemax/domain/models/response/cinemas/cinema_detail_response.dart';
import 'package:cinemax/domain/models/response/cinemas/cinema_response.dart';
import 'package:cinemax/domain/models/response/schedulers/scheduler_cinema_response.dart';
import 'package:cinemax/domain/repositories/cinemas_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:either_dart/either.dart';

class CinemasRepositoryImpl extends CinemasRepository {
  final _apiClient = ApiClientProvider.apiClient;

  @override
  Future<Either<String, CinemaDetailResponse>> getCinemaDetail(int cinemaId) async {
    try {
      final response = await _apiClient!.getCinemaDetail(cinemaId);

      if (response.success && response.data != null) {
        return Right(response.data!);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, ListDataResponse<CinemaResponse>>> getListCinemas(int currentPage, {int? movieId}) async {
    try {
      final body = GetListCinemasRequest(currentPage: currentPage, pageSize: AppConstants.pageSize);

      if (movieId != null) {
        final response = await _apiClient!.getListCinemasByMovie(movieId: movieId, body: body);

        if (response.success && response.data != null) {
          return Right(response.data!);
        }

        return Left(response.message);
      }

      final response = await _apiClient!.getListCinemas(body);

      if (response.success && response.data != null) {
        return Right(response.data!);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, List<SchedulerCinemaResponse>>> getListSchedulers(int cinemaId, {required DateTime date}) async {
    try {
      final response = await _apiClient!.getListSchedulers(
        cinemaId: cinemaId,
        date: DateFormat('yyyy-MM-dd').format(date),
      );

      if (response.success) {
        return Right(response.data ?? []);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, SchedulerDataResponse>> getSchedulerByMovie(
    int cinemaId, {
    required int movieId,
    required DateTime date,
  }) async {
    try {
      final response = await _apiClient!.getSchedulerByMovie(
        cinemaId: cinemaId,
        movieId: movieId,
        date: DateFormat('yyyy-MM-dd').format(date),
      );

      if (response.success) {
        if (response.data?.isEmpty ?? true) {
          return Left(tr("listSchedulersIsEmpty"));
        }

        if (response.data?.first.data.isEmpty ?? true) {
          return Left(tr("listSchedulersIsEmpty"));
        }

        return Right(response.data!.first.data.first);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, ListDataResponse<CinemaResponse>>> getListFavoriteCinemas(int currentPage, {int? movieId}) async {
    try {
      final body = GetListCinemasRequest(currentPage: currentPage, pageSize: AppConstants.pageSize);
      if (movieId != null) {
        final response = await _apiClient!.getFavoriteCinemasByMovie(movieId: movieId, body: body);

        if (response.success && response.data != null) {
          return Right(response.data!);
        }

        return Left(response.message);
      }

      final response = await _apiClient!.getListFavoriteCinemas(body);

      if (response.success && response.data != null) {
        return Right(response.data!);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, dynamic>> favoriteCinema(int cinemaId) async {
    try {
      final body = FavoriteCinemaRequest(cinemaId: cinemaId);
      final response = await _apiClient!.favoriteCinema(body);

      if (response.success) {
        return Right(response.data);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }
}
