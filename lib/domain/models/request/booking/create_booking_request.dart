import 'package:cinemax/application/enums/payment_method.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_booking_request.g.dart';

@JsonSerializable()
class CreateBookingRequest {
  final List<int> seatId;
  final double total;
  final double totalBeforeDiscount;
  final double discount;
  final PaymentMethod paymentMethod;
  final List<FoodsRequest> foods;

  const CreateBookingRequest({
    required this.seatId,
    required this.total,
    required this.totalBeforeDiscount,
    this.discount = 0,
    required this.paymentMethod,
    this.foods = const [],
  });

  factory CreateBookingRequest.fromJson(Map<String, dynamic> json) => _$CreateBookingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBookingRequestToJson(this);
}

@JsonSerializable()
class FoodsRequest {
  final int foodId;
  final int quantity;

  const FoodsRequest({this.foodId = 0, this.quantity = 0});

  factory FoodsRequest.fromJson(Map<String, dynamic> json) => _$FoodsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FoodsRequestToJson(this);
}
