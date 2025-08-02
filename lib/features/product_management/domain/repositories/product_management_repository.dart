import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product_management/domain/entities/seller_product.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class ProductManagementRepository {
  Future<ListModel<SellerProduct>> getListProduct(String? storeId);
  Future<ProductDetail> getProductDetail(String id);
  Future<List<Category>> getListCategory();
  Future<void> createProductDetail(ProductDetail product);
  Future<void> updateVariants(List<Variant> variants);
  Future<void> updateProduct(ProductDetail product);
}
