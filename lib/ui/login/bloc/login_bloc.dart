import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:halaqat_wasl_driver_app/repo/authentication/authentication.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Authentication _loginRepository;

  LoginBloc(this._loginRepository) : super(LoginState.initial()) {
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

  Future<void> _onLogin(LoginSubmitted event, Emitter<LoginState> emit) async {
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

    try {
      final (user, driver) = await _loginRepository.loginWithEmailAndPassword(
        email,
        password,
      );

      if (user == null) {
        emit(
          state.copyWith(
            loading: false,
            message: "log_in_screen.invalid_credentials".tr(),
            success: false,
          ),
        );
        return;
      }

      if (driver == null) {
        emit(
          state.copyWith(
            loading: false,
            message: "log_in_screen.driver_not_found".tr(),
            success: false,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          loading: true,
          success: true,
          message: "log_in_screen.login_success".tr(),
          driver: driver,
        ),
      );
    } catch (_) {
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
}
