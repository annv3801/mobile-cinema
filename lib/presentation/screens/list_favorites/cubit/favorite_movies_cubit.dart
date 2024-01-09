import 'package:bloc/bloc.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/response/movies/movie_response.dart';
import 'package:cinemax/domain/repositories/movies_repository.dart';
import 'package:equatable/equatable.dart';

part 'favorite_movies_state.dart';

class FavoriteMoviesCubit extends Cubit<FavoriteMoviesState> {
  FavoriteMoviesCubit() : super(const FavoriteMoviesState());

  final _moviesRepository = getIt<MoviesRepository>();

  Future<void> getListFavoriteMovies() async {
    try {
      emit(state.copyWith(getListMoviesStatus: LoadStatus.loading));

      final response = await _moviesRepository.getListFavoriteMovies(1);

      if (response.isRight) {
        emit(state.copyWith(
          getListMoviesStatus: LoadStatus.success,
          listMovies: response.right.data,
          currentPage: response.right.currentPage,
          total: response.right.total,
          hasNextPage: response.right.currentPage < response.right.lastPage,
        ));
        return;
      }

      emit(state.copyWith(getListMoviesStatus: LoadStatus.failure, getListMoviesMessage: response.left));
    } catch (error) {
      emit(state.copyWith(getListMoviesStatus: LoadStatus.failure, getListMoviesMessage: error.toMessage));
    }
  }

  Future<void> getMoreListFavoriteMovies() async {
    try {
      if (!state.hasNextPage || state.getMoreMoviesStatus == LoadStatus.loading) return;

      emit(state.copyWith(getMoreMoviesStatus: LoadStatus.loading));
      final response = await _moviesRepository.getListFavoriteMovies(state.currentPage + 1);

      if (response.isRight) {
        emit(state.copyWith(
          getMoreMoviesStatus: LoadStatus.success,
          listMovies: [...state.listMovies, ...response.right.data],
          currentPage: response.right.currentPage,
          total: response.right.total,
          hasNextPage: response.right.currentPage < response.right.lastPage,
        ));
        return;
      }

      emit(state.copyWith(getMoreMoviesStatus: LoadStatus.failure));
    } catch (error) {
      emit(state.copyWith(getMoreMoviesStatus: LoadStatus.failure));
    }
  }
}
