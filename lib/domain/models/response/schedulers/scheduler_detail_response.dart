import 'package:cinemax/domain/models/response/cinemas/cinema_detail_response.dart';
import 'package:cinemax/domain/models/response/movies/movie_detail_response.dart';
import 'package:cinemax/domain/models/response/schedulers/scheduler_room_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scheduler_detail_response.g.dart';

@JsonSerializable()
class SchedulerDetailResponse {
  @JsonKey(name: "film")
  final MovieDetailResponse movie;

  final SchedulerRoomDataResponse room;

  @JsonKey(name: "theater")
  final CinemaDetailResponse cinema;

  final DateTime? startTime;
  final DateTime? endTime;

  const SchedulerDetailResponse({
    this.movie = const MovieDetailResponse(),
    this.room = const SchedulerRoomDataResponse(),
    this.cinema = const CinemaDetailResponse(),
    this.startTime,
    this.endTime,
  });

  factory SchedulerDetailResponse.fromJson(Map<String, dynamic> json) => _$SchedulerDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SchedulerDetailResponseToJson(this);
}
