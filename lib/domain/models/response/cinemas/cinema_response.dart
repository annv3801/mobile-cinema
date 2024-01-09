import 'package:json_annotation/json_annotation.dart';

part 'cinema_response.g.dart';

@JsonSerializable()
class CinemaResponse {
  final int id;
  final String name;
  final bool isFavorite;

  const CinemaResponse({
    this.id = 0,
    this.name = "",
    this.isFavorite = false,
  });

  factory CinemaResponse.fromJson(Map<String, dynamic> json) => _$CinemaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaResponseToJson(this);
}
