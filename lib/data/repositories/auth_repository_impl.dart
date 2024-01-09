import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/data/data_sources/api/api_client_provider.dart';
import 'package:cinemax/data/data_sources/storages/shared_preferences.dart';
import 'package:cinemax/domain/models/request/auth/login_request.dart';
import 'package:cinemax/domain/models/request/auth/register_request.dart';
import 'package:cinemax/domain/models/request/auth/reset_password_request.dart';
import 'package:cinemax/domain/models/response/auth/login_response.dart';
import 'package:cinemax/domain/repositories/auth_repository.dart';
import 'package:either_dart/either.dart';

class AuthRepositoryImpl extends AuthRepository {
  final _apiClient = ApiClientProvider.apiClient;

  @override
  Future<Either<String, LoginResponse>> login(LoginRequest body) async {
    try {
      final response = await _apiClient!.login(body);
      if (response.success && response.data != null) {
        await SharedPreferencesHelper.saveStringValue(SharedPreferencesHelper.userToken, response.data!.accessToken);
        return Right(response.data!);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, dynamic>> register(RegisterRequest body) async {
    try {
      final response = await _apiClient!.register(body);
      if (response.success) {
        return Right(response.data);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, dynamic>> resetPassword(ResetPasswordRequest body) async {
    try {
      final response = await _apiClient!.resetPassword(body);
      if (response.success) {
        return Right(response.data);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }

  @override
  Future<Either<String, dynamic>> logout() async {
    try {
      final response = await _apiClient!.logout();
      if (response.success) {
        await SharedPreferencesHelper.removeByKey(SharedPreferencesHelper.userToken);
        return Right(response.data);
      }

      return Left(response.message);
    } catch (error) {
      return Left(error.toMessage);
    }
  }
}
