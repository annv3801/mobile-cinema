import 'dart:io';

class UpdateProfileRequest {
  final String email;
  final String fullName;
  final String phoneNumber;
  final bool gender;
  final File? avatarPhoto;

  const UpdateProfileRequest({
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.gender,
    this.avatarPhoto,
  });
}
