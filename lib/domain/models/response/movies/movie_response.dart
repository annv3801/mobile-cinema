import 'package:cinemax/application/configs/env_configs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse {
  final int id;
  final String name;
  final String image;
  final String genre;
  final bool isFavorite;

  const MovieResponse({
    this.id = 0,
    this.name = "",
    this.image = "",
    this.genre = "",
    this.isFavorite = false,
  });

  String get thumbnailUrl => "${EnvConfigs.resourcesBaseUrl}/$image";

  factory MovieResponse.fromJson(Map<String, dynamic> json) => _$MovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}
