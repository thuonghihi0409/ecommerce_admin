import '../repositories/auth_repository.dart';

class SendVerifyEmailUsecase {
  final AuthRepository repository;

  SendVerifyEmailUsecase(this.repository);
  Future<void> call({required String email}) {
    return repository.sendVerifyEmail(email);
  }
}
