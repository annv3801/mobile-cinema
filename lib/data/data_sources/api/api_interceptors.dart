import 'package:cinemax/data/data_sources/storages/shared_preferences.dart';
import 'package:dio/dio.dart';

class ApiInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final userToken = await SharedPreferencesHelper.getStringValue(SharedPreferencesHelper.userToken);
    if (userToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $userToken';
    }

    return super.onRequest(options, handler);
  }
}
