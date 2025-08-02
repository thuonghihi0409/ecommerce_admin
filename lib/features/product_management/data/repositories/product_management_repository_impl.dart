import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product_management/domain/entities/seller_product.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../../domain/repositories/product_management_repository.dart';
import '../datasources/product_mamagement_remote_datasource.dart';

class ProductManagementRepositoryImpl implements ProductManagementRepository {
  final ProductManagementRemoteDatasource remoteDataSource;

  ProductManagementRepositoryImpl(this.remoteDataSource);

  @override
  Future<ListModel<SellerProduct>> getListProduct(String? storeId) async {
    final userModel = await remoteDataSource.getListProduct(storeId);
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
