import 'package:cinemax/data/data_sources/api/api_response.dart';
import 'package:cinemax/domain/models/response/notifications/notification_response.dart';
import 'package:either_dart/either.dart';

abstract class NotificationsRepository {
  Future<Either<String, ListDataResponse<NotificationResponse>>> getListNotifications(int currentPage);
}
