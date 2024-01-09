import 'package:cinemax/data/data_sources/api/api_response.dart';
import 'package:cinemax/domain/models/request/movies/get_list_movies_by_group_request.dart';
import 'package:cinemax/domain/models/request/movies/rating_movie_request.dart';
import 'package:cinemax/domain/models/response/movies/movie_detail_response.dart';
import 'package:cinemax/domain/models/response/movies/movie_response.dart';
import 'package:either_dart/either.dart';

abstract class MoviesRepository {
  Future<Either<String, MovieDetailResponse>> getMovieDetail(int movieId);

  Future<Either<String, ListDataResponse<MovieResponse>>> getListMoviesByGroup(GetListMoviesByGroupRequest body);

  Future<Either<String, ListDataResponse<MovieResponse>>> getListFavoriteMovies(int currentPage);

  Future<Either<String, dynamic>> favoriteMovie(int movieId);

  Future<Either<String, dynamic>> ratingMovie(RatingMovieRequest body);
}
