import 'package:json_annotation/json_annotation.dart';

enum GroupType {
  @JsonValue("FILM")
  film,
  @JsonValue("FOOD")
  food,
}