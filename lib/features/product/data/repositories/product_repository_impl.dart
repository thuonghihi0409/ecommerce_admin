import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<ListModel<Product>> getListProduct({
    String? search,
    String? categoryId,
    int? minPrice,
    int? maxPrice,
    String? storeId,
  }) async {
    final userModel = await remoteDataSource.getListProduct(
        search: search,
        categoryId: categoryId,
        maxPrice: maxPrice,
        minPrice: minPrice,
        storeId: storeId);
    return userModel;
  }

  @override
  Future<ProductDetail> getProductDetail(String id) async {
    final productdetail = await remoteDataSource.getProductDetail(id);
    return productdetail;
  }

  @override
  Future<Store> getStore() async {
    final store = await remoteDataSource.getStore();
    return store;
  }

  @override
  Future<List<Product>> getListProductSummerice(String categoryId) async {
    final productModels =
        await remoteDataSource.getListProductSummerice(categoryId);
    return productModels;
  }

  @override
  Future<List<Category>> getListCategory() async {
    final listCategory = await remoteDataSource.getListCategory();
    return listCategory;
  }
}
