class LoginState {
  final bool emailValid;
  final bool passwordValid;
  final bool loading;
  final String? message;
  final bool success;

  LoginState({
    required this.emailValid,
    required this.passwordValid,
    required this.loading,
    this.message,
    required this.success,
  });

  factory LoginState.initial() {
    return LoginState(
      emailValid: true,
      passwordValid: true,
      loading: false,
      message: null,
      success: false,
    );
  }

  LoginState copyWith({
    bool? emailValid,
    bool? passwordValid,
    bool? loading,
    String? message,
    bool? success,
  }) {
    return LoginState(
      emailValid: emailValid ?? this.emailValid,
      passwordValid: passwordValid ?? this.passwordValid,
      loading: loading ?? this.loading,
      message: message,
      success: success ?? this.success,
    );
  }
}
