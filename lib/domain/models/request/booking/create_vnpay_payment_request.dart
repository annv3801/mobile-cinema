import 'package:json_annotation/json_annotation.dart';

part 'create_vnpay_payment_request.g.dart';

@JsonSerializable()
class CreateVnPayPaymentRequest {
  final String orderType;
  final String orderDescription;
  final String name;
  final double amount;

  const CreateVnPayPaymentRequest({
    this.orderType = "string",
    this.orderDescription = "string",
    this.name = "string",
    required this.amount,
  });

  factory CreateVnPayPaymentRequest.fromJson(Map<String, dynamic> json) => _$CreateVnPayPaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateVnPayPaymentRequestToJson(this);
}
