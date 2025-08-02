import 'package:thuongmaidientu/features/order_management.dart/data/datasources/order_management_remote_datasource.dart';
import 'package:thuongmaidientu/features/order_management.dart/data/repositories/order_management_repository_impl.dart';
import 'package:thuongmaidientu/features/order_management.dart/domain/repositories/order_management_repository.dart';
import 'package:thuongmaidientu/features/order_management.dart/domain/usecases/seller_get_list_order_usecase.dart';
import 'package:thuongmaidientu/features/order_management.dart/domain/usecases/update_order_usecase.dart';
import 'package:thuongmaidientu/features/order_management.dart/presentation/bloc/order_management_bloc/order_management_bloc.dart';
import 'package:thuongmaidientu/get_it.dart';

class OrderManagementDependecy {
  static void init() {
    sl.registerFactory(() => OrderManagementBloc(sl(), sl()));

    //// Order Management usecase
    sl.registerLazySingleton(() => SellerGetListOrderUsecase(sl()));
    sl.registerLazySingleton(() => SellerUpdateOrderUsecase(sl()));

    sl.registerLazySingleton<OrderManagementRepository>(
        () => OrderManagementRepositoryImpl(sl()));
    sl.registerLazySingleton<OrderManagementRemoteDatasource>(
        () => OrderManagementRemoteDataSourceImpl());
  }
}
