part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final User? user;
  const AuthState({this.isLoading = false, this.user});
  factory AuthState.empty() {
    return const AuthState(isLoading: false, user: null);
  }

  AuthState copyWith({bool? isLoading, User? user}) {
    return AuthState(
        isLoading: isLoading ?? this.isLoading, user: user ?? this.user);
  }

  @override
  List<Object?> get props => [isLoading, user];
}
