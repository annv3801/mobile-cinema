import 'package:bloc/bloc.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/request/movies/rating_movie_request.dart';
import 'package:cinemax/domain/models/response/movies/movie_detail_response.dart';
import 'package:cinemax/domain/repositories/movies_repository.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit() : super(const MovieDetailState());

  final _moviesRepository = getIt<MoviesRepository>();

  Future<void> getMovieDetail(int movieId) async {
    try {
      emit(state.copyWith(getMovieDetailStatus: LoadStatus.loading));

      final response = await _moviesRepository.getMovieDetail(movieId);

      if (response.isRight) {
        emit(state.copyWith(
          getMovieDetailStatus: LoadStatus.success,
          movieDetail: response.right,
          isFavorite: response.right.isFavorite,
        ));
        return;
      }

      emit(state.copyWith(
        getMovieDetailStatus: LoadStatus.failure,
        getMovieDetailMessage: response.left,
      ));
    } catch (e) {
      emit(state.copyWith(
        getMovieDetailStatus: LoadStatus.failure,
        getMovieDetailMessage: e.toMessage,
      ));
    }
  }

  Future<void> favoriteMovie(int movieId) async {
    try {
      emit(state.copyWith(favoriteMovieStatus: LoadStatus.loading));

      final response = await _moviesRepository.favoriteMovie(movieId);
      response.fold(
        (left) {
          emit(state.copyWith(
            favoriteMovieStatus: LoadStatus.failure,
            favoriteMovieMessage: left,
          ));
        },
        (right) {
          emit(state.copyWith(
            favoriteMovieStatus: LoadStatus.success,
            isFavorite: !state.isFavorite,
          ));
        },
      );
    } catch (error) {
      emit(state.copyWith(
        favoriteMovieStatus: LoadStatus.failure,
        favoriteMovieMessage: error.toMessage,
      ));
    }
  }

  Future<void> ratingMovie(RatingMovieRequest body) async {
    try {
      emit(state.copyWith(ratingMovieStatus: LoadStatus.loading));
      final response = await _moviesRepository.ratingMovie(body);

      response.fold(
        (left) {
          emit(state.copyWith(
            ratingMovieStatus: LoadStatus.failure,
            ratingMovieMessage: left,
          ));
        },
        (right) async {
          final response = await _moviesRepository.getMovieDetail(body.movieId);
          if (response.isRight) {
            emit(state.copyWith(movieDetail: response.right, isFavorite: response.right.isFavorite));
          }

          emit(state.copyWith(ratingMovieStatus: LoadStatus.success));
        },
      );
    } catch (error) {
      emit(state.copyWith(
        ratingMovieStatus: LoadStatus.failure,
        ratingMovieMessage: error.toMessage,
      ));
    }
  }
}
