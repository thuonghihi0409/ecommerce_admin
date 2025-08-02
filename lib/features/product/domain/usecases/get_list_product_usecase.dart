import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetListProductUseCase {
  final ProductRepository repository;

  GetListProductUseCase(this.repository);

  Future<ListModel<Product>?> call({
    String? search,
    String? categoryId,
    int? minPrice,
    int? maxPrice,
    String? storeId,
  }) {
    return repository.getListProduct(
        search: search,
        categoryId: categoryId,
        maxPrice: maxPrice,
        minPrice: minPrice,
        storeId: storeId);
  }
}
