import 'package:thuongmaidientu/features/user_management/domain/entities/user_entity.dart';
import 'package:thuongmaidientu/features/user_management/domain/repositories/user_management_repository.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

class GetListUserUseCase {
  final UserManagementRepository repository;

  GetListUserUseCase(this.repository);

  Future<ListModel<UserEntity>?> call() {
    return repository.getListProduct();
  }
}
