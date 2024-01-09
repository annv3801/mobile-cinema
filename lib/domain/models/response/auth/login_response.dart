import 'package:cinemax/application/enums/group_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final ProfileResponse profile;
  final String accessToken;
  final String refreshToken;

  const LoginResponse({required this.profile, required this.accessToken, required this.refreshToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class ProfileResponse {
  final String email;
  final String phoneNumber;
  final String avatar;
  final bool gender;
  final String fullName;

  const ProfileResponse({
    this.email = "",
    this.phoneNumber = "",
    this.avatar = "",
    this.gender = false,
    this.fullName = "",
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
