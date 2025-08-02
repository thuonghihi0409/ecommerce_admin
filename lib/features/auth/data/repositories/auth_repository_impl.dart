import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> login(String email, String password) async {
    final userModel = await remoteDataSource.login(email, password);
    return UserEntity(
        id: userModel?.uid,
        email: userModel?.email,
        isVerify: userModel?.emailVerified);
  }

  @override
  Future<void> sendVerifyEmail(String email) async {
    await remoteDataSource.sendVerifyEmail(email);
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }
}
