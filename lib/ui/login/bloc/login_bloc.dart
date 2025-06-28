import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:halaqat_wasl_driver_app/ui/login/bloc/login_event.dart';
import 'package:halaqat_wasl_driver_app/ui/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginBloc() : super(LoginState.initial()) {
    on<EmailChanged>((event, emit) {
      final isValid = _isValidEmail(event.value);
      emit(
        state.copyWith(
          emailValid: isValid,
          message: isValid ? null : "log_in_screen.valid_email".tr(),
          success: false,
        ),
      );
    });

    on<PasswordChanged>((event, emit) {
      final isValid = _isValidPassword(event.value);
      emit(
        state.copyWith(
          passwordValid: isValid,
          message: isValid ? null : "log_in_screen.valid_password".tr(),
          success: false,
        ),
      );
    });

    on<LoginSubmitted>(_onLogin);
  }

  void _onLogin(LoginSubmitted event, Emitter<LoginState> emit) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final isEmailOk = _isValidEmail(email);
    final isPasswordOk = _isValidPassword(password);

    if (!isEmailOk || !isPasswordOk) {
      emit(
        state.copyWith(
          emailValid: isEmailOk,
          passwordValid: isPasswordOk,
          message: !isEmailOk
              ? "log_in_screen.valid_email".tr()
              : "log_in_screen.valid_password".tr(),
          success: false,
        ),
      );
      return;
    }

    emit(state.copyWith(loading: true, message: null));

    await Future.delayed(const Duration(seconds: 1));

    if (password == "123456") {
      emit(
        state.copyWith(
          loading: false,
          message: "log_in_screen.login_success".tr(),
          success: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          loading: false,
          message: "log_in_screen.invalid_credentials".tr(),
          success: false,
        ),
      );
    }
  }

  bool _isValidEmail(String email) =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

  bool _isValidPassword(String password) => password.length >= 6;

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
