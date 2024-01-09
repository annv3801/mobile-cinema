import 'package:cinemax/domain/models/response/movies/movie_detail_response.dart';
import 'package:cinemax/domain/models/response/schedulers/scheduler_room_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scheduler_cinema_response.g.dart';

@JsonSerializable()
class SchedulerCinemaResponse {
  @JsonKey(name: "schedulerFilmResponses")
  final List<SchedulerDataResponse> data;

  const SchedulerCinemaResponse({this.data = const []});

  factory SchedulerCinemaResponse.fromJson(Map<String, dynamic> json) => _$SchedulerCinemaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SchedulerCinemaResponseToJson(this);
}

@JsonSerializable()
class SchedulerDataResponse {
  @JsonKey(name: "film")
  final MovieDetailResponse movie;

  @JsonKey(name: "schedulerRoomResponse")
  final List<SchedulerRoomResponse> rooms;

  const SchedulerDataResponse({
    this.movie = const MovieDetailResponse(),
    this.rooms = const [],
  });

  factory SchedulerDataResponse.fromJson(Map<String, dynamic> json) => _$SchedulerDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SchedulerDataResponseToJson(this);
}
