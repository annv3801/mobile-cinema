part of 'news_detail_cubit.dart';

class NewsDetailState extends Equatable {
  final LoadStatus getNewsDetailStatus;
  final NewsDetailResponse? newsDetail;
  final String? getNewsDetailMessage;

  const NewsDetailState({
    this.getNewsDetailStatus = LoadStatus.initial,
    this.newsDetail,
    this.getNewsDetailMessage,
  });

  NewsDetailState copyWith({
    LoadStatus? getNewsDetailStatus,
    NewsDetailResponse? newsDetail,
    String? getNewsDetailMessage,
  }) {
    return NewsDetailState(
      getNewsDetailStatus: getNewsDetailStatus ?? this.getNewsDetailStatus,
      newsDetail: newsDetail ?? this.newsDetail,
      getNewsDetailMessage: getNewsDetailMessage,
    );
  }

  @override
  List<Object?> get props => [
        getNewsDetailStatus,
        newsDetail,
        getNewsDetailMessage,
      ];
}
