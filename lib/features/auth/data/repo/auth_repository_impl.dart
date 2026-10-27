import 'package:bootx_app/core/error/exceptions.dart';
import 'package:bootx_app/core/error/failures.dart';
import 'package:bootx_app/features/auth/data/date_sourse/auth_remote_data_source.dart';
import 'package:bootx_app/features/auth/domain/entity/user_entity.dart';
import 'package:bootx_app/features/auth/domain/repo/auth_repository.dart';

import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final authResponse = await remoteDataSource.sigIn(
        email: email,
        password: password,
      );

      // ملاحظة: يمكنك حفظ authResponse.accessToken هنا عبر LocalDataSource مستقبلاً

      return Right(authResponse.user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final authResponse = await remoteDataSource.sigUp(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );

      return Right(authResponse.user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }
}