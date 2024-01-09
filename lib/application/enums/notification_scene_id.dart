import 'package:json_annotation/json_annotation.dart';

enum NotificationSceneId {
  @JsonValue(1)
  listMovies,
  @JsonValue(2)
  movieDetail,
  @JsonValue(3)
  cinemaDetail,
  @JsonValue(5)
  myTickets,
  @JsonValue(6)
  ticketDetail,
}
