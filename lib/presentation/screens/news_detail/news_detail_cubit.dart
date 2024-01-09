import 'package:bloc/bloc.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/response/news/news_detail_response.dart';
import 'package:cinemax/domain/repositories/news_repository.dart';
import 'package:equatable/equatable.dart';

part 'news_detail_state.dart';

class NewsDetailCubit extends Cubit<NewsDetailState> {
  NewsDetailCubit() : super(const NewsDetailState());

  final _newsRepository = getIt<NewsRepository>();

  Future<void> getNewsDetail(int newsId) async {
    try {
      emit(state.copyWith(getNewsDetailStatus: LoadStatus.loading));
      final response = await _newsRepository.getNewsDetail(newsId);

      response.fold(
        (left) {
          emit(state.copyWith(
            getNewsDetailStatus: LoadStatus.failure,
            getNewsDetailMessage: left,
          ));
        },
        (right) {
          emit(state.copyWith(
            getNewsDetailStatus: LoadStatus.success,
            newsDetail: right,
          ));
        },
      );
    } catch (error) {
      emit(state.copyWith(
        getNewsDetailStatus: LoadStatus.failure,
        getNewsDetailMessage: error.toMessage,
      ));
    }
  }
}
