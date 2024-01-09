import 'package:cinemax/application/constants/app_constants.dart';
import 'package:cinemax/application/enums/group_type.dart';
import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/data/data_sources/api/api_client_provider.dart';
import 'package:cinemax/domain/models/request/home/get_carousel_slider_request.dart';
import 'package:cinemax/domain/models/request/home/get_list_categories_request.dart';
import 'package:cinemax/domain/models/request/home/get_list_groups_request.dart';
import 'package:cinemax/domain/models/response/home/carousel_slider_response.dart';
import 'package:cinemax/domain/models/response/home/category_response.dart';
import 'package:cinemax/domain/models/response/home/group_response.dart';
import 'package:cinemax/domain/repositories/home_repository.dart';
import 'package:either_dart/either.dart';

class HomeRepositoryImpl extends HomeRepository {
  final _apiClient = ApiClientProvider.apiClient;

  @override
  Future<Either<String, List<GroupResponse>>> getListGroups(GroupType type) async {
    try {
      const body = GetListGroupsRequest(currentPage: 1, pageSize: AppConstants.pageSizeAll);

      final response = await _apiClient!.getListGroups(body, type: type);
      if (response.success && response.data != null) {
        final result = response.data!.data;
        result.sort((a, b) => a.index.compareTo(b.index));
        return Right(result);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, List<CategoryResponse>>> getListCategories() async {
    try {
      const body = GetListCategoriesRequest(currentPage: 1, pageSize: AppConstants.pageSizeAll);

      final response = await _apiClient!.getListCategories(body);
      if (response.success && response.data != null) {
        return Right(response.data!.data);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, List<CarouselSliderResponse>>> getCarouselSlider() async {
    try {
      const body = GetCarouselSliderRequest(currentPage: 1, pageSize: AppConstants.pageSizeAll);

      final response = await _apiClient!.getCarouselSlider(body);
      if (response.success && response.data != null) {
        return Right(response.data!.data);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }
}
