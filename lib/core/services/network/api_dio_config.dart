import 'package:bootx_app/core/services/network/api_constance.dart';
import 'package:dio/dio.dart';

class ApiDioConfig {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstance.baseUrl,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    return dio;
  }
}
