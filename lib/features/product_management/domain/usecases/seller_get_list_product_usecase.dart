import 'package:thuongmaidientu/features/product_management/domain/entities/seller_product.dart';
import 'package:thuongmaidientu/features/product_management/domain/repositories/product_management_repository.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

class SellerGetListProductUseCase {
  final ProductManagementRepository repository;

  SellerGetListProductUseCase(this.repository);

  Future<ListModel<SellerProduct>?> call(String? storeId) {
    return repository.getListProduct(storeId);
  }
}
