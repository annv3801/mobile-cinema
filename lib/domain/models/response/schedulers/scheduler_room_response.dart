import 'package:cinemax/domain/models/response/schedulers/scheduler_time_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scheduler_room_response.g.dart';

@JsonSerializable()
class SchedulerRoomResponse {
  final SchedulerRoomDataResponse room;

  @JsonKey(name: "schedulerTimeResponses")
  final List<SchedulerTimeResponse> times;

  const SchedulerRoomResponse({
    this.room = const SchedulerRoomDataResponse(),
    this.times = const [],
  });

  factory SchedulerRoomResponse.fromJson(Map<String, dynamic> json) => _$SchedulerRoomResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SchedulerRoomResponseToJson(this);
}

@JsonSerializable()
class SchedulerRoomDataResponse {
  final int id;
  final String name;

  const SchedulerRoomDataResponse({this.id = 0, this.name = ""});

  factory SchedulerRoomDataResponse.fromJson(Map<String, dynamic> json) => _$SchedulerRoomDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SchedulerRoomDataResponseToJson(this);
}