import 'package:json_annotation/json_annotation.dart';

part 'get_carousel_slider_request.g.dart';

@JsonSerializable()
class GetCarouselSliderRequest {
  final int currentPage;
  final int pageSize;

  const GetCarouselSliderRequest({
    required this.currentPage,
    required this.pageSize,
  });

  factory GetCarouselSliderRequest.fromJson(Map<String, dynamic> json) => _$GetCarouselSliderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetCarouselSliderRequestToJson(this);
}