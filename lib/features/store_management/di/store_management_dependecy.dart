import 'package:thuongmaidientu/features/store_management/data/datasources/store_mamagement_remote_datasource.dart';
import 'package:thuongmaidientu/features/store_management/data/repositories/store_management_repository_impl.dart';
import 'package:thuongmaidientu/features/store_management/domain/repositories/store_management_repository.dart';
import 'package:thuongmaidientu/features/store_management/domain/usecases/get_list_store_usecase.dart';
import 'package:thuongmaidientu/features/store_management/presentation/bloc/store_management_bloc/store_management_bloc.dart';
import 'package:thuongmaidientu/get_it.dart';

class StoreManagementDependecy {
  static void init() {
    sl.registerFactory(() => StoreManagementBloc(
          sl(),
        ));

    //// Product Management UseCase

    sl.registerLazySingleton(() => GetListStoreUseCase(sl()));

    sl.registerLazySingleton<StoreManagementRepository>(
        () => StoreManagementRepositoryImpl(sl()));

    sl.registerLazySingleton<StoreManagementRemoteDatasource>(
        () => StoreManagementRemoteDataSourceImpl());
  }
}
