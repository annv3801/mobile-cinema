import 'package:json_annotation/json_annotation.dart';

part 'rating_movie_request.g.dart';

@JsonSerializable()
class RatingMovieRequest {
  @JsonKey(name: "filmId")
  final int movieId;

  final int rating;

  const RatingMovieRequest({required this.movieId, required this.rating});

  factory RatingMovieRequest.fromJson(Map<String, dynamic> json) => _$RatingMovieRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RatingMovieRequestToJson(this);
}
