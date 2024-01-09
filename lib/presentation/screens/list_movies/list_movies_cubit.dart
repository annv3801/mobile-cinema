import 'package:bloc/bloc.dart';
import 'package:cinemax/application/constants/app_constants.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/request/movies/get_list_movies_by_group_request.dart';
import 'package:cinemax/domain/models/response/movies/movie_response.dart';
import 'package:cinemax/domain/repositories/movies_repository.dart';
import 'package:equatable/equatable.dart';

part 'list_movies_state.dart';

class ListMoviesCubit extends Cubit<ListMoviesState> {
  ListMoviesCubit() : super(const ListMoviesState());

  final _moviesRepository = getIt<MoviesRepository>();

  Future<void> getListMovies(int groupId) async {
    try {
      emit(state.copyWith(getListMoviesStatus: LoadStatus.loading));

      final body = GetListMoviesByGroupRequest(
        groupId: groupId,
        currentPage: 1,
        pageSize: AppConstants.pageSize,
      );

      final response = await _moviesRepository.getListMoviesByGroup(body);

      if (response.isRight) {
        emit(state.copyWith(
          getListMoviesStatus: LoadStatus.success,
          listMovies: response.right.data,
          currentPage: response.right.currentPage,
          hasNextPage: response.right.currentPage < response.right.lastPage,
        ));
        return;
      }

      emit(state.copyWith(getListMoviesStatus: LoadStatus.failure));
    } catch (error) {
      emit(state.copyWith(getListMoviesStatus: LoadStatus.failure));
    }
  }

  Future<void> getMoreListMovies(int groupId) async {
    try {
      if (!state.hasNextPage || state.getMoreMoviesStatus == LoadStatus.loading) return;

      emit(state.copyWith(getMoreMoviesStatus: LoadStatus.loading));

      final body = GetListMoviesByGroupRequest(
        groupId: groupId,
        currentPage: state.currentPage + 1,
        pageSize: AppConstants.pageSize,
      );

      final response = await _moviesRepository.getListMoviesByGroup(body);

      if (response.isRight) {
        emit(state.copyWith(
          getMoreMoviesStatus: LoadStatus.success,
          listMovies: [...state.listMovies, ...response.right.data],
          currentPage: response.right.currentPage,
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
