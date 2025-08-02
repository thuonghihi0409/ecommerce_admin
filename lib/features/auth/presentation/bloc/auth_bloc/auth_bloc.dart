import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:thuongmaidientu/core/app_constraint.dart';
import 'package:thuongmaidientu/features/auth/domain/usecases/login_usecase.dart';
import 'package:thuongmaidientu/features/auth/domain/usecases/logout_usecase.dart';
import 'package:thuongmaidientu/features/auth/domain/usecases/verify_email_usecase.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  LoginUseCase loginUseCase;
  LogoutUseCase logoutUseCase;

  SendVerifyEmailUsecase sendVerifyEmailUsecase;
  AuthBloc(this.loginUseCase, this.sendVerifyEmailUsecase, this.logoutUseCase)
      : super(AuthState.empty()) {
    on<AuthResumeSession>(authResumeSession);
    on<AuthLogin>(authLogin);
    on<AuthLogout>(authLogout);

    on<AuthSendVerifyEmail>(authSendVerifyEmail);
  }
  void authResumeSession(AuthResumeSession event, Emitter<AuthState> emit) {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // get profile
        event.onSuccess.call(true, user.email);
      } else {
        event.onSuccess.call(false, user?.email);
      }
    } catch (e) {
      log("error 1 ==${ParseError.fromJson(e).message}");
      event.onError.call(ParseError.fromJson(e).message);
    }
  }

  void authLogin(AuthLogin event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result =
          await loginUseCase.call(email: event.email, password: event.password);

      emit(state.copyWith(isLoading: false));
      if (!(result.isVerify ?? false)) {
        event.onSuccess?.call(AppConstraint.isNotVerify);
        return;
      }
      if (result.id != null) {
        event.onSuccess?.call(AppConstraint.login);
        return;
      }

      event.onSuccess?.call(AppConstraint.loginFailed);
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(isLoading: false));
      event.onError?.call(e.message);
    }
  }

  void authLogout(AuthLogout event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      await logoutUseCase.call();

      emit(state.copyWith(isLoading: false));
      event.onSuccess?.call();
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(isLoading: false));
      Helper.showToastBottom(message: e.message ?? "");
    }
  }

  void authSendVerifyEmail(
      AuthSendVerifyEmail event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      log("before send");
      final result = await sendVerifyEmailUsecase.call(email: event.email);
      log("affter send");
      emit(state.copyWith(isLoading: false));
      event.onSuccess?.call();
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(isLoading: false));
      event.onError?.call(e.message);
    }
  }
}
