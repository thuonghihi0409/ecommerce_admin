import 'package:thuongmaidientu/features/user_management/data/datasources/user_mamagement_remote_datasource.dart';
import 'package:thuongmaidientu/features/user_management/data/repositories/user_management_repository_impl.dart';
import 'package:thuongmaidientu/features/user_management/domain/repositories/user_management_repository.dart';
import 'package:thuongmaidientu/features/user_management/domain/usecases/get_list_user_usecase.dart';
import 'package:thuongmaidientu/features/user_management/presentation/bloc/user_management_bloc/user_management_bloc.dart';
import 'package:thuongmaidientu/get_it.dart';

class UserManagementDependecy {
  static void init() {
    sl.registerFactory(
        () => UserManagementBloc(sl(), sl(), sl(), sl(), sl(), sl()));

    //// Product Management UseCase

    sl.registerLazySingleton(() => GetListUserUseCase(sl()));

    sl.registerLazySingleton<UserManagementRepository>(
        () => UserManagementRepositoryImpl(sl()));

    sl.registerLazySingleton<UserManagementRemoteDatasource>(
        () => UserManagementRemoteDataSourceImpl());
  }
}
