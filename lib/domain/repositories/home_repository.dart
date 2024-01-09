import 'package:cinemax/application/enums/group_type.dart';
import 'package:cinemax/domain/models/response/home/carousel_slider_response.dart';
import 'package:cinemax/domain/models/response/home/category_response.dart';
import 'package:cinemax/domain/models/response/home/group_response.dart';
import 'package:either_dart/either.dart';

abstract class HomeRepository {
  Future<Either<String, List<CategoryResponse>>> getListCategories();

  Future<Either<String, List<GroupResponse>>> getListGroups(GroupType type);

  Future<Either<String, List<CarouselSliderResponse>>> getCarouselSlider();
}
