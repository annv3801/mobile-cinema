import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/data/data_sources/api/api_client_provider.dart';
import 'package:cinemax/domain/models/request/user/update_profile_request.dart';
import 'package:cinemax/domain/models/response/user/user_response.dart';
import 'package:cinemax/domain/repositories/user_repository.dart';
import 'package:either_dart/either.dart';

class UserRepositoryImpl extends UserRepository {
  final _apiClient = ApiClientProvider.apiClient;

  @override
  Future<Either<String, UserResponse>> getUserProfile() async {
    try {
      final response = await _apiClient!.getUserProfile();
      if (response.success && response.data != null) {
        return Right(response.data!);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, dynamic>> updateUserProfile(UpdateProfileRequest body) async {
    try {
      final response = await _apiClient!.updateUserProfile(
        email: body.email,
        fullName: body.fullName,
        phoneNumber: body.phoneNumber,
        gender: body.gender,
        avatarPhoto: body.avatarPhoto,
      );
      if (response.success) {
        return Right(response.data);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }
}
