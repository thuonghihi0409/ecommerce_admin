import 'package:thuongmaidientu/features/profile/domain/entities/profile_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUsecase {
  final ProfileRepository repository;

  GetProfileUsecase(this.repository);
  Future<ProfileEntity> call({required String email}) {
    return repository.getProfile(email);
  }
}
