import 'package:bloc/bloc.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/response/cinemas/cinema_response.dart';
import 'package:cinemax/domain/repositories/cinemas_repository.dart';
import 'package:equatable/equatable.dart';

part 'favorite_cinemas_state.dart';

class FavoriteCinemasCubit extends Cubit<FavoriteCinemasState> {
  FavoriteCinemasCubit() : super(const FavoriteCinemasState());

  final _cinemasRepository = getIt<CinemasRepository>();

  Future<void> getListFavoriteCinemas({int? movieId}) async {
    try {
      emit(state.copyWith(getListCinemasStatus: LoadStatus.loading));

      final response = await _cinemasRepository.getListFavoriteCinemas(1, movieId: movieId);

      if (response.isRight) {
        emit(state.copyWith(
          getListCinemasStatus: LoadStatus.success,
          listCinemas: response.right.data,
          currentPage: response.right.currentPage,
          total: response.right.total,
          hasNextPage: response.right.currentPage < response.right.lastPage,
        ));
        return;
      }

      emit(state.copyWith(getListCinemasStatus: LoadStatus.failure, getListCinemasMessage: response.left));
    } catch (error) {
      emit(state.copyWith(getListCinemasStatus: LoadStatus.failure, getListCinemasMessage: error.toMessage));
    }
  }

  Future<void> getMoreListFavoriteCinemas({int? movieId}) async {
    try {
      if (!state.hasNextPage || state.getMoreCinemasStatus == LoadStatus.loading) return;

      emit(state.copyWith(getMoreCinemasStatus: LoadStatus.loading));
      final response = await _cinemasRepository.getListFavoriteCinemas(
        state.currentPage + 1,
        movieId: movieId,
      );

      if (response.isRight) {
        emit(state.copyWith(
          getMoreCinemasStatus: LoadStatus.success,
          listCinemas: [...state.listCinemas, ...response.right.data],
          currentPage: response.right.currentPage,
          total: response.right.total,
          hasNextPage: response.right.currentPage < response.right.lastPage,
        ));
        return;
      }

      emit(state.copyWith(getMoreCinemasStatus: LoadStatus.failure));
    } catch (error) {
      emit(state.copyWith(getMoreCinemasStatus: LoadStatus.failure));
    }
  }
}
