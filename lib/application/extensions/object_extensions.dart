import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

extension ObjectExtensions on Object {
  String get toMessage {
    if (this is DioException) {
      final error = this as DioException;

      final message = error.response?.data["message"] as String?;

      return message ?? tr("serverConnectionError");
    }

    return tr("somethingWentWrong");
  }
}
