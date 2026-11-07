abstract class ApiService {
  Future<T> post<T>(String endpoint, {Map<String, dynamic>? body});
  Future<T> get<T>(String endpoint, {Map<String, dynamic>? queryParameters});
}
