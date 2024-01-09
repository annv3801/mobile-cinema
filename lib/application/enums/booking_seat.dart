import 'package:json_annotation/json_annotation.dart';

enum BookingSeatType {
  @JsonValue(0)
  deactivate,
  @JsonValue(1)
  active,
}

enum BookingSeatStatus {
  @JsonValue("ACTIVE")
  available,
  @JsonValue("BOOKED")
  taken,
}