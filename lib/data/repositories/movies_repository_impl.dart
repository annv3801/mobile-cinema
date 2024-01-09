import 'package:cinemax/application/constants/app_constants.dart';
import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/data/data_sources/api/api_client_provider.dart';
import 'package:cinemax/data/data_sources/api/api_response.dart';
import 'package:cinemax/domain/models/request/movies/favorite_movie_request.dart';
import 'package:cinemax/domain/models/request/movies/get_list_movies_by_group_request.dart';
import 'package:cinemax/domain/models/request/movies/get_list_movies_request.dart';
import 'package:cinemax/domain/models/request/movies/rating_movie_request.dart';
import 'package:cinemax/domain/models/response/movies/movie_detail_response.dart';
import 'package:cinemax/domain/models/response/movies/movie_response.dart';
import 'package:cinemax/domain/repositories/movies_repository.dart';
import 'package:either_dart/either.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final _apiClient = ApiClientProvider.apiClient;

  @override
  Future<Either<String, MovieDetailResponse>> getMovieDetail(int movieId) async {
    try {
      final response = await _apiClient!.getMovieDetail(movieId);
      if (response.success && response.data != null) {
        return Right(response.data!);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, ListDataResponse<MovieResponse>>> getListMoviesByGroup(GetListMoviesByGroupRequest body) async {
    try {
      final response = await _apiClient!.getListMoviesByGroup(body);
      if (response.success && response.data != null) {
        return Right(response.data!);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, ListDataResponse<MovieResponse>>> getListFavoriteMovies(int currentPage) async {
    try {
      final body = GetListMoviesRequest(currentPage: currentPage, pageSize: AppConstants.pageSize);
      final response = await _apiClient!.getListFavoriteMovies(body);

      if (response.success && response.data != null) {
        return Right(response.data!);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, dynamic>> favoriteMovie(int movieId) async {
    try {
      final body = FavoriteMovieRequest(movieId: movieId);
      final response = await _apiClient!.favoriteMovie(body);

      if (response.success) {
        return Right(response.data);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, dynamic>> ratingMovie(RatingMovieRequest body) async {
    try {
      final response = await _apiClient!.ratingMovie(body);

      if (response.success) {
        return Right(response.data);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }
}
