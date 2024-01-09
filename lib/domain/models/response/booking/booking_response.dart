import 'package:cinemax/application/configs/env_configs.dart';
import 'package:cinemax/application/enums/booking_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_response.g.dart';

@JsonSerializable()
class BookingResponse {
  final int id;
  final double total;
  // final BookingStatus status;
  final List<SeatsResponse> seats;

  const BookingResponse({
    this.id = 0,
    this.total = 0,
    // this.status = BookingStatus.upcoming,
    this.seats = const [],
  });

  String get movieName => seats.first.movieName;

  String get cinemaName => seats.first.cinemaName;

  String get movieThumbnailUrl => "${EnvConfigs.resourcesBaseUrl}/${seats.first.movieImage}";

  DateTime? get startTime => seats.first.scheduler.startTime;

  DateTime? get endTime => seats.first.scheduler.endTime;

  factory BookingResponse.fromJson(Map<String, dynamic> json) => _$BookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookingResponseToJson(this);
}

@JsonSerializable()
class SeatsResponse {
  final SchedulerResponse scheduler;
  final BookingRoomSeatResponse roomSeat;

  @JsonKey(name: "filmName")
  final String movieName;

  @JsonKey(name: "filmImage")
  final String movieImage;

  @JsonKey(name: "theaterName")
  final String cinemaName;

  const SeatsResponse({
    this.scheduler = const SchedulerResponse(),
    this.roomSeat = const BookingRoomSeatResponse(),
    this.movieName = "",
    this.cinemaName = "",
    this.movieImage = "",
  });

  String get name => roomSeat.name;

  factory SeatsResponse.fromJson(Map<String, dynamic> json) => _$SeatsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SeatsResponseToJson(this);
}

@JsonSerializable()
class SchedulerResponse {
  final DateTime? startTime;
  final DateTime? endTime;

  const SchedulerResponse({
    this.startTime,
    this.endTime,
  });

  factory SchedulerResponse.fromJson(Map<String, dynamic> json) => _$SchedulerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SchedulerResponseToJson(this);
}

@JsonSerializable()
class BookingRoomSeatResponse {
  final String name;

  const BookingRoomSeatResponse({this.name = ""});

  factory BookingRoomSeatResponse.fromJson(Map<String, dynamic> json) => _$BookingRoomSeatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookingRoomSeatResponseToJson(this);
}
