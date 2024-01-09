import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  final String email;
  final String fullName;
  final String userName;
  final String phoneNumber;
  final String avatarPhoto;
  final bool gender;
  final String password;

  const RegisterRequest({
    required this.email,
    required this.fullName,
    required this.userName,
    required this.phoneNumber,
    required this.avatarPhoto,
    required this.gender,
    required this.password,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
