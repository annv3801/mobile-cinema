import 'package:cinemax/domain/models/response/cinemas/cinema_detail_response.dart';
import 'package:cinemax/domain/models/response/movies/movie_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_detail_response.g.dart';

@JsonSerializable()
class BookingDetailResponse {
  final int id;
  final double total;
  final List<BookingSeatResponse> seats;
  final bool isComingSoon;

  MovieDetailResponse get movie => seats.first.scheduler.movie;

  CinemaDetailResponse get cinema => seats.first.scheduler.cinema;

  DateTime? get startTime => seats.first.scheduler.startTime;

  DateTime? get endTime => seats.first.scheduler.endTime;

  String get cinemaRoom => seats.first.roomName;

  const BookingDetailResponse({
    this.id = 0,
    this.total = 0,
    this.seats = const [],
    this.isComingSoon = false,
  });

  factory BookingDetailResponse.fromJson(Map<String, dynamic> json) => _$BookingDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookingDetailResponseToJson(this);
}

@JsonSerializable()
class BookingSeatResponse {
  final BookingSchedulerResponse scheduler;
  final BookingRoomSeatResponse roomSeat;
  final String roomName;

  const BookingSeatResponse({
    this.scheduler = const BookingSchedulerResponse(),
    this.roomSeat = const BookingRoomSeatResponse(),
    this.roomName = "",
  });

  factory BookingSeatResponse.fromJson(Map<String, dynamic> json) => _$BookingSeatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookingSeatResponseToJson(this);
}

@JsonSerializable()
class BookingSchedulerResponse {
  @JsonKey(name: "theater")
  final CinemaDetailResponse cinema;

  @JsonKey(name: "film")
  final MovieDetailResponse movie;
  final DateTime? startTime;
  final DateTime? endTime;

  const BookingSchedulerResponse({
    this.cinema = const CinemaDetailResponse(),
    this.movie = const MovieDetailResponse(),
    this.startTime,
    this.endTime,
  });

  factory BookingSchedulerResponse.fromJson(Map<String, dynamic> json) => _$BookingSchedulerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookingSchedulerResponseToJson(this);
}

@JsonSerializable()
class BookingRoomSeatResponse {
  final String name;

  const BookingRoomSeatResponse({this.name = ""});

  factory BookingRoomSeatResponse.fromJson(Map<String, dynamic> json) => _$BookingRoomSeatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookingRoomSeatResponseToJson(this);
}
