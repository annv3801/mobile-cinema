import 'package:cinemax/application/enums/booking_seat.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat_response.g.dart';

@JsonSerializable()
class SeatResponse {
  final int id;
  final SchedulerResponse scheduler;
  final RoomSeatResponse roomSeat;
  final TicketResponse ticket;
  final BookingSeatType type;
  final BookingSeatStatus status;

  const SeatResponse({
    this.id = 0,
    this.scheduler = const SchedulerResponse(),
    this.roomSeat = const RoomSeatResponse(),
    this.ticket = const TicketResponse(),
    this.type = BookingSeatType.deactivate,
    this.status = BookingSeatStatus.taken,
  });

  String? get row => roomSeat.name.isNotEmpty ? roomSeat.name[0] : null;

  String get column => roomSeat.name.length > 1 ? roomSeat.name.substring(1, roomSeat.name.length) : "-1";

  factory SeatResponse.fromJson(Map<String, dynamic> json) => _$SeatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SeatResponseToJson(this);
}

@JsonSerializable()
class SchedulerResponse {
  @JsonKey(name: "filmId")
  final int movieId;

  const SchedulerResponse({this.movieId = 0});

  factory SchedulerResponse.fromJson(Map<String, dynamic> json) => _$SchedulerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SchedulerResponseToJson(this);
}

@JsonSerializable()
class RoomSeatResponse {
  final String name;

  const RoomSeatResponse({this.name = ""});

  factory RoomSeatResponse.fromJson(Map<String, dynamic> json) => _$RoomSeatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RoomSeatResponseToJson(this);
}

@JsonSerializable()
class TicketResponse {
  final int id;
  final String title;
  final int type;
  final double price;
  final String color;

  const TicketResponse({
    this.id = 0,
    this.title = "",
    this.type = 0,
    this.price = 0,
    this.color = "",
  });

  Color get fromHexColor {
    final buffer = StringBuffer();
    if (color.length == 6 || color.length == 7) buffer.write('ff');
    buffer.write(color.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  factory TicketResponse.fromJson(Map<String, dynamic> json) => _$TicketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TicketResponseToJson(this);
}
