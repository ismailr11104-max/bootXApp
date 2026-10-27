import 'package:bootx_app/core/error/exceptions.dart';
import 'package:bootx_app/core/services/network/auth_api_service.dart';
import 'package:dio/dio.dart';

class AuthApiServiceImpl implements AuthApiService {
  final Dio dio;

  AuthApiServiceImpl(this.dio);

  @override
  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    try {
      final response = await dio.post(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  AppException _handleDioError(DioException error) {
    final statusCode = error.response?.statusCode;
    final serverMessage = _extractServerMessage(error.response?.data);

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          'Connection to the server timed out',
          error.type.name,
        );

      case DioExceptionType.transformTimeout:
        return NetworkException('Data processing timed out', error.type.name);

      case DioExceptionType.connectionError:
        return NetworkException(
          'Unable to connect to the internet or server',
          'connection_error',
        );

      case DioExceptionType.badCertificate:
        return NetworkException(
          'Unable to verify the server security certificate',
          'bad_certificate',
        );

      case DioExceptionType.cancel:
        return NetworkException('Request was cancelled', 'cancelled');

      case DioExceptionType.badResponse:
        final message = serverMessage ?? _defaultMessage(statusCode);

        if (statusCode == 400 || statusCode == 422) {
          return ValidationException(message, statusCode.toString());
        }

        if (statusCode == 401 || statusCode == 403) {
          return AuthException(message, statusCode.toString());
        }

        return ServerException(message, statusCode?.toString());

      case DioExceptionType.unknown:
        return ServerException(
          serverMessage ?? 'An unexpected network error occurred',
          error.type.name,
        );
    }
  }

  String? _extractServerMessage(Object? data) {
    if (data is Map) {
      final message = data['message'] ?? data['error'] ?? data['detail'];

      if (message != null && message.toString().trim().isNotEmpty) {
        return message.toString();
      }
    }

    return null;
  }

  String _defaultMessage(int? statusCode) {
    if (statusCode == null) {
      return 'Unable to complete the request';
    }

    if (statusCode == 404) {
      return 'The requested resource was not found';
    }

    if (statusCode >= 500) {
      return 'A server error occurred. Please try again later';
    }

    return 'Unable to complete the request. Status code: $statusCode';
  }
}
