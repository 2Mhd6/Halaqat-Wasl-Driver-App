import 'package:halaqat_wasl_driver_app/model/driver%20model/driver_model.dart';

class LoginState {
  final bool loading;
  final bool emailValid;
  final bool passwordValid;
  final String? message;
  final bool success;
  final DriverModel? driver;

  const LoginState({
    required this.loading,
    required this.emailValid,
    required this.passwordValid,
    this.message,
    required this.success,
    this.driver,
  });

  factory LoginState.initial() {
    return const LoginState(
      loading: false,
      emailValid: true,
      passwordValid: true,
      success: false,
      message: null,
      driver: null,
    );
  }

  LoginState copyWith({
    bool? loading,
    bool? emailValid,
    bool? passwordValid,
    String? message,
    bool? success,
    DriverModel? driver,
  }) {
    return LoginState(
      loading: loading ?? this.loading,
      emailValid: emailValid ?? this.emailValid,
      passwordValid: passwordValid ?? this.passwordValid,
      message: message,
      success: success ?? this.success,
      driver: driver ?? this.driver,
    );
  }
}