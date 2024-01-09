import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;
  final bool forceOtherSessionsLogout;

  const ResetPasswordRequest({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
    this.forceOtherSessionsLogout = true,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) => _$ResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}
