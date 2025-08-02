import 'package:thuongmaidientu/features/product_management/data/datasources/product_mamagement_remote_datasource.dart';
import 'package:thuongmaidientu/features/product_management/data/repositories/product_management_repository_impl.dart';
import 'package:thuongmaidientu/features/product_management/domain/repositories/product_management_repository.dart';
import 'package:thuongmaidientu/features/product_management/domain/usecases/create_product_usecase.dart';
import 'package:thuongmaidientu/features/product_management/domain/usecases/seller_get_list_category_usecase.dart';
import 'package:thuongmaidientu/features/product_management/domain/usecases/seller_get_list_product_usecase.dart';
import 'package:thuongmaidientu/features/product_management/domain/usecases/seller_get_product_detail_usecase.dart';
import 'package:thuongmaidientu/features/product_management/domain/usecases/seller_update_product_usecase.dart';
import 'package:thuongmaidientu/features/product_management/domain/usecases/seller_update_variant_usecase.dart';
import 'package:thuongmaidientu/features/product_management/presentation/bloc/product_management_bloc/product_management_bloc.dart';
import 'package:thuongmaidientu/get_it.dart';

class ProductManagementDependecy {
  static void init() {
    sl.registerFactory(
        () => ProductManagementBloc(sl(), sl(), sl(), sl(), sl(), sl()));

    //// Product Management UseCase
    sl.registerLazySingleton(() => CreateProductUsecase(sl()));
    sl.registerLazySingleton(() => SellerGetListProductUseCase(sl()));
    sl.registerLazySingleton(() => SellerGetProductDetailUsecase(sl()));
    sl.registerLazySingleton(() => SellerGetListCategoryUseCase(sl()));
    sl.registerLazySingleton(() => SellerUpdateProductUseCase(sl()));
    sl.registerLazySingleton(() => SellerUpdateVariantUseCase(sl()));

    sl.registerLazySingleton<ProductManagementRepository>(
        () => ProductManagementRepositoryImpl(sl()));

    sl.registerLazySingleton<ProductManagementRemoteDatasource>(
        () => ProductManagementRemoteDataSourceImpl());
  }
}
