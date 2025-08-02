import 'package:thuongmaidientu/features/profile/domain/entities/province_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/repositories/profile_repository.dart';

class GetProvincesUsecase {
  final ProfileRepository repository;

  GetProvincesUsecase(this.repository);
  Future<List<ProvinceEntity>> call() {
    return repository.getProvince();
  }
}
