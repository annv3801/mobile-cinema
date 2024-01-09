import 'package:cinemax/domain/models/request/user/update_profile_request.dart';
import 'package:cinemax/domain/models/response/user/user_response.dart';
import 'package:either_dart/either.dart';

abstract class UserRepository {
  Future<Either<String, UserResponse>> getUserProfile();

  Future<Either<String, dynamic>> updateUserProfile(UpdateProfileRequest body);
}
