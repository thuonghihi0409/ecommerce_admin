import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/profile/domain/repositories/profile_repository.dart';

class GetListStoreUsecase {
  final ProfileRepository repository;

  GetListStoreUsecase(this.repository);
  Future<List<Store>> call({required String userId}) {
    return repository.getStore(userId);
  }
}
