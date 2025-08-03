import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/user_management/domain/entities/user_entity.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class UserManagementRepository {
  Future<ListModel<UserEntity>> getListProduct();
  Future<ProductDetail> getProductDetail(String id);
  Future<List<Category>> getListCategory();
  Future<void> createProductDetail(ProductDetail product);
  Future<void> updateVariants(List<Variant> variants);
  Future<void> updateProduct(ProductDetail product);
}
