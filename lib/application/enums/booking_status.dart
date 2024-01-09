import 'package:json_annotation/json_annotation.dart';

enum BookingStatus {
  @JsonValue("UpComing")
  upcoming,
  @JsonValue("Passed")
  passed,
  @JsonValue("Canceled")
  cancelled,
}
