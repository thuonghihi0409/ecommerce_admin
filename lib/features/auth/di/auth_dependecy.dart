import 'package:thuongmaidientu/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:thuongmaidientu/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:thuongmaidientu/features/auth/domain/repositories/auth_repository.dart';
import 'package:thuongmaidientu/features/auth/domain/usecases/login_usecase.dart';
import 'package:thuongmaidientu/features/auth/domain/usecases/logout_usecase.dart';
import 'package:thuongmaidientu/features/auth/domain/usecases/verify_email_usecase.dart';
import 'package:thuongmaidientu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:thuongmaidientu/get_it.dart';

class AuthDependecy {
  static void init() {
    sl.registerFactory(() => AuthBloc(
          sl(),
          sl(),
          sl(),
        ));

    //// Auth UseCase
    sl.registerLazySingleton(() => LoginUseCase(sl()));
    sl.registerLazySingleton(() => LogoutUseCase(sl()));

    sl.registerLazySingleton(() => SendVerifyEmailUsecase(sl()));

    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

    sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl());
  }
}
