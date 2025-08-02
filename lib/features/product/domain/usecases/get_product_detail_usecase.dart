import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product/domain/repositories/product_repository.dart';

class GetProductDetailUsecase {
  final ProductRepository repository;

  GetProductDetailUsecase(this.repository);

  Future<ProductDetail?> call(String id) {
    return repository.getProductDetail(id);
  }
}
