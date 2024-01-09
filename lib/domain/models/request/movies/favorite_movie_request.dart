import 'package:json_annotation/json_annotation.dart';

part 'favorite_movie_request.g.dart';

@JsonSerializable()
class FavoriteMovieRequest {
  @JsonKey(name: "filmId")
  final int movieId;

  const FavoriteMovieRequest({required this.movieId});

  factory FavoriteMovieRequest.fromJson(Map<String, dynamic> json) => _$FavoriteMovieRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteMovieRequestToJson(this);
}
