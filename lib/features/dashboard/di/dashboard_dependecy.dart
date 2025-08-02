import 'package:thuongmaidientu/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:thuongmaidientu/features/dashboard/data/repositories/seller_dashboard_repository_impl.dart';
import 'package:thuongmaidientu/features/dashboard/domain/repositories/seller_dashboard_repository.dart';
import 'package:thuongmaidientu/features/dashboard/domain/usecases/seller_get_dashboard_cart_usecase.dart';
import 'package:thuongmaidientu/features/dashboard/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:thuongmaidientu/get_it.dart';

class DashboardDependecy {
  static void init() {
    sl.registerFactory(() => DashboardBloc(sl()));

    //// Dashboard usecase
    sl.registerLazySingleton(() => SellerGetDashboardCartUsecase(sl()));

    sl.registerLazySingleton<SellerDashboardRepository>(
        () => SellerDashboardRepositoryImpl(sl()));

    sl.registerLazySingleton<DashboardRemoteDatasource>(
        () => DashboardRemoteDataSourceImpl());
  }
}
