import 'package:bootx_app/core/services/network/api_dio_config.dart';
import 'package:bootx_app/core/services/network/auth_api_service.dart';
import 'package:bootx_app/core/services/network/auth_api_service_impl.dart';
import 'package:bootx_app/features/auth/data/date_sourse/auth_remote_data_source.dart';
import 'package:bootx_app/features/auth/data/date_sourse/auth_remote_data_source_impl.dart';
import 'package:bootx_app/features/auth/data/repo/auth_repository_impl.dart';
import 'package:bootx_app/features/auth/domain/repo/auth_repository.dart';
import 'package:bootx_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<Dio>(() => ApiDioConfig.createDio());

  getIt.registerLazySingleton<AuthApiService>(
    () => AuthApiServiceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<AuthApiService>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt<AuthRemoteDataSource>()),
  );

  getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt<AuthRepository>()));
}
