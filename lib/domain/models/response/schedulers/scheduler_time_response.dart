import 'package:json_annotation/json_annotation.dart';

part 'scheduler_time_response.g.dart';

@JsonSerializable()
class SchedulerTimeResponse {
  final int schedulerId;
  final DateTime? startTime;
  final DateTime? endTime;

  const SchedulerTimeResponse({
    this.schedulerId = 0,
    this.startTime,
    this.endTime,
  });

  factory SchedulerTimeResponse.fromJson(Map<String, dynamic> json) => _$SchedulerTimeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SchedulerTimeResponseToJson(this);
}
