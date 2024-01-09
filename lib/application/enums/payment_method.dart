import 'package:json_annotation/json_annotation.dart';

enum PaymentMethod {
  @JsonValue(0)
  cash,
  @JsonValue(1)
  vnPay,
}