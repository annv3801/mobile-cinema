import 'package:cinemax/application/configs/env_configs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_response.g.dart';

@JsonSerializable()
class NewsResponse {
  final int id;
  final String title;
  final String image;

  const NewsResponse({
    this.id = 0,
    this.title = "",
    this.image = "",
  });

  String get thumbnailUrl => "${EnvConfigs.resourcesBaseUrl}/$image";

  factory NewsResponse.fromJson(Map<String, dynamic> json) => _$NewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);
}