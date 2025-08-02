import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/profile/domain/repositories/profile_repository.dart';

class CreateStoreUsecase {
  final ProfileRepository repository;

  CreateStoreUsecase(this.repository);
  Future<Store> call({required Store store, required String userId}) {
    return repository.createStore(store, userId);
  }
}
