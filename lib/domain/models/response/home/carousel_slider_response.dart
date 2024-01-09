import 'package:cinemax/application/configs/env_configs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'carousel_slider_response.g.dart';

@JsonSerializable()
class CarouselSliderResponse {
  final int id;
  final String name;
  final String image;
  final int objectId;

  const CarouselSliderResponse({
    this.id = 0,
    this.name = "",
    this.image = "",
    this.objectId = 0,
  });

  String get imageUrl => "${EnvConfigs.resourcesBaseUrl}/$image";

  factory CarouselSliderResponse.fromJson(Map<String, dynamic> json) => _$CarouselSliderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CarouselSliderResponseToJson(this);
}
