import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/product/domain/repositories/product_repository.dart';

class GetStoreUsecase {
  final ProductRepository repository;

  GetStoreUsecase(this.repository);

  Future<Store?> call() {
    return repository.getStore();
  }
}
