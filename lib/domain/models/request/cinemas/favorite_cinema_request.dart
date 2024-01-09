import 'package:json_annotation/json_annotation.dart';

part 'favorite_cinema_request.g.dart';

@JsonSerializable(includeIfNull: false)
class FavoriteCinemaRequest {
  @JsonKey(name: "theaterId")
  final int cinemaId;

  const FavoriteCinemaRequest({required this.cinemaId});

  factory FavoriteCinemaRequest.fromJson(Map<String, dynamic> json) => _$FavoriteCinemaRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteCinemaRequestToJson(this);
}
