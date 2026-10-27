import 'package:bootx_app/core/error/failures.dart';
import 'package:bootx_app/features/auth/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  });
}
