import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product_management/domain/repositories/product_management_repository.dart';

class CreateProductUsecase {
  final ProductManagementRepository productManagementRepository;

  CreateProductUsecase(this.productManagementRepository);
  Future<void> call(ProductDetail product) async {
    await productManagementRepository.createProductDetail(product);
  }
}
