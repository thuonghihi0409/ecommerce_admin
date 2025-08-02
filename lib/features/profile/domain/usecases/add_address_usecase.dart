import 'package:thuongmaidientu/features/profile/domain/entities/address_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/repositories/profile_repository.dart';

class AddAddressUsecase {
  final ProfileRepository repository;

  AddAddressUsecase(this.repository);
  Future<AddressEntity> call(
      {required AddressEntity addAddress, required String id}) {
    return repository.addAddress(addAddress, id);
  }
}
