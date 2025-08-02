import 'package:thuongmaidientu/features/product/domain/entities/category.dart';

import '../repositories/product_repository.dart';

class GetListCategoryUseCase {
  final ProductRepository repository;

  GetListCategoryUseCase(this.repository);

  Future<List<Category>?> call() {
    return repository.getListCategory();
  }
}
