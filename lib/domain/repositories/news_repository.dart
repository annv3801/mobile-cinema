import 'package:cinemax/data/data_sources/api/api_response.dart';
import 'package:cinemax/domain/models/response/news/news_detail_response.dart';
import 'package:cinemax/domain/models/response/news/news_response.dart';
import 'package:either_dart/either.dart';

abstract class NewsRepository {
  Future<Either<String, ListDataResponse<NewsResponse>>> getListNews(int currentPage);

  Future<Either<String, NewsDetailResponse>> getNewsDetail(int newsId);
}