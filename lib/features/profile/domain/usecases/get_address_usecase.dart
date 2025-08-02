import 'package:thuongmaidientu/features/profile/domain/entities/address_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/repositories/profile_repository.dart';

class GetAddressUsecase {
  final ProfileRepository repository;

  GetAddressUsecase(this.repository);
  Future<List<AddressEntity>> call({required String id}) {
    return repository.getAddress(id);
  }
}
