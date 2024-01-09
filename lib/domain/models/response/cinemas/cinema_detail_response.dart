import 'package:json_annotation/json_annotation.dart';

part 'cinema_detail_response.g.dart';

@JsonSerializable()
class CinemaDetailResponse {
  final int id;
  final String name;
  final double totalRating;
  final String location;
  final double longitude;
  final double latitude;
  final String phoneNumber;
  final bool isFavorite;

  const CinemaDetailResponse({
    this.id = 0,
    this.name = "",
    this.totalRating = 0,
    this.location = "",
    this.longitude = 0,
    this.latitude = 0,
    this.phoneNumber = "",
    this.isFavorite = false,
  });

  factory CinemaDetailResponse.fromJson(Map<String, dynamic> json) => _$CinemaDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaDetailResponseToJson(this);
}
