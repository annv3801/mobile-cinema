import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/data/data_sources/api/api_client_provider.dart';
import 'package:cinemax/data/data_sources/api/api_response.dart';
import 'package:cinemax/domain/models/response/notifications/notification_response.dart';
import 'package:cinemax/domain/repositories/notifications_repository.dart';
import 'package:either_dart/either.dart';

class NotificationsRepositoryImpl extends NotificationsRepository {
  final _apiClient = ApiClientProvider.apiClient;

  @override
  Future<Either<String, ListDataResponse<NotificationResponse>>> getListNotifications(int currentPage) async {
    try {
      // final response = await _apiClient!.getListNotifications(
      //   currentPage: currentPage,
      //   pageSize: AppConstants.pageSize,
      // );
      //
      // if (response.success && response.data != null) {
      //   return Right(response.data!);
      // }

      return Left("response.message");
    } catch (error) {
      return Left(error.toMessage);
    }
  }
}
