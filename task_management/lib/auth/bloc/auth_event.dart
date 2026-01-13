  abstract class AuthEvent {}

  class SignupUserWithEmail extends AuthEvent{}

  class LoginUserWithEmail extends AuthEvent{
    final String email, password;
  LoginUserWithEmail({required this.email, required this.password});
  }