import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<User?> login(String email, String password);
  Future<void> logout();

  Future<void> sendVerifyEmail(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();

  @override
  Future<User?> login(String email, String password) async {
    final user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return user.user;
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> sendVerifyEmail(String email) async {
    await FirebaseAuth.instance.currentUser?.sendEmailVerification();
  }
}
