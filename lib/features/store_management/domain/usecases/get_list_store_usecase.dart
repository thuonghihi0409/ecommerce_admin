import 'package:thuongmaidientu/features/store_management/domain/entities/store_entity.dart';
import 'package:thuongmaidientu/features/store_management/domain/repositories/store_management_repository.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

class GetListStoreUseCase {
  final StoreManagementRepository repository;

  GetListStoreUseCase(this.repository);

  Future<ListModel<StoreEntity>?> call() {
    return repository.getListStore();
  }
}
