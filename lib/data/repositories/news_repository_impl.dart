import 'package:cinemax/application/constants/app_constants.dart';
import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/data/data_sources/api/api_client_provider.dart';
import 'package:cinemax/data/data_sources/api/api_response.dart';
import 'package:cinemax/domain/models/request/news/get_list_news_request.dart';
import 'package:cinemax/domain/models/response/news/news_detail_response.dart';
import 'package:cinemax/domain/models/response/news/news_response.dart';
import 'package:cinemax/domain/repositories/news_repository.dart';
import 'package:either_dart/either.dart';

class NewsRepositoryImpl extends NewsRepository {
  final _apiClient = ApiClientProvider.apiClient;

  @override
  Future<Either<String, ListDataResponse<NewsResponse>>> getListNews(int currentPage) async {
    try {
      final body = GetListNewsRequest(currentPage: currentPage, pageSize: AppConstants.pageSize);
      final response = await _apiClient!.getListNews(body);
      if (response.success && response.data != null) {
        return Right(response.data!);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, NewsDetailResponse>> getNewsDetail(int newsId) async {
    try {
      final response = await _apiClient!.getNewsDetail(newsId);
      if (response.success && response.data != null) {
        return Right(response.data!);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }
}
