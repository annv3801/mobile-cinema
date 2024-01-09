import 'package:cinemax/domain/models/request/auth/login_request.dart';
import 'package:cinemax/domain/models/request/auth/register_request.dart';
import 'package:cinemax/domain/models/request/auth/reset_password_request.dart';
import 'package:cinemax/domain/models/response/auth/login_response.dart';
import 'package:either_dart/either.dart';

abstract class AuthRepository {
  Future<Either<String, LoginResponse>> login(LoginRequest body);

  Future<Either<String, dynamic>> register(RegisterRequest body);

  Future<Either<String, dynamic>> resetPassword(ResetPasswordRequest body);

  Future<Either<String, dynamic>> logout();
}
