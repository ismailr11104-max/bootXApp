import 'package:bootx_app/features/auth/data/model/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> sigIn({
    required String email,
    required String password,
  });

  Future<AuthResponseModel> sigUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  });
}
