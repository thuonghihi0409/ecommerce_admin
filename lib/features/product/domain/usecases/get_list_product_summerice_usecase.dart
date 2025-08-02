import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetListProductSummericeUseCase {
  final ProductRepository repository;

  GetListProductSummericeUseCase(this.repository);

  Future<List<Product>?> call(String categoryId) {
    return repository.getListProductSummerice(categoryId);
  }
}
