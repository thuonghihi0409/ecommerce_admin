import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/store_management/domain/entities/store_entity.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../../domain/repositories/store_management_repository.dart';
import '../datasources/store_mamagement_remote_datasource.dart';

class StoreManagementRepositoryImpl implements StoreManagementRepository {
  final StoreManagementRemoteDatasource remoteDataSource;

  StoreManagementRepositoryImpl(this.remoteDataSource);

  @override
  Future<ListModel<StoreEntity>> getListStore() async {
    final userModel = await remoteDataSource.getListStore();
    return userModel;
  }

  @override
  Future<ProductDetail> getProductDetail(String id) async {
    final productdetail = await remoteDataSource.getProductDetail(id);
    return productdetail;
  }

  @override
  Future<List<Category>> getListCategory() async {
    final listCategory = await remoteDataSource.getListCategory();
    return listCategory;
  }

  @override
  Future<void> createProductDetail(ProductDetail product) async {
    await remoteDataSource.createProductDetail(product);
  }

  @override
  Future<void> updateProduct(ProductDetail product) async {
    await remoteDataSource.updateProduct(product);
  }

  @override
  Future<void> updateVariants(List<Variant> variants) async {
    await remoteDataSource.updateVariants(variants);
  }
}
