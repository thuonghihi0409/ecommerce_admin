import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/user_management/domain/entities/user_entity.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../../domain/repositories/user_management_repository.dart';
import '../datasources/user_mamagement_remote_datasource.dart';

class UserManagementRepositoryImpl implements UserManagementRepository {
  final UserManagementRemoteDatasource remoteDataSource;

  UserManagementRepositoryImpl(this.remoteDataSource);

  @override
  Future<ListModel<UserEntity>> getListProduct() async {
    final userModel = await remoteDataSource.getListUser();
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
