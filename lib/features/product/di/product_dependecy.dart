import 'package:thuongmaidientu/features/product/data/datasources/product_remote_datasource.dart';
import 'package:thuongmaidientu/features/product/data/repositories/product_repository_impl.dart';
import 'package:thuongmaidientu/features/product/domain/repositories/product_repository.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_list_category_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_list_product_summerice_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_list_product_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_product_detail_usecase.dart';
import 'package:thuongmaidientu/features/product/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:thuongmaidientu/get_it.dart';

class ProductDependecy {
  static void init() {
    sl.registerFactory(() => ProductBloc(
          sl(),
          sl(),
          sl(),
          sl(),
        ));

    //// Product UseCase
    sl.registerLazySingleton(() => GetListProductUseCase(sl()));
    sl.registerLazySingleton(() => GetProductDetailUsecase(sl()));
    sl.registerLazySingleton(() => GetListProductSummericeUseCase(sl()));

    sl.registerLazySingleton(() => GetListCategoryUseCase(sl()));

    sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(sl()));

    sl.registerLazySingleton<ProductRemoteDatasource>(
        () => ProductRemoteDataSourceImpl());
  }
}
