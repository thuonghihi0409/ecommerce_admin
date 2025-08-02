import 'package:thuongmaidientu/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:thuongmaidientu/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:thuongmaidientu/features/profile/domain/repositories/profile_repository.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/add_address_usecase.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/create_store_usecase.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/get_address_usecase.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/get_list_store_usecase.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/get_provinces_usecase.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/get_wards_usecase.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/get_it.dart';

class ProfileDependecy {
  static void init() {
    sl.registerFactory(
        () => ProfileBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl()));

    //// Profile UseCase
    sl.registerLazySingleton(() => GetProfileUsecase(sl()));
    sl.registerLazySingleton(() => GetProvincesUsecase(sl()));
    sl.registerLazySingleton(() => GetAddressUsecase(sl()));
    sl.registerLazySingleton(() => GetWardsUsecase(sl()));
    sl.registerLazySingleton(() => AddAddressUsecase(sl()));
    sl.registerLazySingleton(() => GetListStoreUsecase(sl()));
    sl.registerLazySingleton(() => CreateStoreUsecase(sl()));

    sl.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(sl()));

    sl.registerLazySingleton<ProfileRemoteDatasource>(
        () => ProfileRemoteDataSourceImpl());
  }
}
