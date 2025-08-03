import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product_management/domain/repositories/product_management_repository.dart';

class SellerUpdateProductUseCase {
  final ProductManagementRepository repository;

  SellerUpdateProductUseCase(this.repository);

  Future<void> call(ProductDetail product) {
    return repository.updateProduct(product);
  }
}
