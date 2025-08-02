part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthResumeSession extends AuthEvent {
  final Function(bool isResume, String? email) onSuccess;
  final Function(String) onError;
  const AuthResumeSession({required this.onSuccess, required this.onError});
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;
  final Function(String?)? onSuccess;
  final Function(String?)? onError;
  const AuthLogin(
      {required this.email,
      required this.password,
      this.onSuccess,
      this.onError});
}

class AuthLogout extends AuthEvent {
  final Function()? onSuccess;

  const AuthLogout({
    this.onSuccess,
  });
}

class AuthRegister extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final Function()? onSuccess;
  final Function(String?)? onError;
  const AuthRegister(
      {required this.email,
      required this.password,
      required this.name,
      this.onSuccess,
      this.onError});
}

class AuthSendVerifyEmail extends AuthEvent {
  final String email;

  final Function()? onSuccess;
  final Function(String?)? onError;
  const AuthSendVerifyEmail(
      {required this.email, this.onSuccess, this.onError});
}
