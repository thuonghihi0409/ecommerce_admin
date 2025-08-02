import 'package:thuongmaidientu/features/profile/domain/entities/ward_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/repositories/profile_repository.dart';

class GetWardsUsecase {
  final ProfileRepository repository;

  GetWardsUsecase(this.repository);
  Future<List<WardEntity>> call({required String id}) {
    return repository.getWard(id);
  }
}
