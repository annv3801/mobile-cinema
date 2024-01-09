import 'package:cinemax/application/configs/env_configs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final int id;
  final String email;
  final String fullName;
  final String avatarPhoto;
  final bool gender;
  final String phoneNumber;

  const UserResponse({
    this.id = 0,
    this.email = "",
    this.fullName = "",
    this.avatarPhoto = "",
    this.gender = false,
    this.phoneNumber= "",
  });

  String get avatarUrl => "${EnvConfigs.resourcesBaseUrl}/$avatarPhoto";

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
