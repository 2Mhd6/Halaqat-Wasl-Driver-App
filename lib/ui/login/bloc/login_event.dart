abstract class LoginEvent {}

class EmailChanged extends LoginEvent {
  final String value; // new email input
  EmailChanged(this.value);
}

class PasswordChanged extends LoginEvent {
  final String value; // new password input
  PasswordChanged(this.value);
}

class LoginSubmitted extends LoginEvent {} // login button pressed