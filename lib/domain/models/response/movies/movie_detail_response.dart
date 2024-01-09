import 'package:cinemax/application/configs/env_configs.dart';
import 'package:cinemax/domain/models/response/movies/movie_rating_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_detail_response.g.dart';

@JsonSerializable()
class MovieDetailResponse {
  final int id;
  final String name;
  final String image;
  final String genre;
  final String description;
  final String actor;
  final String premiere;
  final int duration;
  final double totalRating;
  final String language;
  final String director;
  final bool isFavorite;

  @JsonKey(name: "feedbackFilmResponse")
  final MovieRatingResponse ratings;

  const MovieDetailResponse({
    this.id = 0,
    this.name = "",
    this.image = "",
    this.genre = "",
    this.description = "",
    this.actor = "",
    this.premiere = "",
    this.duration = 0,
    this.language = "",
    this.totalRating = 0,
    this.ratings = const MovieRatingResponse(),
    this.director = "",
    this.isFavorite = false,
  });

  String get thumbnailUrl => "${EnvConfigs.resourcesBaseUrl}/$image";

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) => _$MovieDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailResponseToJson(this);
}
