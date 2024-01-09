import 'package:bloc/bloc.dart';
import 'package:cinemax/application/enums/group_type.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/request/movies/get_list_movies_by_group_request.dart';
import 'package:cinemax/domain/models/response/home/carousel_slider_response.dart';
import 'package:cinemax/domain/models/response/home/group_response.dart';
import 'package:cinemax/domain/models/response/movies/movie_response.dart';
import 'package:cinemax/domain/models/response/news/news_response.dart';
import 'package:cinemax/domain/repositories/home_repository.dart';
import 'package:cinemax/domain/repositories/movies_repository.dart';
import 'package:cinemax/domain/repositories/news_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  final _homeRepository = getIt<HomeRepository>();
  final _moviesRepository = getIt<MoviesRepository>();
  final _newsRepository = getIt<NewsRepository>();

  Future<void> getCarouselSlider() async {
    try {
      emit(state.copyWith(getCarouselSliderStatus: LoadStatus.loading));

      final response = await _homeRepository.getCarouselSlider();
      response.fold(
        (left) {
          emit(state.copyWith(getCarouselSliderStatus: LoadStatus.failure));
        },
        (right) {
          emit(state.copyWith(
            getCarouselSliderStatus: LoadStatus.success,
            listCarouselSlider: right,
          ));
        },
      );
    } catch (error) {
      emit(state.copyWith(getCarouselSliderStatus: LoadStatus.failure));
    }
  }

  Future<void> getListGroups() async {
    try {
      emit(state.copyWith(getListGroupsStatus: LoadStatus.loading));

      final response = await _homeRepository.getListGroups(GroupType.film);
      if (response.isRight) {
        emit(state.copyWith(
          getListGroupsStatus: LoadStatus.success,
          listGroups: response.right,
        ));
        return;
      }
      emit(state.copyWith(getListGroupsStatus: LoadStatus.failure));
    } catch (error) {
      emit(state.copyWith(getListGroupsStatus: LoadStatus.failure));
    }
  }

  Future<void> getListMoviesByGroup(int groupId) async {
    try {
      emit(state.copyWith(getListMoviesByGroupStatus: LoadStatus.loading));

      final body = GetListMoviesByGroupRequest(groupId: groupId, currentPage: 1, pageSize: 6);

      final response = await _moviesRepository.getListMoviesByGroup(body);
      if (response.isRight) {
        emit(state.copyWith(
          getListMoviesByGroupStatus: LoadStatus.success,
          listMoviesByGroup: response.right.data,
        ));
        return;
      }
      emit(state.copyWith(getListMoviesByGroupStatus: LoadStatus.failure));
    } catch (error) {
      emit(state.copyWith(getListMoviesByGroupStatus: LoadStatus.failure));
    }
  }

  Future<void> getListNews() async {
    try {
      emit(state.copyWith(getListNewsStatus: LoadStatus.loading));
      final response = await _newsRepository.getListNews(1);

      response.fold(
        (left) {
          emit(state.copyWith(getListNewsStatus: LoadStatus.failure));
        },
        (right) {
          emit(state.copyWith(
            getListNewsStatus: LoadStatus.success,
            listNews: response.right.data,
            currentPage: response.right.currentPage,
            hasNextPage: response.right.currentPage < response.right.lastPage,
          ));
        },
      );
    } catch (error) {
      emit(state.copyWith(getListNewsStatus: LoadStatus.failure));
    }
  }

  Future<void> getMoreNews() async {
    try {
      if (!state.hasNextPage || state.getMoreNewsStatus == LoadStatus.loading) return;
      emit(state.copyWith(getMoreNewsStatus: LoadStatus.loading));
      final response = await _newsRepository.getListNews(state.currentPage + 1);

      response.fold(
        (left) {
          emit(state.copyWith(getMoreNewsStatus: LoadStatus.failure));
        },
        (right) {
          emit(state.copyWith(
            getMoreNewsStatus: LoadStatus.success,
            listNews: [...state.listNews, ...response.right.data],
            currentPage: response.right.currentPage,
            hasNextPage: response.right.currentPage < response.right.lastPage,
          ));
        },
      );
    } catch (error) {
      emit(state.copyWith(getMoreNewsStatus: LoadStatus.failure));
    }
  }
}
