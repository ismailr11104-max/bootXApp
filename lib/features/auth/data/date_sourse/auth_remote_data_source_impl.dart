import 'package:bootx_app/core/services/network/api_constance.dart';
import 'package:bootx_app/core/services/network/auth_api_service.dart';
import 'package:bootx_app/features/auth/data/date_sourse/auth_remote_data_source.dart';
import 'package:bootx_app/features/auth/data/model/auth_response_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiService _apiService;

  AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<AuthResponseModel> sigIn({
    required String email,
    required String password,
  }) async {
    final response = await _apiService.post(
      ApiConstance.authSignIn,
      body: {'email': email, 'password': password},
    );

    return AuthResponseModel.fromJson(response);
  }

  @override
  Future<AuthResponseModel> sigUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    final response = await _apiService.post(
      ApiConstance.authSignUp,
      body: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    );
    return AuthResponseModel.fromJson(response);
  }
}
