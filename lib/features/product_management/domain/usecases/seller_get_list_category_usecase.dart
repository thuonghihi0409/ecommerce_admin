import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product_management/domain/repositories/product_management_repository.dart';

class SellerGetListCategoryUseCase {
  final ProductManagementRepository repository;

  SellerGetListCategoryUseCase(this.repository);

  Future<List<Category>?> call() {
    return repository.getListCategory();
  }
}
